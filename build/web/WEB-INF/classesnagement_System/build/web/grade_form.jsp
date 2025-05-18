<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Enter Grade</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }
        form {
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            max-width: 400px;
            margin: auto;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        input[type="number"], input[type="submit"] {
            width: 100%;
            margin: 8px 0;
            padding: 10px;
            box-sizing: border-box;
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>
<h2>Enter Grade</h2>
<form action="GradeServlet" method="post">
    Student ID: <input type="number" name="studentId" required><br>
    Subject ID: <input type="number" name="subjectId" required><br>
    Marks: <input type="number" name="marks" step="0.01" required><br>
    <input type="submit" value="Submit">
</form>
</body>
</html>
