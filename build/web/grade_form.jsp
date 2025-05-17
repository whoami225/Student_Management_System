<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Enter Grade</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 400px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-top: 10px;
            font-weight: bold;
            color: #555;
        }

        input[type="number"],
        input[type="text"] {
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        input[type="submit"] {
            margin-top: 20px;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Enter Grade</h2>
    <form action="GradeServlet" method="post">
        <label>Student ID:</label>
        <input type="number" name="studentId" required>

        <label>Subject ID:</label>
        <input type="number" name="subjectId" required>

        <label>Marks:</label>
        <input type="number" name="marks" step="0.01" required>

        <label>Grade:</label>
        <input type="text" name="grade" required>

        <input type="submit" value="Submit">
    </form>
</div>
</body>
</html>
