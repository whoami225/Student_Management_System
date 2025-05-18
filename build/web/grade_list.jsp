<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Grade" %>
<html>
<head>
    <title>Grade Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #eef2f3;
            padding: 20px;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            background: #fff;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        form {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<h2 style="text-align:center;">Grade Report</h2>

<form method="get" action="GradeServlet">
    Filter by Student ID: <input type="text" name="studentId">
    or Subject ID: <input type="text" name="subjectId">
    <input type="submit" value="Filter">
</form>

<table>
    <tr>
        <th>ID</th><th>Student</th><th>Subject</th><th>Marks</th><th>Grade</th>
    </tr>
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
        }
    %>
</table>
</body>
</html>
