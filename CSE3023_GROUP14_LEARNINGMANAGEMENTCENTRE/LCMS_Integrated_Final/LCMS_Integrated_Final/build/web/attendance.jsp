<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.lcms.model.Attendance"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("role");

    if (!"teacher".equals(role) && !"manager".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=login_required");
        return;
    }

    List<Map<String, String>> classList =
            (List<Map<String, String>>) request.getAttribute("classList");

    List<Attendance> attendanceList =
            (List<Attendance>) request.getAttribute("attendanceList");

    Integer selectedClassIdObj =
            (Integer) request.getAttribute("selectedClassId");

    int selectedClassId = selectedClassIdObj == null ? 0 : selectedClassIdObj;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance Report | TASKA PERMATA LCMS</title>

    <link rel="stylesheet" href="<%= request.getContextPath()%>/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/global.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Quicksand', sans-serif;
            background: #f1f8e9;
        }

        .report-wrapper {
            max-width: 1100px;
            margin: 45px auto;
            padding: 35px;
            background: white;
            border: 6px solid #43a047;
            border-radius: 35px;
            box-shadow: 10px 10px 0 #a5d6a7;
        }

        .report-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 25px;
            margin-bottom: 25px;
        }

        .title-box {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .title-icon {
            font-size: 45px;
        }

        .title-text h1 {
            margin: 0;
            color: #1b5e20;
            font-size: 38px;
        }

        .title-text p {
            margin: 8px 0 0;
            color: #333;
            font-size: 18px;
        }

        .print-btn {
            border: none;
            background: #2e7d32;
            color: white;
            padding: 14px 28px;
            border-radius: 18px;
            font-family: 'Quicksand', sans-serif;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 5px 0 #1b5e20;
        }

        .divider {
            border-top: 3px dashed #4caf50;
            margin: 25px 0;
        }

        .filter-row {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .filter-row label {
            font-weight: bold;
            color: #1b5e20;
            font-size: 18px;
        }

        .filter-row select {
            padding: 12px 16px;
            border: 3px solid #4caf50;
            border-radius: 14px;
            font-family: 'Quicksand', sans-serif;
            font-size: 16px;
            min-width: 230px;
            background: white;
        }

        .summary-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-bottom: 25px;
        }

        .summary-card {
            background: #f9fff4;
            border: 3px dashed #4caf50;
            border-radius: 20px;
            padding: 18px;
            text-align: center;
        }

        .summary-card h3 {
            margin: 0;
            color: #1b5e20;
            font-size: 24px;
        }

        .summary-card p {
            margin: 5px 0 0;
            color: #555;
            font-weight: bold;
        }

        .table-card {
            border: 3px solid #2e7d32;
            border-radius: 22px;
            overflow: hidden;
        }

        .report-table {
            width: 100%;
            border-collapse: collapse;
        }

        .report-table th {
            background: #2e7d32;
            color: white;
            padding: 17px 15px;
            text-align: left;
            font-size: 16px;
        }

        .report-table td {
            padding: 17px 15px;
            border-bottom: 1px solid #dcedc8;
            font-size: 16px;
        }

        .report-table tr:nth-child(even) {
            background: #f9fff4;
        }

        .student-name {
            font-weight: bold;
            color: #333;
        }

        .status {
            display: inline-block;
            padding: 7px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 14px;
        }

        .present {
            background: #e8f5e9;
            color: #1b5e20;
            border: 2px solid #4caf50;
        }

        .absent {
            background: #ffebee;
            color: #b71c1c;
            border: 2px solid #ef5350;
        }

        .empty-box {
            text-align: center;
            padding: 45px;
            color: #666;
            font-size: 20px;
        }

        .start-btn {
            display: inline-block;
            margin-top: 15px;
            background: #ff7043;
            color: white;
            padding: 14px 28px;
            border-radius: 16px;
            text-decoration: none;
            font-weight: bold;
            box-shadow: 0 5px 0 #bf360c;
        }

        @media print {
            .navbar,
            .footer,
            footer,
            .print-btn,
            .filter-row,
            .start-btn {
                display: none !important;
            }

            body {
                background: white !important;
            }

            .report-wrapper {
                margin: 0;
                max-width: 100%;
                border: none;
                box-shadow: none;
                padding: 20px;
            }
        }
    </style>

    <script>
        function filterClass() {
            const classId = document.getElementById("classId").value;

            if (classId === "0") {
                window.location.href = "<%= request.getContextPath()%>/AttendanceReport";
            } else {
                window.location.href = "<%= request.getContextPath()%>/AttendanceReport?classId=" + classId;
            }
        }
    </script>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="main-content">

    <div class="report-wrapper">

        <div class="report-top">
            <div class="title-box">
                <div class="title-icon">📝</div>

                <div class="title-text">
                    <h1>Daily Attendance Report</h1>
                    <p>Taska Permata Keluarga - Today</p>
                </div>
            </div>

            <button class="print-btn" onclick="window.print()">
                Print Report 🖨️
            </button>
        </div>

        <div class="divider"></div>

        <div class="filter-row">
            <label>Select Class:</label>

            <select id="classId" onchange="filterClass()">
                <option value="0" <%= selectedClassId == 0 ? "selected" : ""%>>
                    All Classes
                </option>

                <% if (classList != null) {
                    for (Map<String, String> c : classList) {
                        int cid = Integer.parseInt(c.get("class_id"));
                %>
                    <option value="<%= cid%>" <%= selectedClassId == cid ? "selected" : ""%>>
                        <%= c.get("class_name")%>
                    </option>
                <%  }
                } %>
            </select>
        </div>

        <%
            int totalPresent = 0;
            int totalAbsent = 0;
            int totalRecords = 0;

            if (attendanceList != null) {
                totalRecords = attendanceList.size();

                for (Attendance a : attendanceList) {
                    if ("Present".equalsIgnoreCase(a.getStatus())) {
                        totalPresent++;
                    } else if ("Absent".equalsIgnoreCase(a.getStatus())) {
                        totalAbsent++;
                    }
                }
            }
        %>

        <div class="summary-row">
            <div class="summary-card">
                <h3><%= totalRecords%></h3>
                <p>Total Records</p>
            </div>

            <div class="summary-card">
                <h3><%= totalPresent%></h3>
                <p>Present</p>
            </div>

            <div class="summary-card">
                <h3><%= totalAbsent%></h3>
                <p>Absent</p>
            </div>
        </div>

        <div class="table-card">
            <table class="report-table">
                <thead>
                    <tr>
                        <th style="width: 70px;">No.</th>
                        <th>Child Name</th>
                        <th>Class Name</th>
                        <th>Attendance Status</th>
                        <th>Time In</th>
                    </tr>
                </thead>

                <tbody>
                    <% if (attendanceList == null || attendanceList.isEmpty()) { %>

                        <tr>
                            <td colspan="5">
                                <div class="empty-box">
                                    No attendance records found for today.
                                    <br>
                                    <a class="start-btn" href="<%= request.getContextPath()%>/markAttendance.jsp">
                                        📝 Start Marking Attendance
                                    </a>
                                </div>
                            </td>
                        </tr>

                    <% } else {
                        int no = 1;

                        for (Attendance att : attendanceList) {
                    %>

                        <tr>
                            <td><%= no++%></td>

                            <td class="student-name">
                                <%= att.getStudentName()%>
                            </td>

                            <td>
                                <%= att.getClassName()%>
                            </td>

                            <td>
                                <% if ("Present".equalsIgnoreCase(att.getStatus())) { %>
                                    <span class="status present">Present</span>
                                <% } else { %>
                                    <span class="status absent">Absent</span>
                                <% } %>
                            </td>

                            <td>
                                <%= att.getTimeIn()%>
                            </td>
                        </tr>

                    <%  }
                    } %>
                </tbody>
            </table>
        </div>

    </div>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>