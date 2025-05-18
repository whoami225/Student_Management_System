<%@ page import="model.Assignment" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    List<Assignment> assignmentList = (List<Assignment>) request.getAttribute("assignmentList");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Assignments</title>
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
            --border-radius: 8px;
            --transition: all 0.3s;
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
            border-radius: var(--border-radius);
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            padding: 30px 24px;
        }
        h2 {
            color: var(--light-text);
            margin-bottom: 25px;
            font-size: 1.8rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            padding-bottom: 10px;
        }
        .assignment-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
            background: var(--dark-panel);
            border-radius: var(--border-radius);
            overflow: hidden;
        }
        .assignment-table th, .assignment-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255,255,255,0.07);
        }
        .assignment-table th {
            background: rgba(66,133,244,0.15);
            color: var(--light-text);
            font-weight: 600;
        }
        .assignment-table tr:hover {
            background-color: rgba(255,255,255,0.03);
        }
        .download-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: rgba(66,133,244,0.09);
            padding: 8px 13px;
            border-radius: 4px;
            transition: var(--transition);
        }
        .download-link:hover {
            background: rgba(66,133,244,0.2);
            color: white;
            text-decoration: none;
        }
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--light-gray);
            text-decoration: none;
            margin-top: 20px;
            padding: 10px 15px;
            border-radius: 6px;
            background-color: rgba(255,255,255,0.05);
            transition: var(--transition);
            font-weight: 500;
        }
        .back-link:hover {
            color: var(--primary);
            background-color: rgba(255,255,255,0.13);
        }
        .back-link i {
            margin-right: 5px;
        }
        .empty-state {
            text-align: center;
            padding: 40px 0 30px 0;
            color: var(--light-gray);
        }
        @media (max-width: 768px) {
            .assignment-table {
                display: block;
                overflow-x: auto;
            }
            .container {
                padding: 15px 6px;
            }
            h2 {
                font-size: 1.25rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-tasks"></i> Assignment List</h2>
        <% if (assignmentList != null && !assignmentList.isEmpty()) { %>
            <table class="assignment-table">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Due Date</th>
                        <th>Download</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Assignment a : assignmentList) { %>
                    <tr>
                        <td><%= a.getTitle() %></td>
                        <td><%= a.getDescription() %></td>
                        <td><%= a.getDueDate() %></td>
                        <td>
                            <a href="../<%= a.getFilePath() %>" class="download-link" target="_blank">
                                <i class="fas fa-download"></i> Download
                            </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="empty-state">
                <i class="fas fa-folder-open" style="font-size: 2.2rem; color: var(--primary); margin-bottom: 13px;"></i>
                <h3 style="color: var(--light-gray); font-size:1.1rem; margin:0;">No Assignments Found</h3>
                <p style="font-size:0.97rem;">There are currently no assignments available.</p>
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
