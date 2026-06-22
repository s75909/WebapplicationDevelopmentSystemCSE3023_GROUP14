<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dino-Class Management</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;700&display=swap" rel="stylesheet">

    <style>
        .class-setup-main {
            width: 100%;
            min-height: calc(100vh - 160px);
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 50px 20px;
            box-sizing: border-box;
        }

        .class-setup-main .dino-container {
            width: 100%;
            max-width: 860px;
            margin: 0 auto;
        }

        .student-list {
            max-height: 220px;
            overflow-y: auto;
            border: 3px solid #e0e0e0;
            border-radius: 15px;
            padding: 10px 14px;
            background: #fafafa;
        }

        .student-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 4px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            border-radius: 8px;
            transition: background 0.15s;
        }

        .student-item:last-child {
            border-bottom: none;
        }

        .student-item:hover {
            background: #e8f5e9;
        }

        .student-item input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: var(--leaf-green);
        }

        .student-item label {
            margin: 0;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            color: #333;
        }

        .select-actions {
            display: flex;
            gap: 10px;
            margin-bottom: 8px;
        }

        .btn-tiny {
            background: none;
            border: 2px solid var(--leaf-green);
            color: var(--dark-jungle);
            border-radius: 10px;
            padding: 4px 12px;
            font-family: 'Quicksand', sans-serif;
            font-weight: 700;
            font-size: 12px;
            cursor: pointer;
        }

        .btn-tiny:hover {
            background: #e8f5e9;
        }

        .selected-badge {
            display: inline-block;
            background: var(--leaf-green);
            color: white;
            padding: 2px 10px;
            border-radius: 12px;
            font-size: 12px;
            margin-left: 8px;
        }

        .empty-students {
            color: #aaa;
            font-size: 14px;
            text-align: center;
            padding: 20px 0;
        }

        select {
            width: 100%;
            padding: 12px 16px;
            border: 3px solid var(--leaf-green);
            border-radius: 15px;
            font-family: 'Quicksand', sans-serif;
            font-size: 15px;
            background: white;
            box-sizing: border-box;
        }

        select:focus {
            outline: none;
            border-color: var(--dark-jungle);
        }

        .teacher-warning {
            color: #b71c1c;
            font-weight: 700;
            font-size: 13px;
            margin-top: 8px;
        }
    </style>
</head>

<body>
    <jsp:include page="/header.jsp" />

    <%
        List<String[]> students = (List<String[]>) request.getAttribute("students");
        List<String[]> teachers = (List<String[]>) request.getAttribute("teachers");

        int studentCount = (students != null) ? students.size() : 0;
    %>

    <div class="class-setup-main">
        <div class="dino-container">

            <header class="dino-header">
                <div class="dino-mascot">🦕</div>
                <div class="header-text">
                    <h1>Class Setup</h1>
                    <p>Start a new adventure!</p>
                </div>
            </header>

            <% if (request.getAttribute("dbError") != null) { %>
                <div class="dino-card volcano-orange" style="margin-bottom:15px;">
                    <p style="color:#b71c1c; margin:0;">
                        ${dbError}
                    </p>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/ClassServlet" method="post">

                <fieldset class="dino-card jungle-green">
                    <legend>🦖 Course Details</legend>

                    <div class="input-field">
                        <label>Class Name *</label>
                        <input type="text"
                               name="className"
                               placeholder="e.g., Little Explorers"
                               required>
                    </div>

                    <div class="input-field">
                        <label>Class Level *</label>
                        <input type="text"
                               name="classCode"
                               placeholder="e.g., Kindergarten 4"
                               required>
                    </div>
                </fieldset>

                <fieldset class="dino-card forest-green">
                    <legend>🌴 Schedule & Size</legend>

                    <div class="grid-row">
                        <div class="input-field">
                            <label>Max Children *</label>
                            <input type="number"
                                   name="maxKids"
                                   placeholder="25"
                                   min="1"
                                   required>
                        </div>

                        <div class="input-field">
                            <label>Lead Teacher *</label>

                            <select name="teacher" required>
                                <option value="">-- Select teacher --</option>

                                <% if (teachers != null && !teachers.isEmpty()) {
                                    for (String[] t : teachers) {
                                        String teacherId = t[0];
                                        String username = t[1];
                                        String teacherName = t[2];
                                %>
                                    <option value="<%= teacherId %>">
                                        <%= teacherName %> (<%= username %>)
                                    </option>
                                <%
                                    }
                                }
                                %>
                            </select>

                            <% if (teachers == null || teachers.isEmpty()) { %>
                                <p class="teacher-warning">
                                    ⚠️ No teachers registered yet. Please register a teacher first.
                                </p>
                            <% } %>
                        </div>
                    </div>

                    <label>Class Days *</label>

                    <div class="dino-days">
                        <label class="dino-check">
                            <input type="checkbox" name="classDays" value="Mon"> Mon
                        </label>

                        <label class="dino-check">
                            <input type="checkbox" name="classDays" value="Tue"> Tue
                        </label>

                        <label class="dino-check">
                            <input type="checkbox" name="classDays" value="Wed"> Wed
                        </label>

                        <label class="dino-check">
                            <input type="checkbox" name="classDays" value="Thu"> Thu
                        </label>

                        <label class="dino-check">
                            <input type="checkbox" name="classDays" value="Fri"> Fri
                        </label>
                    </div>
                </fieldset>

                <fieldset class="dino-card jungle-green">
                    <legend>
                        🦕 Assign Students
                        <span class="selected-badge" id="selectedBadge">0 selected</span>
                    </legend>

                    <% if (studentCount == 0) { %>
                        <div class="empty-students">
                            No students registered yet.
                        </div>
                    <% } else { %>

                        <div class="select-actions">
                            <button type="button" class="btn-tiny" onclick="selectAll(true)">
                                Select All
                            </button>

                            <button type="button" class="btn-tiny" onclick="selectAll(false)">
                                Clear All
                            </button>
                        </div>

                        <div class="student-list" id="studentList">
                            <% for (String[] s : students) { %>
                                <div class="student-item">
                                    <input type="checkbox"
                                           name="studentIds"
                                           value="<%= s[0] %>"
                                           id="s<%= s[0] %>"
                                           onchange="updateBadge()">

                                    <label for="s<%= s[0] %>">
                                        <%= s[1] %> <%= s[2] %>
                                    </label>
                                </div>
                            <% } %>
                        </div>

                    <% } %>
                </fieldset>

                <div class="dino-actions">
                    <button type="button"
                            class="btn-volcano"
                            onclick="window.history.back()">
                        Cancel
                    </button>

                    <button type="submit" class="btn-leaf">
                        Save Adventure!
                    </button>
                </div>

            </form>

        </div>
    </div>

    <script>
        function updateBadge() {
            const checked = document.querySelectorAll('input[name="studentIds"]:checked').length;
            document.getElementById('selectedBadge').textContent = checked + ' selected';
        }

        function selectAll(check) {
            document.querySelectorAll('input[name="studentIds"]')
                    .forEach(cb => cb.checked = check);
            updateBadge();
        }
    </script>

    <jsp:include page="/footer.jsp" />
</body>
</html>