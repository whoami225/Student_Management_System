<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Notifications</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .filter-form {
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f5f5f5;
            border-radius: 5px;
        }
        .notification {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #fff;
        }
        .notification.student {
            border-left: 5px solid #4CAF50;
        }
        .notification.teacher {
            border-left: 5px solid #2196F3;
        }
        .notification.all {
            border-left: 5px solid #FF9800;
        }
        .notification-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .notification-title {
            color: #333;
            font-size: 1.2em;
        }
        .notification-date {
            color: #666;
            font-size: 0.9em;
        }
        .notification-role {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 3px;
            font-size: 0.8em;
            color: white;
        }
        .role-student {
            background-color: #4CAF50;
        }
        .role-teacher {
            background-color: #2196F3;
        }
        .role-all {
            background-color: #FF9800;
        }
        .create-btn {
            display: block;
            text-align: center;
            margin: 20px 0;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .create-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Notifications</h1>
    
    <div class="filter-form">
        <form method="get" action="${pageContext.request.contextPath}/notifications">
            <label for="role">Filter by role:</label>
            <select id="role" name="role" onchange="this.form.submit()">
                <option value="">All Notifications</option>
                <option value="All" ${param.role == 'All' ? 'selected' : ''}>For Everyone</option>
                <option value="Student" ${param.role == 'Student' ? 'selected' : ''}>For Students</option>
                <option value="Teacher" ${param.role == 'Teacher' ? 'selected' : ''}>For Teachers</option>
            </select>
        </form>
    </div>
    
    <a href="${pageContext.request.contextPath}/notification_form.jsp" class="create-btn">Create New Notification</a>
    
    <c:choose>
        <c:when test="${not empty notifications}">
            <c:forEach var="notification" items="${notifications}">
                <div class="notification ${notification.targetRole.toLowerCase()}">
                    <div class="notification-header">
                        <span class="notification-title">${notification.title}</span>
                        <span class="notification-date">
                            <fmt:formatDate value="${notification.datePosted}" pattern="MMM dd, yyyy hh:mm a" />
                        </span>
                    </div>
                    <div class="notification-message">${notification.message}</div>
                    <div>
                        <span class="notification-role role-${notification.targetRole.toLowerCase()}">
                            ${notification.targetRole}
                        </span>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>No notifications found.</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>