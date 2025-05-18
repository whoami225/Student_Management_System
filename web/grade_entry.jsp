<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Grades - SMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4285f4;
            --primary-dark: #3367d6;
            --dark-bg: #1a1a1a;
            --dark-panel: #2a2a2a;
            --light-text: #ffffff;
            --light-gray: #cccccc;
            --dark-gray: #666666;
            --error: #ff4d4d;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            color: var(--light-text);
            background-color: var(--dark-bg);
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: var(--dark-panel);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
        }

        h2 {
            color: var(--light-text);
            margin-bottom: 30px;
            font-size: 1.8rem;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background-color: var(--primary);
        }

        form {
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            color: var(--light-gray);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        select {
            width: 100%;
            padding: 12px 15px;
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            color: var(--light-text);
            font-size: 1rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 30px 0;
            background-color: rgba(255, 255, 255, 0.05);
        }

        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            text-align: left;
        }

        th {
            background-color: rgba(66, 133, 244, 0.2);
            color: var(--primary);
            font-weight: 600;
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.03);
        }

        input[type="number"] {
            padding: 8px 12px;
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            color: var(--light-text);
            width: 100px;
        }

        .submit-btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 12px 25px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: var(--primary-dark);
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: var(--light-gray);
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.05);
            transition: all 0.3s;
        }

        .back-link:hover {
            color: var(--light-text);
            background-color: rgba(255, 255, 255, 0.1);
        }

        .back-link i {
            margin-right: 8px;
        }

        .no-data {
            color: var(--light-gray);
            text-align: center;
            padding: 20px;
            font-style: italic;
        }

        @media(max-width: 768px) {
            .container {
                padding: 20px;
            }

            th, td {
                padding: 8px 10px;
                font-size: 0.9rem;
            }

            h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-clipboard-list"></i> Enter Grades</h2>

        <form method="post" action="${pageContext.request.contextPath}/grade">
            <div class="form-group">
                <label for="exam_id"><i class="fas fa-file-alt"></i> Exam:</label>
                <select id="exam_id" name="exam_id" required>
                    <c:if test="${not empty examList}">
                        <c:forEach var="e" items="${examList}">
                            <option value="${e.examId}">
                                ${e.examType} (Subject ID: ${e.subjectId})
                            </option>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty examList}">
                        <option disabled class="no-data">No exams available</option>
                    </c:if>
                </select>
            </div>

            <table>
                <thead>
                    <tr>
                        <th><i class="fas fa-id-card"></i> Student ID</th>
                        <th><i class="fas fa-user"></i> Full Name</th>
                        <th><i class="fas fa-user-shield"></i> Guardian</th>
                        <th><i class="fas fa-percent"></i> Marks</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty studentList}">
                        <c:forEach var="s" items="${studentList}">
                            <tr>
                                <td>
                                    <input type="hidden" name="student_id" value="${s.studentId}" />
                                    ${s.studentId}
                                </td>
                                <td>${s.fullName}</td>
                                <td>${s.guardianName}</td>
                                <td>
                                    <input type="number"
                                           name="marks_${s.studentId}"
                                           min="0" max="100"
                                           required
                                           placeholder="0-100" />
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty studentList}">
                        <tr>
                            <td colspan="4" class="no-data">
                                <i class="fas fa-user-slash"></i> No students found
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

            <div style="text-align: center;">
                <button type="submit" class="submit-btn">
                    <i class="fas fa-save"></i> Submit Grades
                </button>
                <br>
                <a href="dashboard_teacher.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </form>
    </div>
</body>
</html>