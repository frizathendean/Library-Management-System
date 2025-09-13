<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%!
    public int getTotalCount(String tableName) {
        int count = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM " + tableName);
            if (rs.next()) {
                count = rs.getInt("total");
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            count = -1;
        }
        return count;
    }
%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin_dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f8f8;
            margin: 0;
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
        .dashboard {
            padding: 40px;
        }
        .summary {
            display: flex;
            gap: 40px;
            margin-bottom: 40px;
        }
        .card {
            background-color: #ede0d4;
            padding: 40px;
            border-radius: 15px;
            width: 365px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.15);
        }
        .card h3 {
            margin-top: 0;
            font-size: 22px;
            color: #6e5c4b;
            border-bottom: 1px solid #c9b7a7;
            padding-bottom: 8px;
        }
        .card .number {
            font-size: 48px;
            font-weight: bold;
            color: #5b4a39;
            margin-top: 20px;
        }
        .actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .actions a {
            display: block;
            text-align: center;
            padding: 19px 155px;
            background-color: #9a8f7d;
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-size: 18px;
            font-weight: bold;
            transition: background-color 0.2s ease;
        }
        .actions a:hover {
            background-color: #867d6e;
        }
        form.filter-form {
            display: flex;
            align-items: center;
            gap: 15px;
            margin: 20px 0;
            font-size: 25px;
        }
        .filter-form input[type="date"],
        .filter-form input[type="submit"],
        .filter-form input[type="button"] {
            font-size: 16px;
            padding: 10px 14px;
            border-radius: 6px;
        }
        .filter-form input[type="date"] {
            border: 1px solid #ccc;
            width: 255px;
            text-align: center;
        }
        .filter-form input[type="submit"],
        .filter-form input[type="button"] {
            background-color: #9a8f7d;
            color: white;
            border: none;
            cursor: pointer;
        }
        .filter-form input[type="submit"]:hover,
        .filter-form input[type="button"]:hover {
            background-color: #867d6e;
        }
        .export-form button {
            font-size: 16px;
            padding: 8px 16px;
            background-color: #f0f0f0;
            color: #000;
            border: 1px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s ease;
            margin-bottom: 20px;
        }
        .export-form button:hover {
            background-color: #e0e0e0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            font-size: 18px;
            table-layout: fixed;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 6px;
            text-align: center;
        }
        th {
            background-color: #e6dbb8;
            font-size: 18px;
        }
        td:nth-child(3), th:nth-child(3) {
            width: 300px; 
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .status-returned {
            color: green;
            font-weight: bold;
        }
        .status-borrowed {
            color: red;
            font-weight: bold;
        }
        .status-overdue {
            color: orange;
            font-weight: bold;
        }
        @media screen and (max-width: 768px) {
            .summary {
                flex-direction: column;
                align-items: center;
            }
            .actions {
                flex-direction: row;
                justify-content: center;
                gap: 10px;
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    <h1>ADMIN USER</h1>
    <div>
        <a href="issue_book.jsp">Borrowed</a>
        <a href="login.jsp">Log out</a>
    </div>
</div>

<div class="dashboard">
    <div style="display: flex; justify-content: flex-start; gap: 40px;">
        <div class="summary">
            <div class="card">
                <h3>Total Books Borrowed</h3>
                <div class="number"><%= getTotalCount("issued") %></div>
            </div>
            <div class="card">
                <h3>Total Members</h3>
                <div class="number"><%= getTotalCount("member") %></div>
            </div>
        </div>

        <div class="actions">
            <a href="manage_member.jsp">Manage Member</a>
            <a href="manage_book.jsp">Manage Books</a>
            <a href="manage_borrowed.jsp">Manage Borrowed</a>
        </div>
    </div>

    <form method="get" class="filter-form">
        <label for="loan-date">Loan Date:</label>
        <input type="date" id="loan-date" name="date" value="<%= request.getParameter("date") != null ? request.getParameter("date") : "" %>" />
        <input type="submit" value="Search" />
        <input type="button" value="Reset" onclick="window.location.href='admin_dashboard.jsp'" />
    </form>

    <form action="export_excel.jsp" method="post" class="export-form">
        <button type="submit">Export to Excel</button>
    </form>

    <table>
        <tr>
            <th>No</th>
            <th>Book ID</th>
            <th>Title</th>
            <th>Member ID</th>
            <th>Member Name</th>
            <th>Loan Date</th>
            <th>Return Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <%
            String dateFilter = request.getParameter("date");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");

                String sql = "SELECT i.*, b.title, m.name FROM issued i " +
                             "JOIN books b ON i.book_id = b.book_id " +
                             "JOIN member m ON i.id_member = m.id_member WHERE 1=1";

                if (dateFilter != null && !dateFilter.trim().isEmpty()) {
                    sql += " AND DATE(i.issue_date) = ?";
                }

                sql += " ORDER BY i.issue_date DESC";

                PreparedStatement pst = conn.prepareStatement(sql);

                if (dateFilter != null && !dateFilter.trim().isEmpty()) {
                    pst.setString(1, dateFilter);
                }

                ResultSet rs = pst.executeQuery();
                int no = 1;
                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
                    String rawStatus = rs.getString("status");
                    String displayStatus = rawStatus.equalsIgnoreCase("issued") ? "Borrowed" : rawStatus;
                    String cssClass = displayStatus.equalsIgnoreCase("returned") ? "status-returned" :
                                      displayStatus.equalsIgnoreCase("overdue") ? "status-overdue" : "status-borrowed";
        %>
        <tr>
            <td><%= no++ %></td>
            <td><%= rs.getString("book_id") %></td>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("id_member") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getDate("issue_date") %></td>
            <td><%= rs.getDate("return_date") %></td>
            <td class="<%= cssClass %>"><%= displayStatus %></td>
            <td>
                <form action="update.jsp" method="get" style="margin: 0;">
                    <input type="hidden" name="issue_id" value="<%= rs.getInt("issue_id") %>"/>
                    <button type="submit" style="padding: 6px 12px; background-color: #877a24; color: white; border: none; border-radius: 4px; cursor: pointer;">
                        Update
                    </button>
                </form>
            </td>
        </tr>
        <%
                }
                if (!hasData) {
                    out.println("<tr><td colspan='9'>No data found.</td></tr>");
                }

                rs.close();
                pst.close();
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='9' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</div>

</body>
</html>
