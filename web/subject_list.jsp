<%@ page import="model.Subject, model.Course, model.User" %>
<%@ page import="java.util.List" %>
<%
    List<Subject> subjectList = (List<Subject>) request.getAttribute("subjectList");
    List<Course> courseList = (List<Course>) request.getAttribute("courseList");
    int selectedCourseId = request.getAttribute("selectedCourseId") != null ? (Integer) request.getAttribute("selectedCourseId") : 0;
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subjects for Course</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4285f4;
            --primary-dark: #3367d6;
            --primary-light: rgba(66, 133, 244, 0.1);
            --dark-bg: #1a1a1a;
            --dark-panel: #2a2a2a;
            --light-text: #ffffff;
            --light-gray: #cccccc;
            --dark-gray: #666666;
            --error: #ff4d4d;
            --border-radius: 8px;
            --transition: all 0.3s ease;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background-color: var(--dark-bg);
            color: var(--light-text);
            line-height: 1.6;
            padding: 20px;
        }
        .container {
            max-width: 1100px;
            margin: 0 auto;
            background: var(--dark-panel);
            padding: 24px;
            border-radius: var(--border-radius);
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }
        h2 {
            color: var(--light-text);
            margin-bottom: 20px;
            font-size: 1.8rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            padding-bottom: 10px;
        }
        .course-selector {
            display: flex;
            gap: 1rem;
            align-items: center;
            margin-bottom: 2rem;
        }
        .select-label {
            color: var(--light-gray);
            font-size: 1rem;
            font-weight: 500;
            margin-right: 0.5rem;
            letter-spacing: 0.02em;
        }
        select {
            padding: 0.8rem;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--dark-gray);
            border-radius: var(--border-radius);
            color: var(--light-text);
            font-size: 1rem;
            transition: var(--transition);
        }
        select:hover {
            border-color: var(--primary);
        }
        .add-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--primary);
            color: white;
            padding: 10px 16px;
            border-radius: var(--border-radius);
            text-decoration: none;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            font-weight: 500;
        }
        .add-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background: var(--dark-panel);
            border-radius: var(--border-radius);
            overflow: hidden;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }
        th {
            background: rgba(66,133,244,0.15);
            color: var(--light-text);
            font-weight: 600;
        }
        tr:hover {
            background: rgba(255,255,255,0.03);
        }
        .action-links {
            display: flex;
            gap: 12px;
        }
        .edit-link, .delete-link {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            text-decoration: none;
            padding: 6px 10px;
            border-radius: 4px;
            transition: var(--transition);
        }
        .edit-link {
            color: var(--primary);
            background: rgba(66,133,244,0.1);
        }
        .edit-link:hover {
            background: rgba(66,133,244,0.2);
        }
        .delete-link {
            color: var(--error);
            background: rgba(255,77,77,0.1);
        }
        .delete-link:hover {
            background: rgba(255,77,77,0.2);
        }
        .no-data {
            color: var(--light-gray);
            text-align: center;
            padding: 40px 20px;
            background: var(--dark-panel);
            border-radius: var(--border-radius);
            border: 1px dashed rgba(255,255,255,0.1);
        }
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--light-gray);
            text-decoration: none;
            margin-top: 20px;
            padding: 8px 12px;
            border-radius: 4px;
            transition: var(--transition);
        }
        .back-link:hover {
            color: var(--primary);
            background: rgba(255,255,255,0.05);
        }
        @media (max-width: 768px) {
            .container {
                padding: 16px;
            }
            .course-selector {
                flex-direction: column;
                align-items: stretch;
            }
            select {
                width: 100%;
            }
            th, td {
                padding: 10px 12px;
            }
            .action-links {
                flex-direction: column;
                gap: 8px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Subjects for Course</h2>
    <!-- Course Selector -->
    <div class="course-selector">
        <form method="get" action="subject" style="display:flex; align-items:center; gap:1rem;">
            <label for="courseSelect" class="select-label">Select Course:</label>
            <input type="hidden" name="action" value="list"/>
            <select id="courseSelect" name="course_id" onchange="this.form.submit()">
                <% for (Course course : courseList) { %>
                <option value="<%= course.getCourseId() %>"
                        <%= (selectedCourseId == course.getCourseId()) ? "selected" : "" %>>
                    <%= course.getCourseName() %>
                </option>
                <% } %>
            </select>
        </form>
        <a href="subject?action=new&course_id=<%= selectedCourseId %>" class="add-btn">
            <i class="fas fa-plus"></i> Add New Subject
        </a>
    </div>
    <!-- Subjects Table -->
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Subject Name</th>
            <% if (user != null && user.getRoleId() == 2) { %>
            <th>Actions</th>
            <% } %>
        </tr>
        </thead>
        <tbody>
        <% if (subjectList != null && !subjectList.isEmpty()) {
            for (Subject s : subjectList) { %>
        <tr>
            <td><%= s.getSubjectId() %></td>
            <td><%= s.getSubjectName() %></td>
            <% if (user != null && user.getRoleId() == 2) { %>
            <td>
                <div class="action-links">
                    <a href="subject?action=edit&id=<%= s.getSubjectId() %>&course_id=<%= selectedCourseId %>" class="edit-link">
                        <i class="fas fa-edit"></i> Edit
                    </a>
                    <a href="subject?action=delete&id=<%= s.getSubjectId() %>&course_id=<%= selectedCourseId %>"
                       class="delete-link"
                       onclick="return confirm('Are you sure to delete this subject?');">
                        <i class="fas fa-trash-alt"></i> Delete
                    </a>
                </div>
            </td>
            <% } %>
        </tr>
        <%  }
        } else { %>
        <tr>
            <td colspan="<%= (user != null && user.getRoleId() == 2) ? "3" : "2" %>" class="no-data">
                <i class="fas fa-book-open" style="font-size: 2rem; margin-bottom: 10px; opacity: 0.5;"></i>
                No subjects found for this course
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <div>
        <% if (user != null && user.getRoleId() == 2) { %>
        <a href="dashboard_teacher.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
        <% } else if (user != null && user.getRoleId() == 3) { %>
        <a href="dashboard_student.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
        <% } %>
    </div>
</div>
</body>
</html>
