<h2>Upload Assignment</h2>
<form action="AssignmentServlet" method="post" enctype="multipart/form-data">
    Subject ID: <input type="number" name="subject_id" required><br><br>
    Title: <input type="text" name="title" required><br><br>
    Description:<br><textarea name="description" required></textarea><br><br>
    Due Date: <input type="date" name="due_date" required><br><br>
    File: <input type="file" name="file" accept=".pdf,.docx" required><br><br>
    <input type="submit" value="Upload Assignment">
</form>
