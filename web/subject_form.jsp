<%@ page import="model.Course" %>
    <%@ page import="java.util.List" %>
    <%@ page import="model.Course" %>
    <%
    Course course = (Course) request.getAttribute("course");
%>

<%
List<Course> courseList = (List<Course>) request.getAttribute("courseList");
String selectedCourseId = request.getParameter("course_id"); // Allow pre-selection
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Add Subject</title>
</head>
<body>
<h2> Add New Subject</h2>

<form method="post" action="subject">
    <!-- Subject Name -->
    <label for="subject_name">Subject Name:</label>
    <input type="text" id="subject_name" name="subject_name" required placeholder="Enter subject name">
        <br><br>

            <!-- Course Dropdown -->
            <label for="course_id">Course:</label>
            <select name="course_id" id="course_id" required>
                <% if (courseList != null && !courseList.isEmpty()) {
                for (Course c : courseList) {
                boolean selected = (selectedCourseId != null && selectedCourseId.equals(String.valueOf(c.getCourseId())));
                %>
                <option value="<%= c.getCourseId() %>" <%= selected ? "selected" : "" %>>
                <%= c.getCourseName() %> (<%= c.getCourseCode() %>)
                </option>
                <% }} else { %>
                <option disabled>No courses available</option>
                <% } %>
            </select>
            <br><br>

                <button type="submit"> Add Subject</button>
</form>

<br>
    <a href="<%= request.getContextPath() %>/subject?action=list&course_id=<%= (course != null) ? course.getCourseId() : 1 %>">Back to Courses List</a>
</body>
</html>
