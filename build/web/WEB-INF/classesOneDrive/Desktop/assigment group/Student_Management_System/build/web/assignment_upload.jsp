<%@ page import="model.Subject" %>
<%@ page import="java.util.List" %>
<%
    List<Subject> subjectList = (new dao.SubjectDAO()).getSubjectsByCourse(1);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Assignment - SMS</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background-color: var(--dark-panel);
            width: 90%;
            max-width: 800px;
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
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        label {
            color: var(--light-gray);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        input[type="text"],
        input[type="date"],
        select,
        textarea {
            padding: 12px 15px;
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            color: var(--light-text);
            font-size: 1rem;
            width: 100%;
        }
        
        textarea {
            min-height: 120px;
            resize: vertical;
        }
        
        input[type="file"] {
            padding: 10px;
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            color: var(--light-text);
            width: 100%;
        }
        
        .submit-btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
        }
        
        .submit-btn:hover {
            background-color: var(--primary-dark);
        }
        
        .back-link {
            display: inline-block;
            margin-top: 25px;
            color: var(--light-gray);
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.05);
            transition: all 0.3s;
            text-align: center;
            width: 100%;
        }
        
        .back-link:hover {
            color: var(--light-text);
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        .back-link i {
            margin-right: 8px;
        }
        
        @media(max-width: 768px) {
            .container {
                padding: 20px;
            }
            
            h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-file-upload"></i> Upload New Assignment</h2>
        
        <form method="post" action="${pageContext.request.contextPath}/assignment" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title"><i class="fas fa-heading"></i> Title:</label>
                <input type="text" id="title" name="title" required>
            </div>
            
            <div class="form-group">
                <label for="description"><i class="fas fa-align-left"></i> Description:</label>
                <textarea id="description" name="description" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="subject_id"><i class="fas fa-book"></i> Subject:</label>
                <select id="subject_id" name="subject_id">
                    <% for (Subject s : subjectList) { %>
                    <option value="<%= s.getSubjectId() %>"><%= s.getSubjectName() %></option>
                    <% } %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="due_date"><i class="far fa-calendar-alt"></i> Due Date:</label>
                <input type="date" id="due_date" name="due_date" required>
            </div>
            
            <div class="form-group">
                <label for="file"><i class="fas fa-file"></i> File:</label>
                <input type="file" id="file" name="file" required>
            </div>
            
            <button type="submit" class="submit-btn">
                <i class="fas fa-upload"></i> Upload Assignment
            </button>
        </form>
        
        <a href="dashboard_teacher.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</body>
</html>