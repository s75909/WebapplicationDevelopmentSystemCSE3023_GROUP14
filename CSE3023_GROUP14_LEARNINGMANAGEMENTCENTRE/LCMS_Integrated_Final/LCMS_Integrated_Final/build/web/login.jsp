<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dino Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">

    <style>
        .role-selector {
            display: flex;
            gap: 12px;
            margin-bottom: 20px;
        }

        .role-btn {
            flex: 1;
            padding: 14px;
            border-radius: 20px;
            border: 3px solid #e0e0e0;
            background: #f9f9f9;
            font-family: 'Quicksand', sans-serif;
            font-weight: 700;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.2s;
            color: #555;
        }

        .role-btn.active-parent {
            border-color: var(--leaf-green);
            background: #e8f5e9;
            color: var(--dark-jungle);
            box-shadow: 0 4px 0 var(--dark-jungle);
        }

        .role-btn.active-manager {
            border-color: var(--volcano);
            background: #fff3e0;
            color: #bf360c;
            box-shadow: 0 4px 0 #bf360c;
        }

        .role-btn.active-teacher {
            border-color: #1565c0;
            background: #e3f2fd;
            color: #0d47a1;
            box-shadow: 0 4px 0 #0d47a1;
        }
    </style>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="main-content">
    <div class="dino-container">

        <header class="dino-header">
            <div class="dino-mascot">🌋</div>
            <div class="header-text">
                <h1>Member Login</h1>
                <p>Welcome back, explorer!</p>
            </div>
        </header>

        <% if (request.getAttribute("error") != null) { %>
            <div class="dino-card volcano-orange" style="margin-bottom:15px;">
                <p style="color:#b71c1c; margin:0;">${error}</p>
            </div>
        <% } %>

        <div class="role-selector">
            <button type="button" class="role-btn active-parent" id="btnParent"
                    onclick="selectRole('parent')">
                🦖 Parent
            </button>
      

            <button type="button" class="role-btn" id="btnManager"
                    onclick="selectRole('manager')">
                🛡️ Manager
            </button>

            <button type="button" class="role-btn" id="btnTeacher"
                    onclick="selectRole('teacher')">
                🍎 Instructor
            </button>
        </div>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <input type="hidden" name="role" id="roleInput" value="parent">

            <fieldset class="dino-card jungle-green" id="credentialCard">
                <legend id="credLegend">🔑 Parent Credentials</legend>

                <div class="input-field">
                    <label>Username</label>
                    <input type="text" name="user" required>
                </div>

                <div class="input-field">
                    <label>Password</label>
                    <input type="password" name="pass" required>
                </div>
            </fieldset>
            
            <div style="text-align:right; margin-top:8px;">
    <a id="forgotLink"
       href="${pageContext.request.contextPath}/ForgotPasswordServlet?role=parent"
       style="font-size:14px; color:#1565c0; font-weight:700; text-decoration:none;">
        Forgot password?
    </a>
</div>

           <div class="dino-actions">
    <button type="submit" class="btn-leaf" id="loginBtn">
        Login as Parent 🐾
    </button>

    <button type="button"
            class="btn-stone"
            id="registerBtn"
            onclick="location.href='${pageContext.request.contextPath}/parentRegister.jsp'">
        Register (Parents Only)
    </button>
</div>
               


            </div>
        </form>

    </div>
</div>

<jsp:include page="footer.jsp" />

<script>
    function selectRole(role) {
        const btnParent  = document.getElementById('btnParent');
        const btnManager = document.getElementById('btnManager');
        const btnTeacher = document.getElementById('btnTeacher');

        const card = document.getElementById('credentialCard');
        const legend = document.getElementById('credLegend');
        const loginBtn = document.getElementById('loginBtn');
        const forgotLink = document.getElementById('forgotLink');
        const registerBtn = document.getElementById('registerBtn');

        document.getElementById('roleInput').value = role;

        btnParent.className = 'role-btn';
        btnManager.className = 'role-btn';
        btnTeacher.className = 'role-btn';

        if (role === 'parent') {
            btnParent.className = 'role-btn active-parent';
            card.className = 'dino-card jungle-green';
            legend.textContent = '🔑 Parent Credentials';
            loginBtn.textContent = 'Login as Parent 🐾';
            forgotLink.href = "<%= request.getContextPath() %>/ForgotPasswordServlet?role=parent";

            // Show register button only for parent
            registerBtn.style.display = 'block';

        } else if (role === 'manager') {
            btnManager.className = 'role-btn active-manager';
            card.className = 'dino-card volcano-orange';
            legend.textContent = '🛡️ Manager Credentials';
            loginBtn.textContent = 'Login as Manager 🛡️';
            forgotLink.href = "<%= request.getContextPath() %>/ForgotPasswordServlet?role=manager";

            // Hide register button for manager
            registerBtn.style.display = 'none';

        } else if (role === 'teacher') {
            btnTeacher.className = 'role-btn active-teacher';
            card.className = 'dino-card';
            legend.textContent = '🍎 Instructor Credentials';
            loginBtn.textContent = 'Login as Instructor 🍎';
            forgotLink.href = "<%= request.getContextPath() %>/ForgotPasswordServlet?role=teacher";

            // Hide register button for teacher
            registerBtn.style.display = 'none';
        }
    }
</script>

</body>
</html>