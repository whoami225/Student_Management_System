<%@ page session="true" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    int studentCount = (request.getAttribute("studentCount") != null) ? (Integer) request.getAttribute("studentCount") : 0;
    int userCount = (request.getAttribute("userCount") != null) ? (Integer) request.getAttribute("userCount") : 0;
    int courseCount = (request.getAttribute("courseCount") != null) ? (Integer) request.getAttribute("courseCount") : 0;
    int assignmentCount = (request.getAttribute("assignmentCount") != null) ? (Integer) request.getAttribute("assignmentCount") : 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary: #4285f4;
            --primary-dark: #3367d6;
            --primary-light: rgba(66, 133, 244, 0.1);
            --secondary: #4285f4;
            --success: #4CAF50;
            --warning: #FFA000;
            --danger: #F44336;
            --dark-bg: #1a1a1a;
            --dark-panel: #2a2a2a;
            --light-text: #ffffff;
            --light-gray: #cccccc;
            --dark-gray: #666666;
            --border-radius: 8px;
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
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
        
        /* Sidebar */
        .sidebar {
            width: 280px;
            background: var(--dark-panel);
            padding: 24px 0;
            transition: var(--transition);
            position: fixed;
            height: 100%;
            border-right: 1px solid rgba(255, 255, 255, 0.05);
            z-index: 100;
        }
        
        .sidebar-header {
            padding: 0 24px 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }
        
        .sidebar-header .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
        
        .sidebar-header .user-info h3 {
            color: var(--light-text);
            font-size: 1rem;
            margin-bottom: 4px;
        }
        
        .sidebar-header .user-info p {
            color: var(--light-gray);
            font-size: 0.8rem;
            opacity: 0.8;
        }
        
        .sidebar-menu {
            padding: 8px 0;
        }
        
        .sidebar-menu .menu-title {
            color: var(--light-gray);
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 12px 24px;
            margin-top: 16px;
            opacity: 0.7;
        }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 14px 24px;
            color: var(--light-gray);
            text-decoration: none;
            transition: var(--transition);
            margin: 4px 0;
            border-radius: 0 var(--border-radius) var(--border-radius) 0;
            position: relative;
        }
        
        .sidebar-menu a:hover {
            background: rgba(255, 255, 255, 0.05);
            color: var(--light-text);
        }
        
        .sidebar-menu a.active {
            background: var(--primary);
            color: white;
            font-weight: 500;
        }
        
        .sidebar-menu a.active::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background: white;
        }
        
        .sidebar-menu a i {
            margin-right: 12px;
            width: 20px;
            text-align: center;
            font-size: 1.1rem;
        }
        
        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 32px;
            background-color: var(--dark-bg);
            transition: var(--transition);
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }
        
        .header h1 {
            color: var(--light-text);
            font-size: 2rem;
            font-weight: 700;
        }
        
        .header-actions {
            display: flex;
            gap: 16px;
        }
        
        .search-bar {
            position: relative;
        }
        
        .search-bar input {
            background: var(--dark-panel);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: var(--border-radius);
            padding: 10px 16px 10px 40px;
            color: var(--light-text);
            width: 240px;
            transition: var(--transition);
        }
        
        .search-bar input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(66, 133, 244, 0.2);
        }
        
        .search-bar i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--light-gray);
        }
        
        .notification-btn {
            background: var(--dark-panel);
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            color: var(--light-gray);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            position: relative;
            transition: var(--transition);
        }
        
        .notification-btn:hover {
            background: rgba(255, 255, 255, 0.05);
            color: var(--light-text);
        }
        
        .notification-badge {
            position: absolute;
            top: -2px;
            right: -2px;
            background: var(--danger);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        /* Dashboard Cards */
        .welcome-card {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border-radius: var(--border-radius);
            padding: 32px;
            margin-bottom: 32px;
            color: white;
            position: relative;
            overflow: hidden;
        }
        
        .welcome-card::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }
        
        .welcome-card h2 {
            font-size: 1.8rem;
            margin-bottom: 12px;
            position: relative;
            z-index: 1;
        }
        
        .welcome-card p {
            opacity: 0.9;
            max-width: 60%;
            position: relative;
            z-index: 1;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
        }
        
        .stat-card {
            background: var(--dark-panel);
            border-radius: var(--border-radius);
            padding: 24px;
            transition: var(--transition);
            border-left: 4px solid var(--primary);
            display: flex;
            flex-direction: column;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        
        .stat-card .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 16px;
        }
        
        .stat-card .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: var(--primary-light);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 1.5rem;
        }
        
        .stat-card .stat-title {
            color: var(--light-gray);
            font-size: 0.9rem;
            margin-bottom: 8px;
        }
        
        .stat-card .stat-value {
            color: var(--light-text);
            font-size: 2rem;
            font-weight: 700;
            margin: 8px 0;
        }
        
        .stat-card .stat-change {
            display: flex;
            align-items: center;
            font-size: 0.85rem;
            margin-top: auto;
        }
        
        .stat-card .stat-change.positive {
            color: var(--success);
        }
        
        .stat-card .stat-change.negative {
            color: var(--danger);
        }
        
        /* Charts Section */
        .charts-section {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
            margin-bottom: 32px;
        }
        
        .chart-container {
            background: var(--dark-panel);
            border-radius: var(--border-radius);
            padding: 24px;
            transition: var(--transition);
        }
        
        .chart-container:hover {
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        
        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .chart-header h3 {
            color: var(--light-text);
            font-size: 1.1rem;
            font-weight: 600;
        }
        
        .chart-header .chart-actions {
            display: flex;
            gap: 8px;
        }
        
        .chart-header .chart-actions button {
            background: rgba(255, 255, 255, 0.05);
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 8px;
            color: var(--light-gray);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .chart-header .chart-actions button:hover {
            background: var(--primary);
            color: white;
        }
        
        /* Chart Canvas Containers */
        .chart-wrapper {
            height: 220px;
            position: relative;
        }
        
        /* Recent Activity */
        .recent-activity {
            background: var(--dark-panel);
            border-radius: var(--border-radius);
            padding: 24px;
        }
        
        .activity-item {
            display: flex;
            gap: 16px;
            padding: 16px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary-light);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 1rem;
            flex-shrink: 0;
        }
        
        .activity-content h4 {
            color: var(--light-text);
            font-size: 0.95rem;
            margin-bottom: 4px;
        }
        
        .activity-content p {
            color: var(--light-gray);
            font-size: 0.85rem;
            opacity: 0.8;
        }
        
        .activity-time {
            color: var(--light-gray);
            font-size: 0.75rem;
            margin-top: 4px;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        
        /* Responsive Design */
        @media (max-width: 1200px) {
            .charts-section {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
                padding: 16px 0;
            }
            
            .sidebar-header .user-info,
            .sidebar-menu span,
            .menu-title {
                display: none;
            }
            
            .sidebar-header {
                justify-content: center;
                padding: 0 0 16px;
            }
            
            .sidebar-menu a {
                justify-content: center;
                padding: 16px 8px;
                margin: 4px 0;
                border-radius: var(--border-radius);
            }
            
            .sidebar-menu a i {
                margin-right: 0;
                font-size: 1.2rem;
            }
            
            .main-content {
                margin-left: 80px;
                padding: 24px;
            }
        }
        
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }
            
            .header-actions {
                width: 100%;
                justify-content: space-between;
            }
            
            .search-bar input {
                width: 100%;
            }
            
            .stats-grid {
                grid-template-columns: 1fr 1fr;
            }
        }
        
        @media (max-width: 576px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .main-content {
                padding: 16px;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="avatar">
                    <%= user.getFullName().charAt(0) %>
                </div>
                <div class="user-info">
                    <h3><%= user.getFullName() %></h3>
                    <p>Administrator</p>
                </div>
            </div>
            
            <div class="sidebar-menu">
                <div class="menu-title">Main</div>
                <a href="#" class="active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
                
                <div class="menu-title">Management</div>
                <a href="<%= request.getContextPath() %>/student?action=list">
                    <i class="fas fa-users"></i>
                    <span>Students</span>
                </a>
                <a href="<%= request.getContextPath() %>/TeacherServlet?action=list">
                    <i class="fas fa-chalkboard-teacher"></i>
                    <span>Teachers</span>
                </a>
                <a href="<%= request.getContextPath() %>/course">
                    <i class="fas fa-book"></i>
                    <span>Courses</span>
                </a>
                             
                <a href="messages_menu.jsp" class="nav-link">
                    <i class="fas fa-envelope"></i> Messages
                </a>

                
                <a href="<%= request.getContextPath() %>/logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>Dashboard Overview</h1>
                <div class="header-actions">
                    <div class="search-bar">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Search...">
                    </div>
                    <button class="notification-btn">
                        <i class="fas fa-bell"></i>
                        <span class="notification-badge">3</span>
                    </button>
                </div>
            </div>
            
            <div class="welcome-card">
                <h2>Welcome back, <%= user.getFullName() %></h2>
                <p>Here's what's happening with your institution today. You have 3 new notifications and 5 pending tasks.</p>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-header">
                        <div>
                            <div class="stat-title">Total Students</div>
                            <div class="stat-value"> <%= studentCount %></div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                    <div class="stat-change positive">
                        <i class="fas fa-arrow-up"></i> 12% from last month
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-header">
                        <div>
                            <div class="stat-title">Total Teachers</div>
                            <div class="stat-value">  <%= userCount %></div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                    </div>
                    <div class="stat-change positive">
                        <i class="fas fa-arrow-up"></i> 5% from last month
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-header">
                        <div>
                            <div class="stat-title">Active Courses</div>
                            <div class="stat-value"> <%= courseCount %></div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-book"></i>
                        </div>
                    </div>
                    <div class="stat-change negative">
                        <i class="fas fa-arrow-down"></i> 2% from last month
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-header">
                        <div>
                            <div class="stat-title">Assignments</div>
                            <div class="stat-value"><%= assignmentCount %></div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-tasks"></i>
                        </div>
                    </div>
                    <div class="stat-change positive">
                        <i class="fas fa-arrow-up"></i> 24% from last month
                    </div>
                </div>
            </div>
            
            <div class="charts-section">
                <div class="chart-container">
                    <div class="chart-header">
                        <h3>Student Enrollment Trends</h3>
                        <div class="chart-actions">
                            <button><i class="fas fa-ellipsis-h"></i></button>
                        </div>
                    </div>
                    <div class="chart-wrapper">
                        <canvas id="enrollmentChart"></canvas>
                    </div>
                </div>
                
                <div class="recent-activity">
                    <div class="chart-header">
                        <h3>Recent Activity</h3>
                        <div class="chart-actions">
                            <button><i class="fas fa-ellipsis-h"></i></button>
                        </div>
                    </div>
                    <div class="activity-list">
                        <div class="activity-item">
                            <div class="activity-icon">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <div class="activity-content">
                                <h4>New Student Registered</h4>
                                <p>John Doe enrolled in Computer Science</p>
                                <div class="activity-time">
                                    <i class="far fa-clock"></i> 2 hours ago
                                </div>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-icon">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="activity-content">
                                <h4>Course Updated</h4>
                                <p>Mathematics 101 syllabus was modified</p>
                                <div class="activity-time">
                                    <i class="far fa-clock"></i> 5 hours ago
                                </div>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-icon">
                                <i class="fas fa-tasks"></i>
                            </div>
                            <div class="activity-content">
                                <h4>Assignment Submitted</h4>
                                <p>15 students submitted Physics assignment</p>
                                <div class="activity-time">
                                    <i class="far fa-clock"></i> 1 day ago
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="chart-container">
                <div class="chart-header">
                    <h3>Grade Distribution</h3>
                    <div class="chart-actions">
                        <button><i class="fas fa-calendar-alt"></i> This Semester</button>
                        <button><i class="fas fa-ellipsis-h"></i></button>
                    </div>
                </div>
                <div class="chart-wrapper">
                    <canvas id="gradeChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Enrollment Chart
        const enrollmentCtx = document.getElementById('enrollmentChart');
        new Chart(enrollmentCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'New Students',
                    data: [15, 30, 22, 45, 32, 60],
                    borderColor: 'rgba(66, 133, 244, 1)',
                    backgroundColor: 'rgba(66, 133, 244, 0.1)',
                    tension: 0.3,
                    fill: true,
                    borderWidth: 2,
                    pointBackgroundColor: 'white',
                    pointBorderColor: 'rgba(66, 133, 244, 1)',
                    pointRadius: 4,
                    pointHoverRadius: 6
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(42, 42, 42, 0.9)',
                        titleColor: 'white',
                        bodyColor: 'white',
                        borderColor: 'rgba(255, 255, 255, 0.1)',
                        borderWidth: 1,
                        padding: 12,
                        usePointStyle: true
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(255, 255, 255, 0.05)'
                        },
                        ticks: {
                            color: 'rgba(255, 255, 255, 0.7)'
                        }
                    },
                    x: {
                        grid: {
                            color: 'rgba(255, 255, 255, 0.05)'
                        },
                        ticks: {
                            color: 'rgba(255, 255, 255, 0.7)'
                        }
                    }
                }
            }
        });

        // Grade Distribution Chart
        const gradeCtx = document.getElementById('gradeChart');
        new Chart(gradeCtx, {
            type: 'bar',
            data: {
                labels: ['Math', 'Science', 'English', 'History', 'Art', 'Physics'],
                datasets: [{
                    label: 'Average Grade',
                    data: [85, 78, 92, 74, 88, 81],
                    backgroundColor: [
                        'rgba(66, 133, 244, 0.7)',
                        'rgba(66, 133, 244, 0.5)',
                        'rgba(66, 133, 244, 0.7)',
                        'rgba(66, 133, 244, 0.5)',
                        'rgba(66, 133, 244, 0.7)',
                        'rgba(66, 133, 244, 0.5)'
                    ],
                    borderColor: [
                        'rgba(66, 133, 244, 1)',
                        'rgba(66, 133, 244, 1)',
                        'rgba(66, 133, 244, 1)',
                        'rgba(66, 133, 244, 1)',
                        'rgba(66, 133, 244, 1)',
                        'rgba(66, 133, 244, 1)'
                    ],
                    borderWidth: 1,
                    borderRadius: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(42, 42, 42, 0.9)',
                        titleColor: 'white',
                        bodyColor: 'white',
                        borderColor: 'rgba(255, 255, 255, 0.1)',
                        borderWidth: 1,
                        padding: 12,
                        usePointStyle: true
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100,
                        grid: {
                            color: 'rgba(255, 255, 255, 0.05)'
                        },
                        ticks: {
                            color: 'rgba(255, 255, 255, 0.7)'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            color: 'rgba(255, 255, 255, 0.7)'
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>