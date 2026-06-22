<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String flashOk = (String) session.getAttribute("flashSuccess");
    if (flashOk != null) {
        session.removeAttribute("flashSuccess");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Login – Dino LCMS</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/global.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Quicksand', sans-serif;
            background: #f1f8e9;
        }

        .teacher-login-wrapper {
            max-width: 720px;
            margin: 45px auto;
            padding: 30px;
            background: white;
            border: 6px solid #1565c0;
            border-radius: 35px;
            box-shadow: 10px 10px 0 #0d47a1;
        }

        .teacher-header {
            background: linear-gradient(135deg, #1565c0 0%, #0288d1 100%);
            border: 4px solid #0d47a1;
            border-radius: 28px;
            padding: 28px;
            display: flex;
            align-items: center;
            gap: 22px;
            margin-bottom: 25px;
        }

        .teacher-header .dino-mascot {
            font-size: 55px;
        }

        .teacher-header h1 {
            margin: 0;
            color: white;
            font-size: 32px;
        }

        .teacher-header p {
            margin: 8px 0 0;
            color: #e3f2fd;
            font-size: 17px;
        }

        .teacher-card {
            border: 4px dashed #1565c0;
            border-radius: 25px;
            padding: 25px;
            background: #fdfdfd;
            margin-bottom: 22px;
        }

        .teacher-card legend {
            background: #e3f2fd;
            color: #0d47a1;
            border: 3px solid #1565c0;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 700;
        }

        .input-field {
            margin-bottom: 18px;
        }

        .input-field label {
            display: block;
            font-weight: 700;
            margin-bottom: 7px;
            color: #333;
        }

        .input-field input {
            width: 100%;
            padding: 14px 16px;
            border: 3px solid #e0e0e0;
            border-radius: 16px;
            box-sizing: border-box;
            font-family: 'Quicksand', sans-serif;
            font-size: 15px;
            transition: 0.2s;
        }

        .input-field input:focus {
            border-color: #1565c0;
            outline: none;
            box-shadow: 0 0 0 3px #e3f2fd;
        }

        .forgot-link {
            text-align: right;
            font-size: 13px;
            margin-top: -6px;
        }

        .forgot-link a {
            color: #1565c0;
            text-decoration: none;
            font-weight: 700;
        }

        .forgot-link a:hover {
            text-decoration: underline;
        }

        .success-banner {
            background: #e8f5e9;
            border: 3px solid #4caf50;
            border-radius: 16px;
            padding: 14px 18px;
            margin-bottom: 18px;
            color: #1b5e20;
            font-weight: 700;
        }

        .error-banner {
            background: #fff3e0;
            border: 3px solid #ff7043;
            border-radius: 16px;
            padding: 14px 18px;
            margin-bottom: 18px;
            color: #bf360c;
            font-weight: 700;
        }

        .dino-actions {
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }

        .btn-teacher {
            background: #1565c0;
            color: white;
            flex: 2;
            padding: 17px;
            border-radius: 24px;
            border: none;
            font-weight: 700;
            font-size: 18px;
            cursor: pointer;
            box-shadow: 0 6px 0 #0d47a1;
            font-family: 'Quicksand', sans-serif;
        }

        .btn-teacher:hover {
            background: #0d47a1;
        }

        .btn-stone {
            background: #90a4ae;
            color: white;
            flex: 1;
            padding: 17px;
            border-radius: 24px;
            border: none;
            font-weight: 700;
            font-size: 16px;
            cursor: pointer;
            box-shadow: 0 6px 0 #546e7a;
            font-family: 'Quicksand', sans-serif;
        }

        .btn-stone:hover {
            background: #78909c;
        }

        button:active {
            transform: translateY(4px);
            box-shadow: none;
        }

        .footer-links {
            text-align: center;
            margin-top: 24px;
            padding: 16px;
            background: #e3f2fd;
            border-radius: 18px;
            color: #0d47a1;
            font-size: 14px;
            font-weight: 700;
        }

        @media screen and (max-width: 760px) {
            .teacher-login-wrapper {
                margin: 25px 15px;
                padding: 22px;
            }

            .teacher-header {
                flex-direction: column;
                text-align: center;
            }

            .teacher-header h1 {
                font-size: 28px;
            }

            .dino-actions {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<jsp:include page="/header.jsp" />

<div class="main-content">

    <div class="teacher-login-wrapper">

        <header class="teacher-header">
            <div class="dino-mascot">🍎</div>

            <div class="header-text">
                <h1>Teacher Login</h1>
                <p>Welcome back, educator! 📚</p>
            </div>
        </header>

        <% if (flashOk != null) { %>
            <div class="success-banner">
                ✅ <%= flashOk %>
            </div>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
            <div class="success-banner">
                ✅ ${success}
            </div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-banner">
                ❌ ${error}
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/TeacherServlet" method="post">
            <input type="hidden" name="action" value="login">

            <fieldset class="teacher-card">
                <legend>🔑 Teacher Credentials</legend>

                <div class="input-field">
                    <label for="user">Username</label>
                    <input type="text"
                           id="user"
                           name="user"
                           placeholder="Enter your username"
                           required>
                </div>

                <div class="input-field">
                    <label for="pass">Password</label>
                    <input type="password"
                           id="pass"
                           name="pass"
                           placeholder="Enter your password"
                           required>
                </div>

                <div class="forgot-link">
                    <a href="${pageContext.request.contextPath}/ForgotPasswordServlet?role=teacher">
                        Forgot password?
                    </a>
                </div>
            </fieldset>

            <div class="dino-actions">
                <button type="submit" class="btn-teacher">
                    Login 🍎
                </button>

                <button type="button"
                        class="btn-stone"
                        onclick="location.href='${pageContext.request.contextPath}/login.jsp'">
                    Back
                </button>
            </div>
        </form>

        <div class="footer-links">
            Don’t have an account? Contact your Manager to register.
        </div>

    </div>

</div>

<jsp:include page="/footer.jsp" />

</body>
</html>