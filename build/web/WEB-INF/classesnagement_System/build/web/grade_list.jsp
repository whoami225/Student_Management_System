<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Grade List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f7;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
        }

        form {
            text-align: center;
            margin-bottom: 20px;
        }

        input[type="text"],
        input[type="submit"] {
            padding: 10px;
            margin: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

    </style>
</head>
<body>
<div class="container">
    <h2>Grade Report</h2>

    <form method="get" action="GradeServlet">
        Filter by Student ID: <input type="text" name="studentId">
        or Subject ID: <input type="text" name="subjectId">
        <input type="submit" value="Filter">
    </form>

    <table>
        <tr><th>ID</th><th>Student</th><th>Subject</th><th>Marks</th><th>Grade</th></tr>
        <%
            List<Grade> grades = (List<Grade>) request.getAttribute("grades");
            if (grades != null) {
                for (Grade g : grades) {
        %>
            <tr>
                <td><%= g.getGradeId() %></td>
                <td><%= g.getStudentId() %></td>
                <td><%= g.getSubjectId() %></td>
                <td><%= g.getMarks() %></td>
                <td><%= g.getGrade() %></td>
            </tr>
        <%
                }
            } else {
        %>
            <tr><td colspan="5">No grades found.</td></tr>
        <%
            }
        %>
    </table>
</div>
</body>
</html>
