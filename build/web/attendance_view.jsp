<%@ page import="java.util.List" %>
<%@ page import="model.Attendance" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Records</title>
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
            --error: #ff4d4d;
            --success: #4caf50;
            --warning: #ff9800;
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
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .header h2 {
            font-size: 1.8rem;
            color: var(--light-text);
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }
        
        .back-link:hover {
            color: var(--light-gray);
            text-decoration: underline;
        }
        
        .back-link i {
            margin-right: 8px;
        }
        
        .card {
            background: var(--dark-panel);
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .filters {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        .filter-group {
            flex: 1;
            min-width: 200px;
        }
        
        .filter-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--light-gray);
            font-size: 0.9rem;
        }
        
        .filter-group select, 
        .filter-group input {
            width: 100%;
            padding: 10px 15px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            color: var(--light-text);
            font-size: 0.95rem;
        }
        
        .filter-group select:focus, 
        .filter-group input:focus {
            outline: none;
            border-color: var(--primary);
        }
        
        .table-container {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        th {
            background-color: var(--primary);
            color: white;
            font-weight: 600;
            position: sticky;
            top: 0;
        }
        
        tr:hover {
            background-color: rgba(255, 255, 255, 0.03);
        }
        
        .status-present {
            color: var(--success);
            font-weight: 500;
        }
        
        .status-absent {
            color: var(--error);
            font-weight: 500;
        }
        
        .status-late {
            color: var(--warning);
            font-weight: 500;
        }
        
        .no-records {
            text-align: center;
            padding: 40px;
            color: var(--light-gray);
            font-size: 1.1rem;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            gap: 10px;
        }
        
        .pagination a, 
        .pagination span {
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            color: var(--light-text);
            background: rgba(255, 255, 255, 0.05);
            transition: all 0.3s;
        }
        
        .pagination a:hover {
            background: var(--primary);
        }
        
        .pagination .active {
            background: var(--primary);
            font-weight: bold;
        }
        
        @media (max-width: 768px) {
            .filters {
                flex-direction: column;
                gap: 10px;
            }
            
            .filter-group {
                width: 100%;
            }
            
            th, td {
                padding: 8px 10px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>Attendance Records</h2>
        <a href="dashboard_student.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
    
   
        
        <div class="table-container">
            
            
            <%
                List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attendanceList");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                if (attendanceList == null || attendanceList.isEmpty()) {
            %>
                <div class="no-records">
                    <i class="fas fa-calendar-times" style="font-size: 2rem; margin-bottom: 15px;"></i>
                    <p>No attendance records found for the selected criteria.</p>
                </div>
            <%
                } else {
            %>
                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Student ID</th>
                            <th>Status</th>
                            <th>Remarks</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Attendance a : attendanceList) {
                                String statusClass = "";
                                switch(a.getStatus().toLowerCase()) {
                                    case "present": statusClass = "status-present"; break;
                                    case "absent": statusClass = "status-absent"; break;
                                    case "late": statusClass = "status-late"; break;
                                }
                        %>
                        <tr>
                            <td><%= sdf.format(a.getDate()) %></td>
                            <td><%= a.getStudentId() %></td> <!-- Ideally show subject name -->
                            <td class="<%= statusClass %>">
                                <i class="fas 
                                    <% if(a.getStatus().equalsIgnoreCase("present")) { %>
                                        fa-check-circle
                                    <% } else if(a.getStatus().equalsIgnoreCase("absent")) { %>
                                        fa-times-circle
                                    <% } else if(a.getStatus().equalsIgnoreCase("late")) { %>
                                        fa-clock
                                    <% } %>
                                "></i> 
                                <%= a.getStatus() %>
                            </td>
                            
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                
                <div class="pagination">
                    <a href="#"><i class="fas fa-angle-double-left"></i></a>
                    <a href="#"><i class="fas fa-angle-left"></i></a>
                    <span class="active">1</span>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#"><i class="fas fa-angle-right"></i></a>
                    <a href="#"><i class="fas fa-angle-double-right"></i></a>
                </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<script>
    // Simple client-side filtering (would be more robust in a real application)
    document.addEventListener('DOMContentLoaded', function() {
        const filters = {
            subject: document.getElementById('subject-filter'),
            month: document.getElementById('month-filter'),
            status: document.getElementById('status-filter')
        };
        
        // Add event listeners for filtering
        Object.values(filters).forEach(filter => {
            filter.addEventListener('change', function() {
                // In a real app, this would make an AJAX call or submit a form
                console.log('Filter changed:', this.id, this.value);
            });
        });
    });
</script>
</body>
</html>