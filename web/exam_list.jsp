<%@ page import="model.Exam, model.Subject, model.Course" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    List<Exam> examList = (List<Exam>) request.getAttribute("examList");
    List<Subject> subjectList = (List<Subject>) request.getAttribute("subjectList");
    List<Course> courseList = (List<Course>) request.getAttribute("courseList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Exam Management</title>
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
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }
        h2 {
            color: var(--light-text);
            margin-bottom: 20px;
            font-size: 1.8rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            padding-bottom: 10px;
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
            margin-bottom: 20px;
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
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
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
    <h2>Exam List</h2>
    <% if (user != null && user.getRoleId() == 2) { %>
    <a href="exam?action=add" class="add-btn">
        <i class="fas fa-plus"></i> Add New Exam
    </a>
    <% } %>
    <% if (examList != null && !examList.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>Exam ID</th>
            <th>Exam Type</th>
            <th>Subject</th>
            <th>Course</th>
            <th>Date</th>
            <th>Maximum Marks Range</th>
            <% if (user != null && user.getRoleId() == 2) { %>
            <th>Actions</th>
            <% } %>
        </tr>
        </thead>
        <tbody>
        <% for (Exam e : examList) { %>
        <tr>
            <td><%= e.getExamId() %></td>
            <td><%= e.getExamType() %></td>
            <td>
                <%
                    String subjectName = "";
                    if (subjectList != null) {
                        for (Subject s : subjectList) {
                            if (s.getSubjectId() == e.getSubjectId()) {
                                subjectName = s.getSubjectName();
                                break;
                            }
                        }
                    }
                %>
                <%= subjectName %>
            </td>
            <td>
                <%
                    String courseName = "";
                    if (courseList != null) {
                        for (Course c : courseList) {
                            if (c.getCourseId() == e.getCourseId()) {
                                courseName = c.getCourseName();
                                break;
                            }
                        }
                    }
                %>
                <%= courseName %>
            </td>
            <td><%= e.getExamDate() %></td>
            <td><%= e.getTotalMarks() %></td>
            <% if (user != null && user.getRoleId() == 2) { %>
            <td>
                <div class="action-links">
                    <a href="exam?action=edit&id=<%= e.getExamId() %>" class="edit-link">
                        <i class="fas fa-edit"></i> Edit
                    </a>
                    <a href="exam?action=delete&id=<%= e.getExamId() %>"
                       class="delete-link"
                       onclick="return confirm('Are you sure to delete this exam?');">
                        <i class="fas fa-trash-alt"></i> Delete
                    </a>
                </div>
            </td>
            <% } %>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } else { %>
    <div class="no-data">
        <i class="fas fa-file-alt" style="font-size: 2rem; margin-bottom: 10px; opacity: 0.5;"></i>
        <p>No exams found in the system</p>
    </div>
    <% } %>

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
