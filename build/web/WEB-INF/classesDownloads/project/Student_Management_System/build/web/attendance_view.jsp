<%@page import="dao.AttendanceDAO"%>
<%@page import="controller.DBConnection"%>
<%@page import="controller.DBConnection"%>
<%@ page import="java.util.*, your.package.Attendance, your.package.AttendanceDAO" %>
<%@ page import="java.sql.*" %>
<%
    int studentId = Integer.parseInt(request.getParameter("student_id"));
    Connection conn = DBConnection.getConnection();
    AttendanceDAO dao = new AttendanceDAO(conn);
    List<Attendance> records = dao.getAttendanceByStudent(studentId);
%>

<h2>Attendance Records</h2>
<table border="1">
    <tr>
        <th>Date</th>
        <th>Subject ID</th>
        <th>Status</th>
    </tr>
<%
    for (Attendance a : records) {
%>
    <tr>
        <td><%= a.getDate() %></td>
        <td><%= a.getSubjectId() %></td>
        <td style="color:<%= a.isStatus() ? "green" : "red" %>">
            <%= a.isStatus() ? "Present" : "Absent" %>
        </td>
    </tr>
<%
    }
%>
</table>
