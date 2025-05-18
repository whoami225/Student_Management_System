<%@ page session="true" %>
<%@ page import="model.User" %>
<%@ page import="model.Course" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRoleId() != 2) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    Course course = (Course) request.getAttribute("course");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4285f4; /* Professional blue */
            --primary-light: rgba(66, 133, 244, 0.1);
            --primary-dark: #3367d6;
            --dark-bg: #1a1a1a;
            --dark-panel: #2a2a2a;
            --light-text: #ffffff;
            --light-gray: #cccccc;
            --dark-gray: #666666;
            --success: #28a745;
            --error: #ff4d4d;
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
            min-height: 100vh;
        }
        
        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }
        
        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            background: var(--dark-panel);
            padding: 20px 0;
            transition: all 0.3s;
            position: fixed;
            height: 100%;
            border-right: 1px solid rgba(255, 255, 255, 0.05);
        }
        
        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 20px;
        }
        
        .sidebar-header h3 {
            color: var(--light-text);
            margin-bottom: 5px;
            font-size: 1.3rem;
        }
        
        .sidebar-header p {
            color: var(--light-gray);
            font-size: 0.9rem;
        }
        
        .sidebar-menu {
            padding: 10px 0;
        }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: var(--light-gray);
            text-decoration: none;
            transition: all 0.3s;
            margin: 5px 10px;
            border-radius: 5px;
        }
        
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: var(--primary);
            color: white;
        }
        
        .sidebar-menu a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .sidebar-menu .logout-link {
            margin-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 20px;
        }
        
        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: 250px;
            padding: 30px;
            background-color: var(--dark-bg);
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .header h1 {
            color: var(--light-text);
            font-size: 1.8rem;
        }
        
        .welcome-card {
            background: var(--dark-panel);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 30px;
            border-left: 4px solid var(--primary);
        }
        
        .welcome-card h2 {
            color: var(--primary);
            margin-bottom: 10px;
        }
        
        .welcome-card p {
            color: var(--light-gray);
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        
        .feature-card {
            background: var(--dark-panel);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: all 0.3s;
            text-decoration: none;
            color: inherit;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            border-color: var(--primary);
        }
        
        .feature-card i {
            font-size: 2rem;
            margin-bottom: 15px;
            color: var(--primary);
        }
        
        .feature-card h3 {
            margin-bottom: 10px;
            color: var(--light-text);
        }
        
        .feature-card p {
            color: var(--light-gray);
            font-size: 0.9rem;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar {
                width: 80px;
                overflow: hidden;
            }
            
            .sidebar-header h3, .sidebar-header p, .sidebar-menu span {
                display: none;
            }
            
            .sidebar-menu a {
                justify-content: center;
                padding: 15px 10px;
                margin: 5px;
            }
            
            .sidebar-menu a i {
                margin-right: 0;
                font-size: 1.2rem;
            }
            
            .main-content {
                margin-left: 80px;
                padding: 20px;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <h3>Teacher Portal</h3>
                <p><%= user.getFullName() %></p>
            </div>
            
            <div class="sidebar-menu">
                <a href="#" class="active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
                <a href="<%= request.getContextPath() %>/attendance?action=mark">
                    <i class="fas fa-user-check"></i>
                    <span>Mark Attendance</span>
                </a>
                <a href="assignment_upload.jsp">
                    <i class="fas fa-file-upload"></i>
                    <span>Upload Assignment</span>
                </a>
                <a href="<%= request.getContextPath() %>/grade">
                    <i class="fas fa-graduation-cap"></i>
                    <span>Enter Grades</span>
                </a>
                <a href="<%= request.getContextPath() %>/course">
                    <i class="fas fa-book"></i>
                    <span>Course List</span>
                </a>
                <a href="<%= request.getContextPath() %>/student?action=list">
                    <i class="fas fa-users"></i>
                    <span>Student List</span>
                </a>
                <a href="<%= request.getContextPath() %>/subject?action=list&course_id=<%= (course != null) ? course.getCourseId() : 1 %>">
                    <i class="fas fa-book-open"></i>
                    <span>View Subjects</span>
                </a>
                <a href="<%= request.getContextPath() %>/exam?action=form">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Manage Exams</span>
                </a>
                    
                    <a href="messages_menu.jsp" class="nav-link">
                    <i class="fas fa-envelope"></i> Messages
                </a>

                <a href="<%= request.getContextPath() %>/logout" class="logout-link">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>Teacher Dashboard</h1>
            </div>
            
            <div class="welcome-card">
                <h2>Welcome back, <%= user.getFullName() %></h2>
                <p>Manage your classes, students, and teaching materials from this centralized dashboard.</p>
            </div>
            
            <div class="features-grid">
               <a href="<%= request.getContextPath() %>/attendance?action=mark" class="feature-card">
                    <i class="fas fa-user-check"></i>
                    <h3>Mark Attendance</h3>
                    <p>Record and manage student attendance for your classes</p>
                </a>
                
                <a href="assignment_upload.jsp" class="feature-card">
                    <i class="fas fa-file-upload"></i>
                    <h3>Upload Assignment</h3>
                    <p>Post new assignments and learning materials</p>
                </a>
                
                <a href="<%= request.getContextPath() %>/grade" class="feature-card">
                    <i class="fas fa-graduation-cap"></i>
                    <h3>Enter Grades</h3>
                    <p>Submit and manage student assessments</p>
                </a>
                
                <a href="<%= request.getContextPath() %>/course" class="feature-card">
                    <i class="fas fa-book"></i>
                    <h3>Course List</h3>
                    <p>View all your assigned courses</p>
                </a>
                
                <a href="<%= request.getContextPath() %>/student?action=list" class="feature-card">
                    <i class="fas fa-users"></i>
                    <h3>Student List</h3>
                    <p>Access your student roster and profiles</p>
                </a>
                
                <a href="<%= request.getContextPath() %>/subject?action=list&course_id=<%= (course != null) ? course.getCourseId() : 1 %>" class="feature-card">
                    <i class="fas fa-book-open"></i>
                    <h3>View Subjects</h3>
                    <p>Access subject materials and curriculum</p>
                </a>
                
                <a href="<%= request.getContextPath() %>/exam?action=form" class="feature-card">
                    <i class="fas fa-calendar-alt"></i>
                    <h3>Manage Exams</h3>
                    <p>Schedule and organize examinations</p>
                </a>
                    
                <a href="messages_menu.jsp" class="feature-card">
                    <i class="fas fa-envelope-open-text"></i>
                    <h3>Messages</h3>
                    <p>Send and receive messages</p>
                </a>
            </div>
        </div>
    </div>
</body>
</html>