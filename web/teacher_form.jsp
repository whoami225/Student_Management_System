<%@ page import="model.User" %>
<%
    User teacher = (User) request.getAttribute("teacher");
    boolean editMode = (teacher != null && teacher.getUserId() != 0);
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= editMode ? "Edit" : "Add" %> Teacher</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-box { max-width: 400px; margin: 0 auto; padding: 16px; border: 1px solid #ccc; border-radius: 5px; }
        label { display: block; margin-top: 10px; }
        input, select { width: 100%; padding: 6px; margin-top: 3px; }
        button { margin-top: 15px; background: #3366cc; color: #fff; padding: 8px 16px; border: none; border-radius: 5px;}
        a { display: inline-block; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="form-box">
        <h2><%= editMode ? "Edit" : "Add" %> Teacher</h2>
        <form action="TeacherServlet" method="post">
            <input type="hidden" name="id" value="<%= editMode ? teacher.getUserId() : "" %>"/>
            <label>Full Name:</label>
            <input type="text" name="full_name" value="<%= editMode ? teacher.getFullName() : "" %>" required/>
            <label>Email:</label>
            <input type="email" name="email" value="<%= editMode ? teacher.getEmail() : "" %>" required/>
            <label>Password:</label>
            <input type="password" name="password" <%= editMode ? "" : "required" %> />
            <input type="hidden" name="role_id" value="2"/>
            <label>Status:</label>
            <select name="status">
                <option value="active" <%= editMode && "active".equals(teacher.getStatus()) ? "selected" : "" %>>Active</option>
                <option value="inactive" <%= editMode && "inactive".equals(teacher.getStatus()) ? "selected" : "" %>>Inactive</option>
            </select>
            <button type="submit"><%= editMode ? "Update" : "Add" %> Teacher</button>
        </form>
        <a href="TeacherServlet">Back to Teacher List</a>
    </div>
</body>
</html>
