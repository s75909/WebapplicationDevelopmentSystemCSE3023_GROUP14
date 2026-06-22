<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String teacherRole = (String) session.getAttribute("role");

    if (!"teacher".equals(teacherRole)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=teacher_only");
        return;
    }

    String teacherName = (String) session.getAttribute("name");

    if (teacherName == null || teacherName.trim().equals("")) {
        teacherName = (String) session.getAttribute("user");
    }

    if (teacherName == null || teacherName.trim().equals("")) {
        teacherName = "Instructor";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Instructor Dashboard</title>

    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/global.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Quicksand', sans-serif;
            background: #f1f8e9;
        }

        .teacher-wrapper {
            max-width: 950px;
            margin: 45px auto;
            padding: 25px;
            background: white;
            border: 6px solid #43a047;
            border-radius: 35px;
            box-shadow: 10px 10px 0 #2e7d32;
        }

        .teacher-header {
            background: #81d4fa;
            border: 4px solid #0288d1;
            border-radius: 28px;
            padding: 30px;
            display: flex;
            align-items: center;
            gap: 25px;
            margin-bottom: 35px;
        }

        .teacher-icon {
            font-size: 55px;
        }

        .teacher-header h1 {
            margin: 0;
            color: #1b5e20;
            font-size: 34px;
        }

        .teacher-header p {
            margin: 8px 0 0 0;
            color: #444;
            font-size: 18px;
        }

        .role-badge {
            display: inline-block;
            margin-top: 10px;
            background: #1565c0;
            color: white;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 22px;
        }

        .dashboard-card {
            text-decoration: none;
            color: inherit;
            background: white;
            border: 4px dashed #4caf50;
            border-radius: 25px;
            padding: 35px 20px;
            text-align: center;
            transition: 0.2s;
            min-height: 150px;
        }

        .dashboard-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 0 #2e7d32;
            background: #f9fff4;
        }

        .dashboard-card .icon {
            font-size: 45px;
            margin-bottom: 12px;
        }

        .dashboard-card h3 {
            margin: 0 0 8px 0;
            color: #1b5e20;
            font-size: 21px;
        }

        .dashboard-card p {
            margin: 0;
            color: #666;
            font-size: 15px;
        }

        .blue-card {
            border-color: #1e88e5;
        }

        .blue-card:hover {
            box-shadow: 0 8px 0 #0d47a1;
        }

        .orange-card {
            border-color: #ff7043;
        }

        .orange-card:hover {
            box-shadow: 0 8px 0 #bf360c;
        }

        .grey-card {
            border-color: #90a4ae;
        }

        .grey-card:hover {
            box-shadow: 0 8px 0 #455a64;
        }

        .note-box {
            margin-top: 35px;
            background: #e8f5e9;
            border-left: 8px solid #4caf50;
            padding: 20px 25px;
            border-radius: 15px;
            color: #333;
        }

        .note-box h3 {
            margin: 0 0 8px 0;
            color: #1b5e20;
        }

        .note-box p {
            margin: 0;
            line-height: 1.6;
        }

        @media screen and (max-width: 800px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .teacher-wrapper {
                margin: 25px 15px;
            }

            .teacher-header {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>

<body>

<jsp:include page="/header.jsp" />

<div class="main-content">

    <div class="teacher-wrapper">

        <div class="teacher-header">
            <div class="teacher-icon">🍎</div>

            <div>
                <h1>Instructor Dashboard</h1>
                <p>Welcome, <%= teacherName %>! Manage attendance and class activities.</p>
                <span class="role-badge">Instructor Only</span>
            </div>
        </div>

        <div class="dashboard-grid">

            <a class="dashboard-card" href="<%= request.getContextPath() %>/markAttendance.jsp">
                <div class="icon">✅</div>
                <h3>Mark Attendance</h3>
                <p>Record daily student attendance by class.</p>
            </a>

            <a class="dashboard-card blue-card" href="<%= request.getContextPath() %>/AttendanceReport">
                <div class="icon">📋</div>
                <h3>Attendance Report</h3>
                <p>View student attendance records and daily reports.</p>
            </a>

            <a class="dashboard-card orange-card" href="<%= request.getContextPath() %>/ClassServlet">
                <div class="icon">📚</div>
                <h3>Class Setup</h3>
                <p>View class information and assigned students.</p>
            </a>

            <a class="dashboard-card grey-card" href="<%= request.getContextPath() %>/LogoutServlet">
                <div class="icon">🚪</div>
                <h3>Logout</h3>
                <p>End instructor session and return to login page.</p>
            </a>

        </div>

        <div class="note-box">
            <h3>Instructor Access</h3>
            <p>
                Instructors can access attendance-related functions only. 
                Payment management, parent registration, and admin financial dashboard are restricted to the manager role.
            </p>
        </div>

    </div>

</div>

<jsp:include page="/footer.jsp" />

</body>
</html>