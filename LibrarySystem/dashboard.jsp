<%@ page import="java.sql.*" %> 
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM books LIMIT 5");
%>
<html>
<head>
    <title>Hogwarts Library Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-image: url('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?fm=jpg&q=60&w=3000');
            background-size: cover;
            background-position: center;
            color: #f0f0f5;
        }
        .navbar {
            background-color: #caa96893;
            overflow: hidden;
            padding: 10px 40px;
        }
        .navbar h1 {
            float: left;
            color: #f9f9f9;
            margin: 0;
            font-size: 22px;
        }
        .navbar a {
            float: right;
            color: #f9f9f9;
            text-decoration: none;
            padding: 10px 15px;
            font-weight: bold;
        }
        .navbar a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }
        .center-box {
            text-align: center;
            margin-top: 120px;
        }
        .time {
            font-size: 80px;
            font-weight: bold;
            color: #ececec;
        }
        .quote {
            font-style: italic;
            margin-top: 10px;
            font-size: 30px;
        }
        .search-bar {
            margin-top: 30px;
        }
        .search-bar input {
            padding: 10px;
            width: 550px;
            border-radius: 20px;
            border: none;
            height: 50px;
        }
        .search-bar button {
            padding: 10px 20px;
            background-color: #a37228cb;
            color: #ececec;
            border: none;
            border-radius: 20px;
            margin-left: 10px;
            cursor: pointer;
            height: 50px;
        }
        .white-section {
            margin-top: 50px;
            background-color: #ececec;
            color: black;
            padding: 40px;
            text-align: center;
            border-top-left-radius: 30px;
            border-top-right-radius: 30px;
        }
        .white-section h3 {
            margin-bottom: 10px;
        }
        .book-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }
        .book-card {
            background-color: #ececec;
            padding: 15px;
            width: 200px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: left;
        }
        .book-card img {
            width: 100%;
            height: 250px;
            object-fit: contain;
            background-color: #fff;
            border-radius: 8px;
            margin-bottom: 10px;
            cursor: pointer;
        }
        .book-card a {
            text-decoration: none;
            color: inherit;
        }
        .footer {
            background-color: #caa968;
            color: #ececec;
            text-align: center;
            padding: 10px;
            margin-top: 40px;
        }
        /* MODAL STYLING */
        .modal-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 999;
        }
        .modal-content {
            background-color: #fff;
            color: black;
            padding: 30px;
            width: 80%;
            max-width: 900px;
            border-radius: 20px;
            overflow-y: auto;
            max-height: 90vh;
            position: relative;
        }
        .modal-close {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            color: #333;
        }
    </style>

    <script>
        function updateTime() {
            const now = new Date();
            document.getElementById("clock").innerHTML = now.toLocaleTimeString();
        }
        setInterval(updateTime, 1000);
        window.onload = updateTime;

        function showBookDetail(id) {
            const modal = document.getElementById("bookModal");
            const content = document.getElementById("modalContent");
            fetch('book_detail.jsp?id=' + id)
                .then(response => response.text())
                .then(html => {
                    content.innerHTML = '<span class="modal-close" onclick="closeModal()">&times;</span>' + html;
                    modal.style.display = "flex";
                });
        }

        function closeModal() {
            document.getElementById("bookModal").style.display = "none";
        }
    </script>
</head>
<body>
    <div class="navbar">
        <h1>Hogwarts Library</h1>
        <a href="login.jsp">Admin Login</a>
        <a href="dashboard.jsp">Home</a>
    </div>

    <div class="center-box">
        <div class="time" id="clock">--:--:--</div>
        <div class="quote">"Do it for your future self"</div>
        <div class="search-bar">
            <form method="get">
                <input type="text" name="keyword" placeholder="Enter Keyword to Search Collection ..." />
                <button type="submit">Search</button>
            </form>
        </div>
    </div>

    <div class="white-section">
        <%
        String keyword = request.getParameter("keyword");
        if (keyword != null && !keyword.trim().equals("")) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");
                String sql2 = "SELECT * FROM books WHERE title LIKE ? OR author LIKE ? OR genre LIKE ? OR tags LIKE ?";
                PreparedStatement stmt2 = conn2.prepareStatement(sql2);
                String search = "%" + keyword + "%";
                for (int i = 1; i <= 4; i++) {
                    stmt2.setString(i, search);
                }
                ResultSet rs2 = stmt2.executeQuery();
        %>
            <div class="book-grid">
                <%
                boolean found = false;
                while (rs2.next()) {
                    found = true;
                %>
                    <div class="book-card">
                        <img src="<%= rs2.getString("image_url") %>" alt="Book Cover" onclick="showBookDetail('<%= rs2.getString("id") %>')" />
                        <strong><%= rs2.getString("title") %></strong><br/>
                        <small>Author: <%= rs2.getString("author") %></small><br/>
                        <small>Genre: <%= rs2.getString("genre") %></small><br/>
                        <small>Availability: <%= rs2.getString("availability") %></small>
                    </div>
                <% } 
                if (!found) {
                %>
                    <p><i>No books found matching your keyword.</i></p>
                <% } 
                rs2.close(); stmt2.close(); conn2.close(); 
                %>
            </div>
        <%
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
        } else {
        %>
            <div class="book-grid">
                <% while(rs.next()) { %>
                    <div class="book-card">
                        <img src="<%= rs.getString("image_url") %>" alt="Book Cover" onclick="showBookDetail('<%= rs.getString("id") %>')" />
                        <strong><%= rs.getString("title") %></strong><br/>
                        <small>Author: <%= rs.getString("author") %></small><br/>
                        <small>Genre: <%= rs.getString("genre") %></small><br/>
                        <small>Availability: <%= rs.getString("availability") %></small>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>

    <div class="footer">
        © 2025 Hogwarts Library. All rights reserved.
    </div>

    <!-- MODAL -->
    <div class="modal-bg" id="bookModal">
        <div class="modal-content" id="modalContent">
            <!-- Book detail will be loaded here -->
        </div>
    </div>
</body>
</html>

<%
    rs.close();
    stmt.close();
    conn.close();
%>
