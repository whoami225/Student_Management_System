<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Enter Grade</title></head>
<body>
<h2>Enter Grade</h2>
<form action="GradeServlet" method="post">
    Student ID: <input type="number" name="studentId" required><br>
    Subject ID: <input type="number" name="subjectId" required><br>
    Marks: <input type="number" name="marks" step="0.01" required><br>
    Grade: <input type="text" name="grade" required><br>
    <input type="submit" value="Submit">
</form>
</body>
</html>
