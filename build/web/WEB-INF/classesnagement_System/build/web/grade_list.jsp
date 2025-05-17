<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>

<html>
<head><title>Grade List</title></head>
<body>
<h2>Grade Report</h2>

<form method="get" action="GradeServlet">
    Filter by Student ID: <input type="text" name="studentId">
    or Subject ID: <input type="text" name="subjectId">
    <input type="submit" value="Filter">
</form>

<table border="1">
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
        }
    %>
</table>
</body>
</html>
