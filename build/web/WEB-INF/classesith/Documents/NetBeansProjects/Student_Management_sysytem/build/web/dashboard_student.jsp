<%@ page session="true" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRoleId() != 3) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4285f4;  /* Google blue */
            --primary-light: rgba(66, 133, 244, 0.1);
            --primary-dark: #3367d6;
            --dark-bg: #1a1a1a;
            --dark-panel: #2a2a2a;
            --light-text: #ffffff;
            --light-gray: #cccccc;
            --dark-gray: #666666;
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
            padding: 0;
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
                <h3>Student Portal</h3>
                <p><%= user.getFullName() %></p>
            </div>
            
            <div class="sidebar-menu">
                <a href="#" class="active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
                <a href="<%= request.getContextPath() %>/student?action=edit&id=<%= user.getUserId() %>">
                    <i class="fas fa-user-circle"></i>
                    <span>My Profile</span>
                </a>
                <a href="<%= request.getContextPath() %>/attendance?action=view" >
                    <i class="fas fa-calendar-check"></i>
                    <span>View Attendance</span>
                </a>
                <a href="grade_view.jsp">
                    <i class="fas fa-chart-bar"></i>
                    <span>View Grades</span>
                </a>
                <a href="<%= request.getContextPath() %>/assignment?action=view&student_id=<%= user.getUserId() %>">
                    <i class="fas fa-tasks"></i>
                    <span>View Assignments</span>
                </a>
                    
                 <a href="<%= request.getContextPath() %>/exam">
                    <i class="fas fa-clipboard-list"></i>
                    <span>View Exams</span>
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
                <h1>Student Dashboard</h1>
            </div>
            
            <div class="welcome-card">
                <h2>Welcome, <%= user.getFullName() %></h2>
                <p>Access your academic information and learning resources from this dashboard.</p>
            </div>
            
            <div class="features-grid">
                <a href="<%= request.getContextPath() %>/student?action=edit&id=<%= user.getUserId() %>" class="feature-card">
                    <i class="fas fa-user-circle"></i>
                    <h3>My Profile</h3>
                    <p>View and update your personal information</p>
                </a>
                
               <a href="<%= request.getContextPath() %>/attendance?action=view" class="feature-card">
                    <i class="fas fa-calendar-check"></i>
                    <h3>View Attendance</h3>
                    <p>Check your class attendance records</p>
                </a>
                
                <a href="grade_view.jsp" class="feature-card">
                    <i class="fas fa-chart-bar"></i>
                    <h3>View Grades</h3>
                    <p>See your academic performance and results</p>
                </a>
                
                <a href="<%= request.getContextPath() %>/assignment?action=view&student_id=<%= user.getUserId() %>" class="feature-card">
                    <i class="fas fa-tasks"></i>
                    <h3>View Assignments</h3>
                    <p>Access your current and past assignments</p>
                </a>
                    
                    <a href="<%= request.getContextPath() %>/exam" class="feature-card">
                    <i class="fas fa-clipboard-list"></i>
                    <h3>View Exams</h3>
                    <p>See upcoming and past exams</p>
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