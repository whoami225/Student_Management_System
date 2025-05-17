<%-- 
    Document   : attendance_mark
    Created on : 18 May 2025, 00:58:25
    Author     : SLC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Mark Attendance</h2>
<form action="AttendanceServlet" method="post">
    Student ID: <input type="number" name="student_id" required><br>
    Subject ID: <input type="number" name="subject_id" required><br>
    Status:
    <select name="status">
        <option value="present">Present</option>
        <option value="absent">Absent</option>
    </select><br>
    <input type="submit" value="Mark Attendance">
</form>

    </body>
</html>
