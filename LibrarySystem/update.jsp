<%@ page import="java.sql.*, java.time.*, java.time.temporal.ChronoUnit" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pengembalian Buku - Hogwarts Library</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 400px;
            margin: 80px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #5a4635;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        .btn {
            width: 100%;
            background-color: #caa968;
            color: white;
            border: none;
            padding: 12px;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            display: block;
            margin-top: 10px;
            box-sizing: border-box;
        }

        .btn:hover {
            background-color: #b89458;
        }

        .popup {
            display: none;
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #ffffff;
            border-left: 6px solid #4CAF50;
            color: #333;
            padding: 16px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            z-index: 999;
            animation: slideDown 0.5s ease-out;
        }

        .popup.error {
            border-left-color: #f44336;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translate(-50%, -20px);
            }
            to {
                opacity: 1;
                transform: translate(-50%, 0);
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Return Book</h2>
    <form method="post">
        <label for="book_id">ID Book</label>
        <input type="text" name="book_id" id="book_id" required />

        <label for="id_member">ID Member</label>
        <input type="text" name="id_member" id="id_member" required />

        <input type="submit" value="Return Book" class="btn" />
    </form>

    <a href="admin_dashboard.jsp" class="btn">Back</a>

    <%
        String popupMessage = "";
        String popupClass = "";

        if (request.getMethod().equalsIgnoreCase("POST")) {
            String book_id = request.getParameter("book_id");
            String id_member = request.getParameter("id_member");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");

                PreparedStatement check = conn.prepareStatement(
                    "SELECT * FROM issued WHERE book_id = ? AND id_member = ? AND status = 'issued'"
                );
                check.setString(1, book_id);
                check.setString(2, id_member);
                ResultSet rs = check.executeQuery();

                if (rs.next()) {
                    int issue_id = rs.getInt("issue_id");
                    Date returnDate = rs.getDate("return_date");
                    LocalDate today = LocalDate.now();
                    LocalDate returnDue = returnDate.toLocalDate();

                    long daysLate = ChronoUnit.DAYS.between(returnDue, today);
                    int penalty = (daysLate > 0) ? (int) daysLate * 3000 : 0;

                    PreparedStatement updateIssued = conn.prepareStatement(
                        "UPDATE issued SET status = 'returned', penalty = ? WHERE issue_id = ?"
                    );
                    updateIssued.setInt(1, penalty);
                    updateIssued.setInt(2, issue_id);
                    updateIssued.executeUpdate();

                    PreparedStatement updateBook = conn.prepareStatement(
                        "UPDATE books SET availability = 'available' WHERE book_id = ?"
                    );
                    updateBook.setString(1, book_id);
                    updateBook.executeUpdate();

                    popupMessage = "✅ The Book Successfully Returned" +
                        (penalty > 0 ? " with penalty Rp" + penalty : "") + ".";
                    popupClass = "";

                    updateIssued.close();
                    updateBook.close();
                } else {
                    popupMessage = "❌ Loan data not found or book has been returned.";
                    popupClass = "error";
                }

                rs.close();
                check.close();
                conn.close();
            } catch (Exception e) {
                popupMessage = "❌ Error: " + e.getMessage();
                popupClass = "error";
            }
        }
    %>

    <div id="popup" class="popup <%= popupClass %>"><%= popupMessage %></div>
</div>

<script>
    const popup = document.getElementById("popup");
    if (popup.textContent.trim() !== "") {
        popup.style.display = "block";
        setTimeout(() => {
            popup.style.display = "none";
        }, 4000);
    }
</script>
</body>
</html>
