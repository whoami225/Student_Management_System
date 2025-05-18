<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - SMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4285f4; /* Professional blue */
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
        
        /* Blurred background div - covers entire viewport */
       .background-blur {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: #111312;  /* Solid grey background */
            filter: none;               /* Remove blur */
            z-index: 0;
}


        /* Body styles - no background or blur here */
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            color: var(--light-text);
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative; /* to keep stacking context */
            background: none;
        }

        /* Container for your form/content */
        .container {
            background: rgba(0, 0, 0, 0.7);
            width: 80%;
            max-width: 900px;
            display: flex;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            overflow: hidden;
            position: relative;  /* To stay above background */
            z-index: 1;  /* Above blurred background */
            margin: 5rem auto;
            color: white; /* Text color for readability */
        }

        .left-panel {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: rgba(26, 26, 26, 0.8);
        }
        
        .left-panel h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
            line-height: 1.2;
            color: var(--light-text);
        }
        
        .left-panel p {
            font-size: 1rem;
            line-height: 1.6;
            color: var(--light-gray);
            max-width: 400px;
        }
        
        .social-icons {
            margin-top: 30px;
        }
        
        .social-icons a {
            color: var(--light-gray);
            margin-right: 15px;
            font-size: 1.3rem;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        
        .social-icons a:hover {
            color: var(--primary);
        }
        
        .right-panel {
            flex: 1;
            background: var(--dark-panel);
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .right-panel h2 {
            color: var(--light-text);
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
        }
        
        form label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--light-gray);
        }
        
        form input[type="text"],
        form input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 20px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            color: var(--light-text);
            font-size: 1rem;
            transition: all 0.3s;
        }
        
        form input[type="text"]:focus,
        form input[type="password"]:focus {
            outline: none;
            border-color: var(--primary);
            background: rgba(66, 133, 244, 0.1);
        }
        
        .remember-me {
            margin-bottom: 25px;
            color: var(--light-gray);
            font-size: 0.9rem;
            display: flex;
            align-items: center;
        }
        
        form button {
            background-color: var(--primary);
            border: none;
            padding: 14px;
            width: 100%;
            color: white;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        
        form button:hover {
            background-color: var(--primary-dark);
        }
        
        .forgot-password {
            margin-top: 15px;
            text-align: center;
            font-size: 0.9rem;
            color: var(--light-gray);
        }
        
        .forgot-password a {
            color: var(--primary);
            text-decoration: none;
        }
        
        .forgot-password a:hover {
            text-decoration: underline;
        }
        
        .error {
            color: var(--error);
            margin-top: 10px;
            text-align: center;
            font-weight: 500;
        }
        
        .legal-text {
            font-size: 0.8rem; 
            color: var(--light-gray); 
            margin-top: 15px; 
            text-align: center;
        }
        
        .legal-text a {
            color: var(--primary);
            text-decoration: none;
        }
        
        .legal-text a:hover {
            text-decoration: underline;
        }
        
        @media(max-width: 768px) {
            .container {
                flex-direction: column;
                width: 90%;
            }
            
            .left-panel, .right-panel {
                padding: 30px 20px;
            }
            
            .left-panel h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
     <div class="background-blur"></div>
<div class="container">
    
    
    <div class="left-panel">
        <h1>Student Management System</h1>
        <p>Access your student management system with your credentials to manage courses, attendance, and more.</p>
        <div class="social-icons">
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
            <a href="#"><i class="fab fa-youtube"></i></a>
        </div>
    </div>
    <div class="right-panel">
        <h2>Sign in</h2>
        <form method="post" action="<%=request.getContextPath()%>/login">
            <label for="email">Email Address</label>
            <input type="text" id="email" name="email" required placeholder="Enter your email" />

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password" />

            <div class="remember-me">
                <input type="checkbox" id="remember" name="remember" />
                <label for="remember" style="margin: 0;">Remember Me</label>
            </div>

            <button type="submit">
                <i class="fas fa-sign-in-alt"></i> Sign in now
            </button>

            <div class="forgot-password">
                <a href="#">Lost your password?</a>
            </div>

            <div class="error">
                ${error}
            </div>

            <p class="legal-text">
                By clicking on "Sign in now" you agree to
                <a href="#">Terms of Service</a> |
                <a href="#">Privacy Policy</a>
            </p>
        </form>
    </div>
</div>
</body>
</html>