<%-- 
    <%-- src/main/webapp/messages.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Send Message</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Compose Message</h2>
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">${error}</div>
    <% } %>
    
    <form action="messages" method="post">
        <div class="form-group">
            <label>Sender ID:</label>
            <input type="number" name="sender_id" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Receiver ID:</label>
            <input type="number" name="receiver_id" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Subject:</label>
            <input type="text" name="subject" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Message:</label>
            <textarea name="content" class="form-control" rows="4" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Send Message</button>
    </form>
</div>
</body>
</html>