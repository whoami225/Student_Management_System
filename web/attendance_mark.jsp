<%@ page import="java.util.List" %>
<%@ page import="model.Student, model.Subject" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance - SMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4285f4;
            --primary-dark: #3367d6;
            --primary-light: rgba(66, 133, 244, 0.1);
            --dark-bg: #1a1a1a;
            --dark-panel: #2a2a2a;
            --light-text: #ffffff;
            --light-gray: #cccccc;
            --dark-gray: #666666;
            --error: #ff4d4d;
            --success: #4caf50;
            --border-radius: 8px;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            min-height: 100vh;
            color: var(--light-text);
            background-color: var(--dark-bg);
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: var(--dark-panel);
            padding: 30px 24px;
            border-radius: var(--border-radius);
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
        }

        h2 {
            color: var(--light-text);
            margin-bottom: 30px;
            font-size: 1.8rem;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        form {
            margin-top: 20px;
        }

        .date-picker {
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        label {
            color: var(--light-gray);
            font-weight: 500;
        }

        input[type="date"] {
            padding: 10px 15px;
            background-color: rgba(255,255,255,0.05);
            border: 1px solid var(--dark-gray);
            border-radius: 5px;
            color: var(--light-text);
            font-size: 1rem;
            transition: var(--transition);
        }
        input[type="date"]:focus {
            border-color: var(--primary);
            outline: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 30px 0;
            background-color: var(--dark-panel);
            border-radius: var(--border-radius);
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255,255,255,0.08);
        }

        th {
            background: rgba(66,133,244,0.15);
            font-weight: 600;
            color: var(--light-text);
        }

        tr:hover {
            background: rgba(255,255,255,0.03);
        }

        .radio-group {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        input[type="radio"] {
            accent-color: var(--primary);
        }

        .no-students {
            color: var(--light-gray);
            text-align: center;
            padding: 20px;
            font-style: italic;
        }

        .submit-btn {
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px 25px;
            cursor: pointer;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 600;
            margin: 30px auto;
            display: block;
            transition: background 0.3s, transform 0.2s;
            box-shadow: 0 2px 10px rgba(66,133,244,0.10);
        }

        .submit-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(66,133,244,0.14);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 20px;
            color: var(--light-gray);
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 6px;
            background-color: rgba(255,255,255,0.05);
            transition: all 0.3s;
        }
        .back-link:hover {
            color: var(--primary);
            background-color: rgba(255,255,255,0.10);
        }
        .back-link i {
            margin-right: 8px;
        }

        @media(max-width: 768px) {
            .container {
                padding: 18px 6px;
            }
            th, td {
                padding: 8px 6px;
                font-size: 0.95rem;
            }
            h2 {
                font-size: 1.3rem;
            }
            .radio-group {
                flex-direction: column;
                gap: 4px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-clipboard-check"></i> Mark Attendance</h2>
        <form method="post" action="attendance">
            <div class="date-picker">
                <label for="attendanceDate"><i class="far fa-calendar-alt"></i> Attendance Date:</label>
                <input type="date" name="attendance_date" id="attendanceDate" required 
                       value="<%= new java.sql.Date(System.currentTimeMillis()) %>">
            </div>
            <table>
                <thead>
                    <tr>
                        <th><i class="fas fa-id-card"></i> Student ID</th>
                        <th><i class="fas fa-user"></i> Student Name</th>
                        <th><i class="fas fa-user-shield"></i> Guardian Name</th>
                        <th colspan="2"><i class="fas fa-user-check"></i> Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Student> studentList = (List<Student>) request.getAttribute("studentList");
                        if(studentList != null && !studentList.isEmpty()) {
                            for(Student student : studentList) {
                    %>
                    <tr>
                        <td><%= student.getStudentId() %></td>
                        <td><%= student.getFullName() %></td>
                        <td><%= student.getGuardianName() %></td>
                        <td colspan="2">
                            <div class="radio-group">
                                <label>
                                    <input type="radio" name="attendance_status_<%= student.getStudentId() %>" value="present" required>
                                    Present
                                </label>
                                <label>
                                    <input type="radio" name="attendance_status_<%= student.getStudentId() %>" value="absent" required>
                                    Absent
                                </label>
                            </div>
                        </td>
                        <input type="hidden" name="student_id" value="<%= student.getStudentId() %>">
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" class="no-students">
                            <i class="fas fa-user-slash"></i> No students found
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <button type="submit" class="submit-btn">
                <i class="fas fa-save"></i> Submit Attendance
            </button>
        </form>
        <a href="dashboard_teacher.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</body>
</html>
