<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary: #4285f4;    /* Professional blue */
            --bg-dark: #181a1b;
            --card-bg: #23272b;
            --text-light: #f4f4f4;
            --accent: #4285f4;
            --danger: #ff4d4d;
            --border-radius: 16px;
            --shadow: 0 6px 32px 0 rgba(0,0,0,0.16);
        }
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            background: var(--bg-dark);
            color: var(--text-light);
            font-family: 'Segoe UI', 'Roboto', Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .error-card {
            background: var(--card-bg);
            padding: 2rem 2.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            text-align: center;
            max-width: 380px;
        }
        .error-card h2 {
            color: var(--danger);
            margin-bottom: 1.5rem;
            font-weight: 600;
            font-size: 1.3rem;
        }
        .error-card a {
            display: inline-block;
            background: var(--primary);
            color: var(--text-light);
            text-decoration: none;
            padding: 0.7rem 1.6rem;
            border-radius: 24px;
            font-weight: 500;
            font-size: 1rem;
            transition: background 0.2s, box-shadow 0.2s;
            box-shadow: 0 2px 8px rgba(66,133,244,0.14);
            margin-top: 0.5rem;
        }
        .error-card a:hover, .error-card a:focus {
            background: #2b6bcf;
            box-shadow: 0 4px 16px rgba(66,133,244,0.20);
        }
        @media (max-width: 500px) {
            .error-card {
                padding: 1.2rem 1rem;
                max-width: 95vw;
            }
            .error-card h2 {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="error-card">
        <h2>Error: Role not recognized or access denied!</h2>
        <a href="login.jsp">Return to Login</a>
    </div>
</body>
</html>
