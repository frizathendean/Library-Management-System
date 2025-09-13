<%@ page import="java.sql.*" %>
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

        if (rs.next()) {
%>
<style>
    .container {
        max-width: 1100px;
        margin: 10px auto;
        display: flex;
        gap: 30px;
        padding: 20px;
        opacity: 0;
        transform: scale(0.95);
        animation: fadePopup 0.4s ease forwards;
    }

    @keyframes fadePopup {
        0% { opacity: 0; transform: scale(0.95); }
        100% { opacity: 1; transform: scale(1); }
    }

    .book-image img {
        width: 320px;
        height: auto;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        border-radius: 8px;
    }

    .book-detail { flex: 1; }

    .header-box {
        background-color: #4e342e;
        color: white;
        border-radius: 12px;
        padding: 25px 30px;
    }

    .header-box h1 {
        margin: 0;
        font-size: 24px;
    }

    .header-box h2 {
        margin: 6px 0 0;
        font-weight: normal;
        font-size: 16px;
        color: #d7ccc8;
    }

    .info-bar {
        margin-top: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
    }

    .info-left {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .info-bar h3 {
        font-size: 18px;
        color: #3e3e3e;
        margin: 0;
    }

    .availability {
        padding: 5px 14px;
        border: 2px solid #4caf50;
        color: #388e3c;
        font-weight: bold;
        border-radius: 6px;
        background-color: white;
    }

    .availability.borrowed {
        border-color: #ffc107;
        color: #ff9800;
        background-color: #fff8e1;
    }

    .availability.unavailable {
        border-color: #f44336;
        color: #f44336;
        background-color: #ffebee;
    }

    .borrow-btn {
        padding: 5px 14px;
        height: 38px;
        line-height: 1;
        background-color: #4caf50;
        color: white;
        border: 2px solid #4caf50;
        border-radius: 6px;
        cursor: pointer;
        font-weight: bold;
        font-size: 14px;
        transition: background-color 0.3s ease, transform 0.1s ease, box-shadow 0.2s ease;
    }

    .borrow-btn:hover {
        background-color: #45a049;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
    }

    .borrow-btn:active {
        transform: scale(0.96);
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.2);
    }

    .detail-box {
        margin-top: 20px;
        border: 1px solid #ccc;
        border-radius: 12px;
        background-color: #f5f5f5;
        overflow: hidden;
    }

    .detail-box table {
        width: 100%;
        border-collapse: collapse;
    }

    .detail-box td {
        padding: 14px 20px;
        border-bottom: 1px solid #ddd;
        color: #333;
    }

    .detail-box td.label {
        font-weight: bold;
        color: #4e342e;
        width: 140px;
        background-color: #f0f0f0;
    }

    .rating {
        margin-top: 20px;
        font-size: 18px;
        color: #fbbf24;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .rating .text {
        font-size: 20px;
        font-weight: bold;
        color: #444;
        margin-left: 90px;
    }

    @media (max-width: 768px) {
        .container { flex-direction: column; align-items: center; }
        .book-image img { width: 260px; }
        .info-bar { flex-direction: column; align-items: flex-start; }
    }
</style>

<%
    String availability = rs.getString("Availability");
    String availabilityClass = "availability";

    if ("Borrowed".equalsIgnoreCase(availability)) {
        availabilityClass += " borrowed";
    } else if ("Unavailable".equalsIgnoreCase(availability)) {
        availabilityClass += " unavailable";
    }
%>

<div class="container">
    <div class="book-image">
        <img src="<%= rs.getString("image_url") != null ? rs.getString("image_url") : "images/books/default.jpg" %>" alt="Book Cover" />
        <div class="rating">
            <span class="text">4.0</span>
            <span>★★★★☆</span>
        </div>
    </div>

    <div class="book-detail">
        <div class="header-box">
            <h1><%= rs.getString("title") %></h1>
            <h2><%= rs.getString("author") %></h2>
        </div>

        <div class="info-bar">
            <div class="info-left">
                <h3>Detail Information</h3>
                <span class="<%= availabilityClass %>"><%= availability %></span>
            </div>

            <%-- Borrow Button --%>
            <% if (!"Borrowed".equalsIgnoreCase(availability) && !"Unavailable".equalsIgnoreCase(availability)) { %>
                <form action="borrow__form.jsp" method="post" style="margin: 0;">
                    <input type="hidden" name="bookId" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="borrow-btn">Borrow</button>
                </form>
            <% } %>
        </div>

        <div class="detail-box">
            <table>
                <tr>
                    <td class="label">ID Book</td>
                    <td><%= "BK" + String.format("%04d", rs.getInt("id")) %></td>
                </tr>
                <tr>
                    <td class="label">Author</td>
                    <td><%= rs.getString("author") %></td>
                </tr>
                <tr>
                    <td class="label">ISBN / ISSN</td>
                    <td><%= rs.getString("isbn") %></td>
                </tr>
                <tr>
                    <td class="label">Genre</td>
                    <td><%= rs.getString("genre") %></td>
                </tr>
                <tr>
                    <td class="label">Tags</td>
                    <td><%= rs.getString("tags") %></td>
                </tr>
            </table>
        </div>
    </div>
</div>

<%
        } else {
            out.println("<p style='color:red;'>Book not found.</p>");
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
