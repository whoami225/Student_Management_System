<%@ page import="java.util.*, your.package.Assignment, your.package.AssignmentDAO" %>
<%@ page import="java.sql.*" %>
<%
    Connection conn = DBConnection.getConnection();
    AssignmentDAO dao = new AssignmentDAO(conn);
    List<Assignment> assignments = dao.getAllAssignments();
%>

<h2>Assignment List</h2>
<table border="1" cellpadding="8">
    <tr>
        <th>Title</th><th>Subject ID</th><th>Due Date</th><th>Download</th>
    </tr>
<%
    for (Assignment a : assignments) {
%>
    <tr>
        <td><%= a.getTitle() %></td>
        <td><%= a.getSubjectId() %></td>
        <td><%= a.getDueDate() %></td>
        <td><a href="<%= a.getFilePath() %>" download>Download</a></td>
    </tr>
<%
    }
%>
</table>
