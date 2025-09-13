<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String bookId = request.getParameter("bookId");
    if (bookId == null || bookId.trim().equals("")) {
        out.println("<p style='color:red;'>Book ID not provided.</p>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Borrow Form</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #fdf8f3;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #ede0d4;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 350px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #5c4033;
        }

        label {
            display: block;
            margin-top: 15px;
            color: #5c4033;
            font-weight: 500;
        }

        input[type="text"],
        input[type="password"] {
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

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            background-color: #8b5e3c;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #71492f;
        }

        .back-btn,
        .dashboard-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 8px 20px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            width: 48%;
        }

        .back-btn {
            background-color: #f5f0eb;
            color: #8b5e3c;
            border: 1px solid #c2b2a1;
            margin-right: 10px;
        }

        .back-btn:hover {
            background-color: #e5dbd1;
        }

        .dashboard-btn {
            background-color: #8b5e3c;
            color: white;
        }

        .dashboard-btn:hover {
            background-color: #71492f;
        }

        .nav-links {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Borrow This Book</h2>

    <form action="borrow_process.jsp" method="post">
        <input type="hidden" name="bookId" value="<%= bookId %>">

        <label for="userId">User ID:</label>
        <input type="text" name="userId" id="userId" required>

        <label for="username">Username:</label>
        <input type="text" name="username" id="username" required>

        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required>

        <input type="submit" value="Confirm Borrow">
    </form>

    <div class="nav-links">
        <a href="register_member.jsp" class="back-btn">Register</a>
        <a href="dashboard.jsp" class="dashboard-btn">Back to Dashboard</a>
    </div>
</div>

</body>
</html>
