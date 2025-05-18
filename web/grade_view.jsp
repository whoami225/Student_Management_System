<%@ page import="model.Grade" %>
<%@ page import="java.util.List" %>
<%
    List<Grade> gradeList = (new dao.GradeDAO()).getGradesByStudent(1); // Replace with dynamic student ID
%>
<!DOCTYPE html>
<html>
<head>
    <title>Grade Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            --success: #4CAF50;
            --warning: #FFC107;
            --danger: #F44336;
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
            background: linear-gradient(rgba(40, 50, 60, 0.85), rgba(40, 50, 60, 0.85));
            color: var(--light-text);
            min-height: 100vh;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .header h2 {
            font-size: 1.8rem;
            color: var(--light-text);
        }
        
        .back-btn {
            background-color: var(--primary);
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: background-color 0.3s;
        }
        
        .back-btn:hover {
            background-color: var(--primary-dark);
        }
        
        .back-btn i {
            margin-right: 8px;
        }
        
        .card {
            background: var(--dark-panel);
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .grade-summary {
            display: flex;
            justify-content: space-around;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .summary-item {
            background: rgba(0,0,0,0.3);
            border-radius: 6px;
            padding: 15px 20px;
            text-align: center;
            flex: 1;
            min-width: 150px;
        }
        
        .summary-item h3 {
            font-size: 0.9rem;
            color: var(--light-gray);
            margin-bottom: 8px;
        }
        
        .summary-item p {
            font-size: 1.5rem;
            font-weight: 600;
        }
        
        .grade-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .grade-table th {
            background-color: var(--primary);
            color: white;
            padding: 12px 15px;
            text-align: left;
        }
        
        .grade-table td {
            padding: 12px 15px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .grade-table tr:hover {
            background-color: rgba(255,255,255,0.05);
        }
        
        .grade-table tr:nth-child(even) {
            background-color: rgba(0,0,0,0.1);
        }
        
        .grade-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .grade-A { background-color: var(--success); }
        .grade-B { background-color: #8BC34A; }
        .grade-C { background-color: var(--warning); color: #000; }
        .grade-D { background-color: #FF9800; color: #000; }
        .grade-F { background-color: var(--danger); }
        
        .no-grades {
            text-align: center;
            padding: 30px;
            color: var(--light-gray);
        }
        
        .chart-container {
            margin-top: 30px;
            height: 300px;
            background: rgba(0,0,0,0.2);
            border-radius: 8px;
            padding: 15px;
        }
        
        @media (max-width: 768px) {
            .grade-summary {
                flex-direction: column;
            }
            
            .grade-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Student Grade Report</h2>
            <a href="dashboard_student.jsp" class="back-btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <div class="card">
            <div class="grade-summary">
                <div class="summary-item">
                    <h3>Average Grade</h3>
                    <p>B+</p>
                </div>
                <div class="summary-item">
                    <h3>Highest Grade</h3>
                    <p>A (95%)</p>
                </div>
                <div class="summary-item">
                    <h3>Lowest Grade</h3>
                    <p>C (72%)</p>
                </div>
                <div class="summary-item">
                    <h3>Exams Taken</h3>
                    <p><%= gradeList.size() %></p>
                </div>
            </div>
            
            <% if (gradeList == null || gradeList.isEmpty()) { %>
                <div class="no-grades">
                    <i class="fas fa-book-open" style="font-size: 2rem; margin-bottom: 15px;"></i>
                    <p>No grade records found</p>
                </div>
            <% } else { %>
                <table class="grade-table">
                    <thead>
                        <tr>
                            <th>Exam ID</th>
                            <th>Subject</th>
                            <th>Exam Date</th>
                            <th>Marks Obtained</th>
                            <th>Percentage</th>
                            <th>Grade</th>
                        </tr>
                    </thead>
                    <tbody>
            <%
                for (model.Grade g : gradeList) {
            %>
                <tr>
                    <td><%= g.getExamId() %></td>
                    <td><%= g.getSubjectName() != null ? g.getSubjectName() : "N/A" %></td>
                    <td><%= g.getExamDate() != null ? g.getExamDate().toString() : "N/A" %></td>
                    <td><%= g.getMarksObtained() %></td>
                    <td><%= g.getPercentage() %></td>
                    <td>
                        <span class="grade-badge grade-<%= g.getGradeLetter() %>"><%= g.getGradeLetter() %></span>
                    </td>
                </tr>
            <%
                }
            %>
        </tbody>
                        
                      
                </table>
                
                <div class="chart-container">
                    <!-- Placeholder for chart - would be implemented with Chart.js in a real application -->
                    <p style="text-align: center; padding-top: 120px; color: var(--light-gray);">
                        <i class="fas fa-chart-line" style="font-size: 2rem;"></i><br>
                        Grade Performance Chart
                    </p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>