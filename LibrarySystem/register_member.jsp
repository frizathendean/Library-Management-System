<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String bookId = request.getParameter("bookId");
    boolean isValidBookId = bookId != null && bookId.matches("\\d+");

    String message = "";
    boolean isRegistered = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String id_member = request.getParameter("id_member");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String registerDateStr = request.getParameter("register_date");
        bookId = request.getParameter("bookId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");

            String checkSql = "SELECT COUNT(*) FROM member WHERE id_member = ?";
            PreparedStatement checkPst = conn.prepareStatement(checkSql);
            checkPst.setString(1, id_member);
            ResultSet rs = checkPst.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                isRegistered = true;
            }

            if (isRegistered) {
%>
<script>
    if (confirm("You are already registered. Do you want to borrow this book?")) {
        window.location.href = "book_detail.jsp?id=<%= bookId %>&id_member=<%= id_member %>";
    }
</script>
<%
            } else {
                String insertSql = "INSERT INTO member (id_member, name, password, register_date) VALUES (?, ?, ?, ?)";
                PreparedStatement insertPst = conn.prepareStatement(insertSql);
                insertPst.setString(1, id_member);
                insertPst.setString(2, name);
                insertPst.setString(3, password); // optional: hash this
                insertPst.setDate(4, Date.valueOf(registerDateStr));
                insertPst.executeUpdate();

                message = "Registration successful!";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }
%>

<html>
<head>
    <title>Member Registration</title>
     <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #fdf8f3; /* coklat sangat muda */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #ede0d4; /* coklat muda */
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 350px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #5c4033; /* coklat tua */
        }

        label {
            display: block;
            margin-top: 15px;
            color: #5c4033;
            font-weight: 500;
        }

        input[type="text"],
        input[type="password"],
        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #c2b2a1;
            border-radius: 8px;
            font-size: 14px;
            background-color: #fff8f0;
        }

        .button-group {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .button-group input[type="submit"] {
            padding: 8px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            background-color: #8b5e3c; /* coklat medium */
            color: white;
        }

        .button-group .cancel-btn {
            padding: 8px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            background-color: #f5f0eb;
            color: #8b5e3c;
            border: 1px solid #c2b2a1;
        }

        .message {
            color: green;
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Add New Member</h2>
        <form method="post" action="register_member.jsp">
            <label>ID Member:</label>
            <input type="text" name="id_member" required />

            <label>Name:</label>
            <input type="text" name="name" required />

            <label>Password:</label>
            <input type="password" name="password" required />

            <label>Register Date:</label>
            <input type="date" name="register_date" value="<%= new java.sql.Date(System.currentTimeMillis()) %>" required />

            <div class="button-group">
                <input type="submit" value="Save" />
                <button type="button" class="cancel-btn" onclick="window.location.href='borrow__form.jsp'">Cancel</button>
            </div>
        </form>

    <p style="color:green;"><%= message %></p>
</body>
</html>
