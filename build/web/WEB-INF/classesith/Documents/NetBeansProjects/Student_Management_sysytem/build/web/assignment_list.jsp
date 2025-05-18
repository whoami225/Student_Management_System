<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Assignment List</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 1000px; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .download-link { color: #0066cc; text-decoration: none; }
        .download-link:hover { text-decoration: underline; }
        .filter-form { margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Assignment List</h2>
        
        <div class="filter-form">
            <form action="assignment" method="get">
                <label for="subject_id">Filter by Subject:</label>
                <select id="subject_id" name="subject_id" onchange="this.form.submit()">
                    <option value="">All Subjects</option>
                    <option value="1" ${param.subject_id == '1' ? 'selected' : ''}>Mathematics</option>
                    <option value="2" ${param.subject_id == '2' ? 'selected' : ''}>Science</option>
                    <option value="3" ${param.subject_id == '3' ? 'selected' : ''}>English</option>
                    <option value="4" ${param.subject_id == '4' ? 'selected' : ''}>History</option>
                </select>
            </form>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Subject</th>
                    <th>Description</th>
                    <th>Upload Date</th>
                    <th>Due Date</th>
                    <th>Download</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="assignment" items="${assignments}">
                    <tr>
                        <td>${assignment.title}</td>
                        <td>
                            <c:choose>
                                <c:when test="${assignment.subjectId == 1}">Mathematics</c:when>
                                <c:when test="${assignment.subjectId == 2}">Science</c:when>
                                <c:when test="${assignment.subjectId == 3}">English</c:when>
                                <c:when test="${assignment.subjectId == 4}">History</c:when>
                                <c:otherwise>Unknown</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${assignment.description}</td>
                        <td>${assignment.uploadDate}</td>
                        <td>${assignment.dueDate}</td>
                        <td>
                            <a href="${assignment.filePath}" class="download-link" download>Download</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <div style="margin-top: 20px;">
            <a href="assignment_form.jsp" style="background-color: #4CAF50; color: white; padding: 10px 15px; 
               text-decoration: none; border-radius: 4px;">Upload New Assignment</a>
        </div>
    </div>
</body>
</html>