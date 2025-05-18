 
    <%-- src/main/webapp/messages_receive.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Received Messages</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Received Messages</h2>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>From</th>
                <th>Subject</th>
                <th>Message</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="message" items="${messages}">
                <tr>
                    <td>${message.senderId}</td>
                    <td>${message.subject}</td>
                    <td>${message.content}</td>
                    <td>${message.timestamp}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
