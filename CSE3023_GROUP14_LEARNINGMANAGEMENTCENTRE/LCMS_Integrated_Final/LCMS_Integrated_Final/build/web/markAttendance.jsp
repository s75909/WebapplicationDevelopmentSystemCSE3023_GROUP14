<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.lcms.dao.AttendanceMarkDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("role");

    if (!"teacher".equals(role) && !"manager".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=login_required");
        return;
    }

    AttendanceMarkDAO dao = new AttendanceMarkDAO();

    List<Map<String, String>> classList = dao.getAllClasses();

    int selectedClassId = 0;

    if (request.getParameter("classId") != null && !request.getParameter("classId").trim().equals("")) {
        selectedClassId = Integer.parseInt(request.getParameter("classId"));
    } else if (!classList.isEmpty()) {
        selectedClassId = Integer.parseInt(classList.get(0).get("class_id"));
    }

    List<Map<String, String>> studentList = dao.getStudentsByClass(selectedClassId);

    String currentTime = LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm"));
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mark Attendance | TASKA PERMATA LCMS</title>

    <link rel="stylesheet" href="<%= request.getContextPath()%>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Quicksand', sans-serif;
            background: #f1f8e9;
        }

        .attendance-wrapper {
            max-width: 1050px;
            margin: 45px auto;
            padding: 35px;
            background: white;
            border: 6px solid #43a047;
            border-radius: 35px;
            box-shadow: 10px 10px 0 #2e7d32;
        }

        .attendance-header {
            background: #81d4fa;
            border: 4px solid #0288d1;
            border-radius: 28px;
            padding: 28px;
            text-align: center;
            margin-bottom: 30px;
        }

        .attendance-header h1 {
            margin: 0;
            color: #1b5e20;
            font-size: 38px;
        }

        .attendance-header p {
            margin: 10px 0 0;
            color: #333;
            font-size: 18px;
        }

        .success-box {
            background: #e8f5e9;
            color: #1b5e20;
            border: 3px dashed #4caf50;
            padding: 15px 20px;
            border-radius: 18px;
            margin-bottom: 25px;
            font-weight: bold;
            text-align: center;
        }

        .top-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 28px;
            flex-wrap: wrap;
        }

        .class-filter {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .class-filter label {
            font-weight: bold;
            color: #1b5e20;
            font-size: 20px;
        }

        .class-filter select {
            padding: 13px 18px;
            border: 3px solid #4caf50;
            border-radius: 16px;
            font-family: 'Quicksand', sans-serif;
            font-size: 17px;
            min-width: 280px;
            background: white;
        }

        .date-pill {
            background: #fff8e1;
            border: 3px solid #fbc02d;
            color: #795548;
            padding: 12px 18px;
            border-radius: 18px;
            font-weight: bold;
        }

        .table-card {
            border-radius: 24px;
            overflow: hidden;
            border: 3px solid #2e7d32;
            background: white;
            margin-top: 15px;
        }

        .attendance-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .attendance-table th {
            background: #2e7d32;
            color: white;
            padding: 18px 16px;
            text-align: left;
            font-size: 17px;
        }

        .attendance-table td {
            padding: 18px 16px;
            border-bottom: 1px solid #dcedc8;
            font-size: 16px;
            vertical-align: middle;
        }

        .attendance-table tr:nth-child(even) {
            background: #f9fff4;
        }

        .col-no {
            width: 70px;
            text-align: center;
        }

        .col-present {
            width: 230px;
        }

        .col-time {
            width: 230px;
        }

        .student-name {
            font-weight: bold;
            color: #333;
            font-size: 18px;
        }

        .present-area {
            display: flex;
            align-items: center;
            gap: 12px;
            white-space: nowrap;
        }

        .present-check {
            width: 24px;
            height: 24px;
            accent-color: #2e7d32;
            cursor: pointer;
        }

        .status-badge {
            display: inline-block;
            padding: 7px 14px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            background: #e8f5e9;
            color: #1b5e20;
            border: 2px solid #4caf50;
        }

        .status-badge.absent {
            background: #ffebee;
            color: #b71c1c;
            border-color: #ef5350;
        }

        .time-input {
            padding: 12px 14px;
            border: 2px solid #ddd;
            border-radius: 14px;
            font-family: 'Quicksand', sans-serif;
            font-size: 16px;
            width: 150px;
            background: white;
        }

        .time-input:disabled {
            background: #eeeeee;
            color: #999;
        }

        .button-row {
            display: flex;
            gap: 18px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .save-btn {
            flex: 1;
            border: none;
            background: #4caf50;
            color: white;
            padding: 18px;
            border-radius: 18px;
            font-family: 'Quicksand', sans-serif;
            font-weight: bold;
            font-size: 18px;
            cursor: pointer;
            box-shadow: 0 6px 0 #2e7d32;
        }

        .report-btn {
            text-decoration: none;
            background: #1e88e5;
            color: white;
            padding: 18px 28px;
            border-radius: 18px;
            font-weight: bold;
            font-size: 18px;
            box-shadow: 0 6px 0 #0d47a1;
            text-align: center;
        }

        .empty-box {
            text-align: center;
            padding: 35px;
            border: 3px dashed #ff7043;
            border-radius: 22px;
            color: #bf360c;
            font-weight: bold;
            background: #fff3e0;
            font-size: 18px;
        }
    </style>

    <script>
        function changeClass() {
            const classId = document.getElementById("classId").value;
            window.location.href = "<%= request.getContextPath()%>/markAttendance.jsp?classId=" + classId;
        }

        function toggleTime(studentId) {
            const checkbox = document.getElementById("present_" + studentId);
            const timeInput = document.getElementById("timeIn_" + studentId);
            const badge = document.getElementById("badge_" + studentId);

            if (checkbox.checked) {
                timeInput.disabled = false;

                if (timeInput.value === "") {
                    timeInput.value = "<%= currentTime%>";
                }

                badge.textContent = "Present";
                badge.className = "status-badge";
            } else {
                timeInput.disabled = true;
                timeInput.value = "";
                badge.textContent = "Absent";
                badge.className = "status-badge absent";
            }
        }
    </script>
</head>

<body>

<jsp:include page="/header.jsp" />

<div class="main-content">
    <div class="attendance-wrapper">

        <div class="attendance-header">
            <h1>✅ Mark Daily Attendance</h1>
            <p>Tick students who are present today</p>
        </div>

        <% if ("1".equals(request.getParameter("success"))) { %>
            <div class="success-box">
                ✅ Attendance saved successfully!
            </div>
        <% } %>

        <% if (classList.isEmpty()) { %>

            <div class="empty-box">
                No class found. Please create class first in Class Setup.
            </div>

        <% } else { %>

            <div class="top-row">
                <div class="class-filter">
                    <label>Select Class:</label>

                    <select name="classId" id="classId" onchange="changeClass()">
                        <% for (Map<String, String> c : classList) {
                            int cid = Integer.parseInt(c.get("class_id"));
                        %>
                            <option value="<%= cid %>" <%= cid == selectedClassId ? "selected" : "" %>>
                                <%= c.get("class_name") %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="date-pill">
                    📅 Today
                </div>
            </div>

            <% if (studentList.isEmpty()) { %>

                <div class="empty-box">
                    No student found in this class. Please assign students to this class first.
                </div>

            <% } else { %>

                <form action="<%= request.getContextPath()%>/MarkAttendanceServlet" method="post">

                    <input type="hidden" name="classId" value="<%= selectedClassId %>">

                    <div class="table-card">
                        <table class="attendance-table">
                            <thead>
                                <tr>
                                    <th class="col-no">No.</th>
                                    <th>Student Name</th>
                                    <th class="col-present">Attendance</th>
                                    <th class="col-time">Arrival Time</th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    int no = 1;
                                    for (Map<String, String> s : studentList) {
                                        int studentId = Integer.parseInt(s.get("id"));
                                %>

                                <tr>
                                    <td class="col-no"><%= no++ %></td>

                                    <td class="student-name">
                                        <%= s.get("student_name") %>
                                        <input type="hidden" name="studentIds" value="<%= studentId %>">
                                    </td>

                                    <td>
                                        <div class="present-area">
                                            <input type="checkbox"
                                                   class="present-check"
                                                   id="present_<%= studentId %>"
                                                   name="present_<%= studentId %>"
                                                   value="Present"
                                                   checked
                                                   onchange="toggleTime(<%= studentId %>)">

                                            <span class="status-badge" id="badge_<%= studentId %>">
                                                Present
                                            </span>
                                        </div>
                                    </td>

                                    <td>
                                        <input type="time"
                                               class="time-input"
                                               id="timeIn_<%= studentId %>"
                                               name="timeIn_<%= studentId %>"
                                               value="<%= currentTime %>">
                                    </td>
                                </tr>

                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <div class="button-row">
                        <button type="submit" class="save-btn">
                            💾 Save Attendance to Database
                        </button>

                        <a class="report-btn" href="<%= request.getContextPath()%>/AttendanceReport">
                            📋 View Report
                        </a>
                    </div>

                </form>

            <% } %>

        <% } %>

    </div>
</div>

<jsp:include page="/footer.jsp" />

</body>
</html>