<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Book</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        .navbar {
            background: linear-gradient(to right, #d7ccc8, #5d4037);
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h1 {
            margin: 0;
            font-size: 24px;
            font-weight: 500;
        }

        .navbar a {
            color: white;
            margin-left: 30px;
            text-decoration: none;
            font-size: 18px;
            position: relative;
            transition: color 0.3s ease;
        }

        .navbar a:hover,
        .navbar a:focus {
            color: #ffd700;
        }

        .container {
            padding: 30px;
        }

        .search-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .search-bar input[type="text"] {
            padding: 15px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 8px;
            width: 100%;
            max-width: 600px;
        }

        .search-bar select {
            padding: 15px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            width: 255px;
        }

        .form-group {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        input[type="submit"], .add-btn, .reset-btn {
            padding: 10px 20px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
        }

        input[type="submit"] {
            background-color: #ccb69b;
        }

        input[type="submit"]:hover {
            background-color: #b99e82;
        }

        .add-btn {
            background-color: #66946a;
            color: white;
        }

        .add-btn:hover {
            background-color: #567b59;
        }

        .reset-btn {
            background-color: #e0e0e0;
            color: #333;
        }

        .reset-btn:hover {
            background-color: #cfcfcf;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            table-layout: fixed;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 17px 15px;
            text-align: center;
        }

        table th {
            background-color: #e6dbb8;
        }

        table td {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        a.edit-btn, a.delete-btn {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
        }

        a.edit-btn {
            background-color: #45a049;
            color: white;
        }

        a.edit-btn:hover {
            background-color: #29752b;
        }

        a.delete-btn {
            background-color: #f44336;
            color: white;
        }

        a.delete-btn:hover {
            background-color: #8f2922;
        }

        .no-result {
            padding: 10px;
            color: #555;
            font-style: italic;
        }
    </style>
</head>
<body>

<div class="navbar">
    <h1>ADMIN USER</h1>
    <div>
        <a href="admin_dashboard.jsp">Home</a>
        <a href="issue_book.jsp">Borrowed</a>
        <a href="login.jsp">Log out</a>
    </div>
</div>

<div class="container">
    <form method="get">
        <div class="search-bar">
            <div class="form-group">
                <input type="text" name="keyword" placeholder="Search by title, author, or genre..." value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>"/>
                <select name="category">
                    <option>All Categories</option>
                    <option>Computing</option>
                    <option>Business</option>
                    <option>Fiction</option>
                    <option>Historical</option>
                </select>
                <input type="submit" value="Search" />
                <a href="manage_book.jsp" class="reset-btn">Reset</a>
            </div>
            <div class="form-group">
                <a href="add_book.jsp" class="add-btn">+ Add Book</a>
            </div>
        </div>
    </form>

    <%
        String keyword = request.getParameter("keyword");
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean found = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");

            String sql;
            if (keyword != null && !keyword.trim().equals("")) {
                sql = "SELECT * FROM books WHERE title LIKE ? OR author LIKE ? OR genre LIKE ? OR tags LIKE ?";
                stmt = conn.prepareStatement(sql);
                String search = "%" + keyword + "%";
                for (int i = 1; i <= 4; i++) {
                    stmt.setString(i, search);
                }
            } else {
                sql = "SELECT * FROM books";
                stmt = conn.prepareStatement(sql);
            }

            rs = stmt.executeQuery();
            found = false;
    %>
    <table>
        <thead>
            <tr>
                <th>Book ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Genre</th>
                <th>Tags</th>   
                <th>ISBN</th>   
                <th>Stock</th> <!-- Tambahan kolom stock -->
                <th>Availability</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
    <%
            while (rs.next()) {
                found = true;
    %>
            <tr>
                <td><%= rs.getString("book_id") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("author") %></td>
                <td><%= rs.getString("genre") %></td>
                <td><%= rs.getString("tags") %></td>
                <td><%= rs.getString("isbn") %></td> 
                <td><%= rs.getString("quantity") %></td> <!-- Tampilkan jumlah stok -->
                <td><%= rs.getString("availability") %></td>
                <td>
                    <a href="editbook.jsp?book_id=<%= rs.getString("book_id") %>" class="edit-btn">Edit</a>
                    <a href="DeleteBook.jsp?book_id=<%= rs.getString("book_id") %>" class="delete-btn" onclick="return confirm('Are you sure you want to delete this book?');">Delete</a>
                </td>                            
            </tr>
    <%
            }

            if (!found) {
    %>
            <tr>
                <td colspan="9" class="no-result">No books found matching the keyword.</td>
            </tr>
    <%
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
    %>
        <p style="color:red;">An error occurred: <%= e.getMessage() %></p>
    <%
        }
    %>
        </tbody>
    </table>
</div>

</body>
</html>
