<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");

    if (id != null && !id.trim().isEmpty()) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");

            String sql = "DELETE FROM member WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(id)); // Aman karena sudah dicek

            int rowsAffected = stmt.executeUpdate();

            response.sendRedirect("manage_member.jsp");

        } catch (Exception e) {
%>
            <p style="color: red;">An error occurred: <%= e.getMessage() %></p>
<%
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    } else {
%>
        <p style="color: red;">Invalid or missing member ID.</p>
<%
    }
%>
