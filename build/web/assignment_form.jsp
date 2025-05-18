<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upload Assignment</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-container { max-width: 600px; margin: 0 auto; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="date"], textarea, select {
            width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;
        }
        textarea { height: 100px; }
        button { background-color: #4CAF50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #45a049; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Upload New Assignment</h2>
        <form action="assignment" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="upload">
            
            <div class="form-group">
                <label for="subject_id">Subject:</label>
                <select id="subject_id" name="subject_id" required>
                    <option value="1">Mathematics</option>
                    <option value="2">Science</option>
                    <option value="3">English</option>
                    <option value="4">History</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description"></textarea>
            </div>
            
            <div class="form-group">
                <label for="due_date">Due Date:</label>
                <input type="date" id="due_date" name="due_date" required>
            </div>
            
            <div class="form-group">
                <label for="file">Assignment File (PDF/DOCX):</label>
                <input type="file" id="file" name="file" accept=".pdf,.doc,.docx" required>
            </div>
            
            <button type="submit">Upload Assignment</button>
        </form>
    </div>
</body>
</html>
<h2>Upload Assignment</h2>
<form action="AssignmentServlet" method="post" enctype="multipart/form-data">
    Subject ID: <input type="number" name="subject_id" required><br><br>
    Title: <input type="text" name="title" required><br><br>
    Description:<br><textarea name="description" required></textarea><br><br>
    Due Date: <input type="date" name="due_date" required><br><br>
    File: <input type="file" name="file" accept=".pdf,.docx" required><br><br>
    <input type="submit" value="Upload Assignment">
</form>
