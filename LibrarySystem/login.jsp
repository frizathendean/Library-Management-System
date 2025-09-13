<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String error = "";
    Connection conn = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");

            String sql = "SELECT * FROM employee WHERE name=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                if ("admin".equalsIgnoreCase(rs.getString("name"))) {
                    session.setAttribute("admin", rs.getString("name"));
                    response.sendRedirect("admin_dashboard.jsp");
                    return;
                } else {
                    error = "Only admin is allowed to log in.";
                }
            } else {
                error = "Incorrect name or password.";
            }
        } catch (Exception e) {
            error = "Database connection error: " + e.getMessage();
        } finally {
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Library Admin Login</title>
    <style>
         body {
            margin: 0;
            padding: 0;
            background: url('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?fm=jpg&q=60&w=3000') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background-color: rgba(156, 112, 9, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.5); 
            backdrop-filter: blur(3px);
            border-radius: 30px;
            padding: 50px;
            width: 90%;
            max-width: 500px;
            color: white;
            text-align: center;
        }

        .login-container h1 {
            margin-bottom: 10px;
            font-size: 32px;
            color: #fff;
        }

        .login-container p {
            margin-bottom: 30px;
            font-size: 16px;
            color: #e0e0e0;
        }

        .login-container label {
            display: block;
            margin-bottom: 5px;
            text-align: left;
            font-weight: bold;
            color: #fff;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 95%;
            padding: 15px;
            margin-bottom: 20px;
            border: none;
            border-radius: 15px;
            font-size: 16px;
            background-color: rgba(241, 229, 187, 0.723);
            color: black;
        }

        .login-btn {
            width: 50%;
            padding: 14px;
            background-color: rgb(242, 228, 182);
            color: #573e1c;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .login-btn:hover {
            background-color: #e0e0e0;
        }

        .error {
            color: red;
            margin-bottom: 20px;
        }

        .register-text {
            margin-top: 20px;
            font-size: 14px;
            color: #e0e0e0;
        }

        .register-text a {
            color: white;
            font-weight: bold;
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .login-container {
                padding: 30px;
                border-radius: 20px;
            }
        }
    </style>
</head>
<body>
    <form class="login-container" method="post">
        <h1>Admin Login</h1>
        <p>Welcome to the library admin portal. Please log in using your registered account to access collection management, user administration, and reporting features</p>

        <% if (!error.isEmpty()) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <label>Username</label>
        <input type="text" name="name" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button class="login-btn" type="submit">LOGIN</button>
    </form>
</body>
</html>
