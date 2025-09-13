<%@ page import="java.sql.*" %>
<%
    String bookId = request.getParameter("book_id");

    if (bookId != null && !bookId.trim().equals("")) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");

            // Delete from books table
            String sql = "DELETE FROM books WHERE book_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, bookId);

            int rowsAffected = stmt.executeUpdate();

            stmt.close();
            conn.close();

            // Redirect back to manage_book.jsp
            response.sendRedirect("manage_book.jsp");

        } catch (Exception e) {
%>
            <p style="color: red;">Error occurred: <%= e.getMessage() %></p>
<%
        }
    } else {
        response.sendRedirect("manage_book.jsp");
    }
%>
