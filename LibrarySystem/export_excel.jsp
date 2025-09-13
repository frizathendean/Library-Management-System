<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ page language="java" %>
<%
response.setHeader("Content-Disposition", "attachment; filename=riwayat_peminjaman.xls");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(
        "SELECT i.*, b.title, m.name FROM issued i " +
        "JOIN books b ON i.book_id = b.book_id " +
        "JOIN member m ON i.id_member = m.id_member ORDER BY i.issue_date DESC"
    );
%>
<table border="1">
    <tr>
        <th>ID Buku</th>
        <th>Judul</th>
        <th>ID Member</th>
        <th>Nama</th>
        <th>Tanggal Pinjam</th>
        <th>Tanggal Kembali</th>
        <th>Status</th>
    </tr>
<%
    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("book_id") %></td>
        <td><%= rs.getString("title") %></td>
        <td><%= rs.getString("id_member") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getDate("issue_date") %></td>
        <td><%= rs.getDate("return_date") %></td>
        <td><%= rs.getString("status") %></td>
    </tr>
<%
    }
    rs.close();
    conn.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
</table>
