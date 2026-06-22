<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<%
    List<String[]> students = (List<String[]>) request.getAttribute("students");
    int studentCount = (students != null) ? students.size() : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">

    <title>Class Setup | TASKA PERMATA LCMS</title>

    <link rel="stylesheet" href="<%= request.getContextPath()%>/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/global.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Quicksand', sans-serif;
            background: #f1f8e9;
        }

        .class-wrapper {
            max-width: 1050px;
            margin: 45px auto;
            padding: 35px;
            background: white;
            border: 6px solid #43a047;
            border-radius: 35px;
            box-shadow: 10px 10px 0 #2e7d32;
        }

        .class-header {
            background: #81d4fa;
            border: 4px solid #0288d1;
            border-radius: 28px;
            padding: 28px;
            text-align: center;
            margin-bottom: 30px;
        }

        .class-header h1 {
            margin: 0;
            color: #1b5e20;
            font-size: 38px;
        }

        .class-header p {
            margin: 10px 0 0;
            color: #333;
            font-size: 18px;
        }

        .error-box {
            background: #fff3e0;
            color: #bf360c;
            border: 3px dashed #ff7043;
            padding: 15px 20px;
            border-radius: 18px;
            margin-bottom: 25px;
            font-weight: bold;
            text-align: center;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 25px;
        }

        .form-card {
            border: 4px dashed #4caf50;
            border-radius: 25px;
            padding: 25px;
            background: #fdfdfd;
        }

        .form-card.orange {
            border-color: #ff7043;
        }

        .form-card.full {
            grid-column: 1 / -1;
        }

        .card-title {
            background: #fff9c4;
            display: inline-block;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 700;
            color: #1b5e20;
            border: 3px solid #4caf50;
            margin-bottom: 20px;
        }

        .form-card.orange .card-title {
            border-color: #ff7043;
        }

        .input-field {
            margin-bottom: 18px;
        }

        .input-field label,
        .section-label {
            display: block;
            font-weight: bold;
            color: #1b5e20;
            font-size: 17px;
            margin-bottom: 8px;
        }

        .input-field input {
            width: 100%;
            padding: 13px 18px;
            border: 3px solid #4caf50;
            border-radius: 16px;
            font-family: 'Quicksand', sans-serif;
            font-size: 16px;
            box-sizing: border-box;
            background: white;
        }

        .input-field input:focus {
            outline: none;
            border-color: #2e7d32;
            box-shadow: 0 0 0 4px #e8f5e9;
        }

        .days-row {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 10px;
        }

        .day-option {
            background: #f9fff4;
            border: 3px solid #4caf50;
            color: #1b5e20;
            padding: 12px 18px;
            border-radius: 18px;
            font-weight: bold;
            cursor: pointer;
        }

        .day-option input {
            margin-right: 8px;
            accent-color: #2e7d32;
            cursor: pointer;
        }

        .day-option:hover {
            background: #e8f5e9;
        }

        .student-top-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 15px;
        }

        .selected-pill {
            background: #fff8e1;
            border: 3px solid #fbc02d;
            color: #795548;
            padding: 10px 16px;
            border-radius: 18px;
            font-weight: bold;
        }

        .select-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .small-btn {
            border: none;
            padding: 12px 18px;
            border-radius: 16px;
            font-family: 'Quicksand', sans-serif;
            font-weight: bold;
            font-size: 15px;
            cursor: pointer;
        }

        .select-btn {
            background: #c8e6c9;
            color: #1b5e20;
            box-shadow: 0 4px 0 #2e7d32;
        }

        .clear-btn {
            background: #eeeeee;
            color: #555;
            box-shadow: 0 4px 0 #9e9e9e;
        }

        .student-list {
            border-radius: 24px;
            overflow: hidden;
            border: 3px solid #ff7043;
            background: white;
            max-height: 300px;
            overflow-y: auto;
        }

        .student-item {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 16px 18px;
            border-bottom: 1px solid #ffe0b2;
            font-size: 17px;
        }

        .student-item:nth-child(even) {
            background: #fffaf4;
        }

        .student-item:hover {
            background: #fff3e0;
        }

        .student-item:last-child {
            border-bottom: none;
        }

        .student-item input[type="checkbox"] {
            width: 24px;
            height: 24px;
            accent-color: #ff7043;
            cursor: pointer;
        }

        .student-item label {
            font-weight: bold;
            color: #333;
            cursor: pointer;
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

        .cancel-btn {
            text-decoration: none;
            border: none;
            background: #90a4ae;
            color: white;
            padding: 18px 28px;
            border-radius: 18px;
            font-family: 'Quicksand', sans-serif;
            font-weight: bold;
            font-size: 18px;
            cursor: pointer;
            box-shadow: 0 6px 0 #546e7a;
            text-align: center;
        }

        .save-btn:active,
        .cancel-btn:active,
        .small-btn:active {
            transform: translateY(4px);
            box-shadow: none;
        }

        @media screen and (max-width: 768px) {
            .class-wrapper {
                margin: 25px 15px;
                padding: 22px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .class-header h1 {
                font-size: 30px;
            }

            .button-row {
                flex-direction: column;
            }

            .save-btn,
            .cancel-btn {
                width: 100%;
            }
        }
    </style>

    <script>
        function updateBadge() {
            const checked = document.querySelectorAll('input[name="studentIds"]:checked').length;
            const badge = document.getElementById("selectedBadge");

            if (badge) {
                badge.textContent = checked + " selected";
            }
        }

        function selectAllStudents(check) {
            document.querySelectorAll('input[name="studentIds"]').forEach(function (cb) {
                cb.checked = check;
            });

            updateBadge();
        }
    </script>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="main-content">

    <div class="class-wrapper">

        <div class="class-header">
            <h1>📚 Class Setup</h1>
            <p>Create a new class and assign students</p>
        </div>

        <% if (request.getAttribute("dbError") != null) { %>
            <div class="error-box">
                ❌ Database error: <%= request.getAttribute("dbError") %>
            </div>
        <% } %>

        <form action="<%= request.getContextPath()%>/ClassServlet" method="post">

            <div class="form-grid">

                <div class="form-card">
                    <div class="card-title">🦖 Course Details</div>

                    <div class="input-field">
                        <label>Class Name *</label>
                        <input type="text"
                               name="className"
                               placeholder="e.g., Little Explorers"
                               required>
                    </div>

                    <div class="input-field">
                        <label>Class Code *</label>
                        <input type="text"
                               name="classCode"
                               placeholder="e.g., K4-A"
                               required>
                    </div>
                </div>

                <div class="form-card orange">
                    <div class="card-title">🌴 Schedule & Size</div>

                    <div class="input-field">
                        <label>Max Children *</label>
                        <input type="number"
                               name="maxKids"
                               placeholder="20"
                               min="1"
                               required>
                    </div>

                    <div class="input-field">
                        <label>Lead Teacher *</label>
                        <input type="text"
                               name="teacher"
                               placeholder="Teacher Name"
                               required>
                    </div>
                </div>

                <div class="form-card full">
                    <div class="card-title">📅 Class Days</div>

                    <label class="section-label">Select Class Days *</label>

                    <div class="days-row">
                        <label class="day-option">
                            <input type="checkbox" name="classDays" value="Mon"> Mon
                        </label>

                        <label class="day-option">
                            <input type="checkbox" name="classDays" value="Tue"> Tue
                        </label>

                        <label class="day-option">
                            <input type="checkbox" name="classDays" value="Wed"> Wed
                        </label>

                        <label class="day-option">
                            <input type="checkbox" name="classDays" value="Thu"> Thu
                        </label>

                        <label class="day-option">
                            <input type="checkbox" name="classDays" value="Fri"> Fri
                        </label>
                    </div>
                </div>

                <div class="form-card orange full">
                    <div class="student-top-row">
                        <div class="card-title">🦕 Assign Students</div>

                        <div class="selected-pill" id="selectedBadge">
                            0 selected
                        </div>
                    </div>

                    <% if (studentCount == 0) { %>

                        <div class="empty-box">
                            No students registered yet.
                        </div>

                    <% } else { %>

                        <div class="select-actions">
                            <button type="button"
                                    class="small-btn select-btn"
                                    onclick="selectAllStudents(true)">
                                Select All
                            </button>

                            <button type="button"
                                    class="small-btn clear-btn"
                                    onclick="selectAllStudents(false)">
                                Clear All
                            </button>
                        </div>

                        <br>

                        <div class="student-list">
                            <% for (String[] s : students) { %>

                                <div class="student-item">
                                    <input type="checkbox"
                                           name="studentIds"
                                           value="<%= s[0] %>"
                                           id="student_<%= s[0] %>"
                                           onchange="updateBadge()">

                                    <label for="student_<%= s[0] %>">
                                        🦕 <%= s[1] %> <%= s[2] %>
                                    </label>
                                </div>

                            <% } %>
                        </div>

                    <% } %>
                </div>

            </div>

            <div class="button-row">
                <button type="submit" class="save-btn">
                    💾 Save Class
                </button>

                <button type="button" class="cancel-btn" onclick="window.history.back()">
                    ✖ Cancel
                </button>
            </div>

        </form>

    </div>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>