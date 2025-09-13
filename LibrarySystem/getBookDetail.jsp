<!-- <%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    if (id == null || id.trim().equals("")) {
        out.println("<p style='color:red;'>Invalid book ID.</p>");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");
        String sql = "SELECT * FROM books WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, id);
        rs = stmt.executeQuery();

        if (!rs.next()) {
%>
            <p style="color:red;">Book not found.</p>
<%
        } else {
%> -->
<!-- <div class="book-modal-content">
    <div class="modal-header">
        <h1><%= rs.getString("title") %></h1>
        <h2><%= rs.getString("author") %></h2>
    </div>

    <div class="modal-body">
        <div class="modal-left">
            <img src="<%= rs.getString("image_url") != null ? rs.getString("image_url") : "images/books/default.jpg" %>" alt="Book Cover">
            <div class="rating">
                <div class="rating-text">4.0</div>
                <div class="stars">★★★★☆</div>
            </div>
        </div>

        <div class="modal-right">
            <div class="info-header">
                <div>Detail Information</div>
                <span class="availability">
                    <%= rs.getString("availability") != null ? rs.getString("availability") : "Unknown" %>
                </span>
            </div>
            <div class="detail-box">
                <div>ID Book</div>
                <div><%= String.format("BK%04d", rs.getInt("id")) %></div>

                <div>Author</div>
                <div><%= rs.getString("author") %></div>

                <div>ISBN / ISSN</div>
                <div><%= rs.getString("isbn") != null ? rs.getString("isbn") : "-" %></div>

                <div>Tags</div>
                <div><%= rs.getString("tags") != null ? rs.getString("tags") : "-" %></div>

                <!-- <div>Language</div> -->
                <!-- <div><%= rs.getString("language") != null ? rs.getString("language") : "-" %></div> -->
            </div>
        </div>
    </div>
</div> -->
<!-- <%
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%> -->
