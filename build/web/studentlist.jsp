<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student List</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        tr:hover { background-color: #f5f5f5; }
    </style>
</head>
<body>
    <h1>Student Management</h1>
    <a href="students?action=new">Add New Student</a>
    <br><br>
    
    <table>
        <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Admission Date</th>
            <th>Batch ID</th>
            <th>Guardian Name</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="student" items="${students}">
            <tr>
                <td>${student.studentId}</td>
                <td>${student.userId}</td>
                <td>${student.admissionDate}</td>
                <td>${student.batchId}</td>
                <td>${student.guardianName}</td>
                <td>
                    <a href="students?action=edit&id=${student.studentId}">Edit</a>
                    <a href="students?action=delete&id=${student.studentId}" 
                       onclick="return confirm('Are you sure you want to delete this student?')">Delete</a>
                    <a href="students?action=profile&id=${student.studentId}">View</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>