<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Create Notification</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 600px; margin: 0 auto; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], textarea, select { width: 100%; padding: 8px; }
        textarea { height: 100px; }
        button { padding: 10px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        button:hover { background-color: #45a049; }
        .message { padding: 10px; margin-bottom: 15px; border-radius: 4px; }
        .success { background-color: #dff0d8; color: #3c763d; }
        .error { background-color: #f2dede; color: #a94442; }
    </style>
</head>
<body>
<div class="container">
    <h1>Create New Notification</h1>
    
    <c:if test="${not empty successMessage}">
        <div class="message success">${successMessage}</div>
    </c:if>
    
    <c:if test="${not empty errorMessage}">
        <div class="message error">${errorMessage}</div>
    </c:if>
    
    <form action="${pageContext.request.contextPath}/notifications" method="post">
        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required>
        </div>
        
        <div class="form-group">
            <label for="message">Message:</label>
            <textarea id="message" name="message" required></textarea>
        </div>
        
        <div class="form-group">
            <label for="targetRole">Target Audience:</label>
            <select id="targetRole" name="targetRole" required>
                <option value="All">All Users</option>
                <option value="Student">Students Only</option>
                <option value="Teacher">Teachers Only</option>
            </select>
        </div>
        
        <button type="submit">Send Notification</button>
    </form>
    
    <p><a href="${pageContext.request.contextPath}/notifications">View All Notifications</a></p>
</div>
</body>
</html>