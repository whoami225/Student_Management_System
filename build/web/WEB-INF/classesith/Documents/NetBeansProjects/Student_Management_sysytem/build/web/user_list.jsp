<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }
        form {
            max-width: 400px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="password"], select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            margin-top: 20px;
            padding: 10px;
            background-color: #4285f4;
            border: none;
            color: white;
            cursor: pointer;
            font-size: 16px;
            border-radius: 4px;
        }
        input[type="submit"]:hover {
            background-color: #3367d6;
        }
    </style>
</head>
<body>

<h2>User Registration</h2>

<form method="post" action="UserServlet">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required />

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required />

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required />

    <label for="role">Role:</label>
    <select id="role" name="role" required>
        <option value="">-- Select Role --</option>
        <option value="admin">Admin</option>
        <option value="teacher">Teacher</option>
        <option value="student">Student</option>
    </select>

    <input type="submit" value="Register" />
</form>

</body>
</html>
