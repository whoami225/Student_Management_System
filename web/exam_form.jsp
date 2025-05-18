<%@ page import="java.util.List" %>
<%@ page import="model.Course" %>
<%@ page import="model.Subject" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Create New Exam</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body style="background:#f7fbff;">


<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4>Create New Exam</h4>
        </div>
        <div class="card-body">
            <form method="POST" action="exam">
                <div class="form-group">
                    <label for="exam_type">Exam Type</label>
                    <input type="text" class="form-control" id="exam_type" name="exam_type" required>
                </div>
                <!-- COURSE NAME DROPDOWN -->
                <div class="form-group">
                    <label for="course_id">Course</label>
                    <select class="form-control" id="course_id" name="course_id" required>
                        <option value="">Select Course</option>
                        <%
                            List<Course> courseList = (List<Course>) request.getAttribute("courseList");
                            if (courseList != null) {
                                for (Course c : courseList) {
                        %>
                        <option value="<%= c.getCourseId() %>"><%= c.getCourseName() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <!-- SUBJECT NAME DROPDOWN -->
                <div class="form-group">
                    <label for="subject_id">Subject</label>
                    <select class="form-control" id="subject_id" name="subject_id" required>
                        <option value="">Select Subject</option>
                        <%
                            List<Subject> subjectList = (List<Subject>) request.getAttribute("subjectList");
                            if (subjectList != null) {
                                for (Subject s : subjectList) {
                        %>
                        <option value="<%= s.getSubjectId() %>"><%= s.getSubjectName() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="exam_date">Exam Date</label>
                    <input type="date" class="form-control" id="exam_date" name="exam_date" required>
                </div>
                <div class="form-group">
                    <label for="total_marks">Total Marks</label>
                    <input type="number" class="form-control" id="total_marks" name="total_marks" required>
                </div>
                <button type="submit" class="btn btn-success">Create Exam</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
