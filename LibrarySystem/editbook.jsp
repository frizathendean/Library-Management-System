<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String method = request.getMethod();
    String book_id = "", title = "", author = "", genre = "", tags = "", isbn = "", availability = "";
    int quantity = 0;

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");

    if (method.equals("POST")) {
        book_id = request.getParameter("book_id");
        title = request.getParameter("title");
        author = request.getParameter("author");
        genre = request.getParameter("genre");
        tags = request.getParameter("tags");
        isbn = request.getParameter("isbn");
        availability = request.getParameter("availability");
        String quantityStr = request.getParameter("quantity");
        if (quantityStr != null && !quantityStr.isEmpty()) {
            quantity = Integer.parseInt(quantityStr);
        }

        String sqlUpdate = "UPDATE books SET title=?, author=?, genre=?, tags=?, isbn=?, availability=?, quantity=? WHERE book_id=?";
        PreparedStatement stmt = conn.prepareStatement(sqlUpdate);
        stmt.setString(1, title);
        stmt.setString(2, author);
        stmt.setString(3, genre);
        stmt.setString(4, tags);
        stmt.setString(5, isbn);
        stmt.setString(6, availability);
        stmt.setInt(7, quantity);
        stmt.setString(8, book_id);
        stmt.executeUpdate();
        stmt.close();

        response.sendRedirect("manage_book.jsp");
        return;
    } else {
        book_id = request.getParameter("book_id");
        String sql = "SELECT * FROM books WHERE book_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, book_id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            author = rs.getString("author");
            genre = rs.getString("genre");
            tags = rs.getString("tags");
            isbn = rs.getString("isbn");
            availability = rs.getString("availability");
            quantity = rs.getInt("quantity");
        }

        rs.close();
        stmt.close();
    }

    conn.close();
%>

<html>
<head>
    <title>Edit Book</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
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
            transition: color 0.3s ease;
        }
        .navbar a:hover {
            color: #ffd700;
        }
        .form-container {
            background: white;
            padding: 30px;
            margin: 40px auto;
            border: 1px solid #ccc;
            border-radius: 8px;
            max-width: 850px;
        }
        .form-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input, .form-group select {
            width: 350px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        .buttons {
            text-align: right;
            margin-top: 20px;
        }
        .buttons button {
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            margin-left: 10px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.1s ease, background-color 0.3s ease, color 0.3s ease;
        }

        .save-btn {
            background-color: #dbcebe;
            color: #333;
        }
        .save-btn:hover {
            background-color: #bca68b;
            color: #222;
        }
        .save-btn:active {
            background-color: #8d7f6c;
            transform: scale(0.95);
        }

        .cancel-btn {
            background-color: #dbcebe;
            color: #333;
        }
        .cancel-btn:hover {
            background-color: #8d7f6c;
            color: #222;
        }
        .cancel-btn:active {
            background-color: #a38c73;
            transform: scale(0.95);
        }

        a button {
            all: unset;
            display: inline-block;
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

<div class="form-container">
    <form method="post" action="editbook.jsp" onsubmit="return confirm('Are you sure you want to save the changes?');">
        <div class="form-group">
            <div>
                <label>Book ID</label>
                <input type="text" name="book_id" value="<%= book_id %>" readonly />
            </div>
            <div>
                <label>Tags</label>
                <input type="text" name="tags" value="<%= tags %>" />
            </div>
        </div>

        <div class="form-group">
            <div>
                <label>Title</label>
                <input type="text" name="title" value="<%= title %>" />
            </div>
            <div>
                <label>Author</label>
                <input type="text" name="author" value="<%= author %>" />
            </div>
        </div>

        <div class="form-group">
            <div>
                <label>Genre</label>
                <input type="text" name="genre" value="<%= genre %>" />
            </div>
            <div>
                <label>Availability</label>
                <select name="availability">
                    <option value="Available" <%= availability.equals("Available") ? "selected" : "" %>>Available</option>
                    <option value="Unavailable" <%= availability.equals("Unavailable") ? "selected" : "" %>>Unavailable</option>
                    <option value="Borrowed" <%= availability.equals("Borrowed") ? "selected" : "" %>>Borrowed</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <div>
                <label>ISBN / ISSN</label>
                <input type="text" name="isbn" value="<%= isbn %>" />
            </div>
            <div>
                <label>Quantity</label>
                <input type="number" name="quantity" min="0" value="<%= quantity %>" />
            </div>
        </div>

        <div class="buttons">
            <button type="submit" class="save-btn">Save</button>
            <button type="button" class="cancel-btn" onclick="window.location.href='manage_book.jsp'">Cancel</button>
        </div>
    </form>
</div>
</body>
</html>
