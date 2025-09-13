<%@ page import="java.sql.*, java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Borrow a Book</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #faf9fc;
            margin: 0;
            padding: 0;
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

        .navbar a:hover,
        .navbar a:focus {
            color: #ffd700;
        }

        .container {
            max-width: 850px;
            margin: 80px auto 40px auto;
            background-color: #e3d8c9;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 30px 40px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            margin-top: 0;
            border-bottom: 1px solid #aaa;
            padding-bottom: 10px;
            color: #3e2d1c;
        }

        form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px 30px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 6px;
            font-weight: 600;
            color: #5a4d3d;
        }

        input[type="text"],
        input[type="date"],
        select {
            padding: 10px 12px;
            font-size: 16px;
            border-radius: 6px;
            border: 1px solid #ccc;
            width: 100%;
            box-sizing: border-box;
            background-color: #fff;
        }

        .btn-submit {
            grid-column: span 2;
            text-align: center;
            margin-top: 10px;
        }

        input[type="submit"] {
            background-color: #d1b89d;
            border: none;
            padding: 10px 24px;
            border-radius: 8px;
            color: #fff;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #b89e85;
        }

        .message {
            grid-column: span 2;
            margin-top: 10px;
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="navbar">
    <h1>ADMIN PANEL</h1>
    <div>
        <a href="admin_dashboard.jsp">Home</a>
        <a href="login.jsp">Logout</a>
    </div>
</div>

<div class="container">
    <h2>Borrow a Book</h2>

    <form method="post">
        <!-- Member Dropdown -->
        <div class="form-group">
            <label>Member Name</label>
            <select name="id_member" required>
                <option value="">Select Member</option>
                <%
                    try (
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");
                        PreparedStatement stmt = conn.prepareStatement("SELECT id_member, name FROM member");
                        ResultSet rs = stmt.executeQuery();
                    ) {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        while (rs.next()) {
                            String memberId = rs.getString("id_member");
                            String memberName = rs.getString("name");
                %>
                    <option value="<%= memberId %>" data-id="<%= memberId %>"><%= memberName %></option>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <option disabled>Error loading members</option>
                <%
                    }
                %>
            </select>
        </div>

        <!-- Student ID -->
        <div class="form-group">
            <label>Student ID</label>
            <input type="text" id="student_id" name="student_id" readonly />
        </div>

        <!-- Loan Date -->
        <div class="form-group">
            <label>Loan Date</label>
            <input type="date" name="loan_date" required />
        </div>

        <!-- Return Date -->
        <div class="form-group">
            <label>Return Date</label>
            <input type="date" name="return_date" required />
        </div>

        <!-- Book Dropdown -->
        <div class="form-group">
            <label>Book ID</label>
            <select name="book_id" id="book_id" required>
                <option value="">Select Book</option>
                <%
                    try (
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");
                        PreparedStatement stmt = conn.prepareStatement("SELECT book_id, title, isbn FROM books WHERE availability = 'available'");
                        ResultSet rs = stmt.executeQuery();
                    ) {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        while (rs.next()) {
                            String bookId = rs.getString("book_id");
                            String bookTitle = rs.getString("title");
                            String isbn = rs.getString("isbn");
                %>
                    <option value="<%= bookId %>" data-isbn="<%= isbn %>"><%= bookTitle %> (ID: <%= bookId %>)</option>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <option disabled>Error loading books</option>
                <%
                    }
                %>
            </select>
        </div>

        <!-- ISBN -->
        <div class="form-group">
            <label>ISBN / ISSN</label>
            <select name="isbn" id="isbn_select" required>
                <option value="">Select ISBN</option>
                <%
                    try (
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");
                        PreparedStatement stmt = conn.prepareStatement("SELECT DISTINCT isbn FROM books WHERE availability = 'available'");
                        ResultSet rs = stmt.executeQuery();
                    ) {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        while (rs.next()) {
                            String isbn = rs.getString("isbn");
                %>
                    <option value="<%= isbn %>"><%= isbn %></option>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <option disabled>Error loading ISBN</option>
                <%
                    }
                %>
            </select>
        </div>

        <!-- Submit -->
        <div class="btn-submit">
            <input type="submit" value="Submit" />
        </div>

        <!-- Backend Logic -->
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String book_id = request.getParameter("book_id");
                String id_member = request.getParameter("id_member");
                LocalDate loanDate = LocalDate.parse(request.getParameter("loan_date"));
                LocalDate returnDate = LocalDate.parse(request.getParameter("return_date"));

                Connection conn = null;
                PreparedStatement checkBorrowed = null;
                ResultSet rsBorrowed = null;
                PreparedStatement check = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");

                    // Check if member has unreturned books
                    checkBorrowed = conn.prepareStatement("SELECT * FROM issued WHERE id_member = ? AND status = 'issued'");
                    checkBorrowed.setString(1, id_member);
                    rsBorrowed = checkBorrowed.executeQuery();

                    if (rsBorrowed.next()) {
        %>
                        <div class="message">This member still has an unreturned book.</div>
        <%
                    } else {
                        check = conn.prepareStatement("SELECT availability FROM books WHERE book_id = ?");
                        check.setString(1, book_id);
                        rs = check.executeQuery();

                        if (rs.next()) {
                            String availability = rs.getString("availability");
                            if (!"available".equalsIgnoreCase(availability)) {
        %>
                                <div class="message">This book is currently unavailable.</div>
        <%
                            } else {
                                PreparedStatement insert = conn.prepareStatement(
                                    "INSERT INTO issued (book_id, id_member, issue_date, return_date, status) VALUES (?, ?, ?, ?, 'issued')"
                                );
                                insert.setString(1, book_id);
                                insert.setString(2, id_member);
                                insert.setDate(3, java.sql.Date.valueOf(loanDate));
                                insert.setDate(4, java.sql.Date.valueOf(returnDate));
                                insert.executeUpdate();
                                insert.close();

                                PreparedStatement updateBook = conn.prepareStatement("UPDATE books SET availability = 'Borrowed' WHERE book_id = ?");
                                updateBook.setString(1, book_id);
                                updateBook.executeUpdate();
                                updateBook.close();
        %>
                                <script>
                                    alert("Book borrowed successfully! Please return it by: <%= returnDate %>");
                                    window.location.href = "admin_dashboard.jsp";
                                </script>
        <%
                            }
                        } else {
        %>
                            <div class="message">Book not found.</div>
        <%
                        }
                    }
                } catch (Exception e) {
        %>
                    <div class="message">Error: <%= e.getMessage() %></div>
        <%
                } finally {
                    if (rsBorrowed != null) rsBorrowed.close();
                    if (checkBorrowed != null) checkBorrowed.close();
                    if (rs != null) rs.close();
                    if (check != null) check.close();
                    if (conn != null) conn.close();
                }
            }
        %>
    </form>
</div>

<!-- JavaScript: Autofill Fields -->
<script>
    document.querySelector('select[name="id_member"]').addEventListener('change', function () {
        const selectedOption = this.options[this.selectedIndex];
        const studentId = selectedOption.getAttribute('data-id');
        document.getElementById('student_id').value = studentId || "";
    });

    document.getElementById('book_id').addEventListener('change', function () {
        const selectedOption = this.options[this.selectedIndex];
        const isbn = selectedOption.getAttribute('data-isbn');
        const isbnSelect = document.getElementById('isbn_select');
        if (isbn) {
            for (let i = 0; i < isbnSelect.options.length; i++) {
                if (isbnSelect.options[i].value === isbn) {
                    isbnSelect.selectedIndex = i;
                    break;
                }
            }
        } else {
            isbnSelect.selectedIndex = 0;
        }
    });
</script>

</body>
</html>