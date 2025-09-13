<!-- Tambahan import dan content-type tetap sama -->
<%@ page import="java.io.*, java.sql.*, java.util.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Add New Book</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        /* [Style sama seperti sebelumnya, tidak diubah] */
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
        }

        .form-container {
            max-width: 900px;
            margin: 40px auto;
            background: #e3d8c9;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }

        .form-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        .form-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .form-group {
            flex: 1 1 45%;
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 600;
            margin-bottom: 6px;
            color: #444;
        }

        input[type="text"],
        input[type="file"],
        input[type="number"],
        select {
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 14px;
        }

        .upload-box {
            border: 2px dashed #ccc;
            padding: 20px;
            text-align: center;
            background-color: #fefefe;
            color: #999;
            border-radius: 10px;
        }

        .full-width {
            flex: 1 1 100%;
        }

        .buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .buttons input {
            width: 48%;
            padding: 12px;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            font-size: 15px;
        }

        .buttons .save {
            background-color: #4b2e2e;
            color: white;
        }

        .buttons .cancel {
            background-color: #ddd;
            color: #333;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add New Book</h2>
    <form method="post" enctype="multipart/form-data">
        <div class="form-grid">
            <div class="form-group">
                <label>Book ID</label>
                <input type="text" name="book_id" required>
            </div>
            <div class="form-group">
                <label>Title</label>
                <input type="text" name="title" required>
            </div>

            <div class="form-group">
                <label>Author</label>
                <input type="text" name="author" required>
            </div>
            <div class="form-group">
                <label>ISBN</label>
                <input type="text" name="isbn" required>
            </div>

            <div class="form-group">
                <label>Genre</label>
                <input type="text" name="genre" required>
            </div>

            <div class="form-group">
                <label>Stock Quantity</label>
                <input type="number" name="quantity" min="0" required>
            </div>

            <div class="form-group">
                <label>Tags</label>
                <input type="text" name="tags">
            </div>

            <div class="form-group full-width">
                <label>Upload Image</label>
                <div class="upload-box">
                    <input type="file" name="bookImage" accept="image/*">
                </div>
            </div>
        </div>

        <div class="buttons">
            <input type="submit" class="save" value="Save">
            <input type="reset" class="cancel" value="Cancel">
        </div>
    </form>
</div>

<%
if (ServletFileUpload.isMultipartContent(request)) {
    String uploadPath = application.getRealPath("/") + "images/books";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);

    String book_id = "", title = "", author = "", isbn = "", genre = "", tags = "", availability = "Available", filePathDB = "";
    int quantity = 0;

    try {
        List<FileItem> items = upload.parseRequest(request);
        for (FileItem item : items) {
            if (item.isFormField()) {
                switch (item.getFieldName()) {
                    case "book_id": book_id = item.getString("UTF-8"); break;
                    case "title": title = item.getString("UTF-8"); break;
                    case "author": author = item.getString("UTF-8"); break;
                    case "isbn": isbn = item.getString("UTF-8"); break;
                    case "genre": genre = item.getString("UTF-8"); break;
                    case "tags": tags = item.getString("UTF-8"); break;
                    case "quantity": quantity = Integer.parseInt(item.getString("UTF-8")); break;
                }
            } else {
                String fileName = new File(item.getName()).getName();
                if (!fileName.equals("")) {
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    String filePath = uploadPath + File.separator + uniqueFileName;
                    filePathDB = "images/books/" + uniqueFileName;
                    File storeFile = new File(filePath);
                    item.write(storeFile);
                }
            }
        }

        // Simpan ke database
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabase", "root", "");
        String sql = "INSERT INTO books (book_id, title, author, isbn, genre, tags, quantity, availability, image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, book_id);
        pst.setString(2, title);
        pst.setString(3, author);
        pst.setString(4, isbn);
        pst.setString(5, genre);
        pst.setString(6, tags);
        pst.setInt(7, quantity);
        pst.setString(8, availability);
        pst.setString(9, filePathDB);
        pst.executeUpdate();
        conn.close();
%>
<script>
Swal.fire({
    icon: 'success',
    title: 'Success',
    text: 'Book has been added successfully!'
});
</script>
<%
    } catch (Exception e) {
        String errorMessage = e.getMessage().replace("'", "\\'").replace("\"", "\\\"");
%>
<script>
Swal.fire({
    icon: 'error',
    title: 'Error',
    text: '<%= errorMessage %>'
});
</script>
<%
    }
}
%>

</body>
</html>
