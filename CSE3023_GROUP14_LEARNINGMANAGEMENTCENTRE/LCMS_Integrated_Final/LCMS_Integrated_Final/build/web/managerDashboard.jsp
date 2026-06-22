<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <title>Manager Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">

    <style>
        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 25px;
        }

        .action-card {
            background: white;
            border: 4px dashed var(--leaf-green);
            border-radius: 20px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: transform 0.1s, box-shadow 0.1s;
        }

        .action-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 0 var(--dark-jungle);
        }

        .action-card .icon {
            font-size: 36px;
            margin-bottom: 8px;
        }

        .action-card h3 {
            margin: 0 0 6px;
            color: var(--dark-jungle);
            font-size: 16px;
        }

        .action-card p {
            margin: 0;
            font-size: 13px;
            color: #666;
        }

        .action-card.volcano {
            border-color: var(--volcano);
        }

        .action-card.volcano:hover {
            box-shadow: 0 6px 0 #bf360c;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        .data-table th {
            background: var(--dark-jungle);
            color: white;
            padding: 10px 12px;
            text-align: left;
        }

        .data-table th:first-child {
            border-radius: 12px 0 0 0;
        }

        .data-table th:last-child {
            border-radius: 0 12px 0 0;
        }

        .data-table td {
            padding: 10px 12px;
            border-bottom: 1px solid #e8f5e9;
            vertical-align: middle;
        }

        .data-table tr:hover td {
            background: #f1f8e9;
        }

        .badge {
            display: inline-block;
            background: var(--leaf-green);
            color: white;
            padding: 2px 10px;
            border-radius: 12px;
            font-size: 12px;
        }

        .badge-orange {
            display: inline-block;
            background: var(--volcano);
            color: white;
            padding: 2px 10px;
            border-radius: 12px;
            font-size: 12px;
        }

        .badge-blue {
            display: inline-block;
            background: #1565c0;
            color: white;
            padding: 2px 10px;
            border-radius: 12px;
            font-size: 12px;
        }

        .empty-msg {
            color: #888;
            font-size: 14px;
            padding: 10px 0;
        }

        .table-scroll {
            width: 100%;
            overflow-x: auto;
        }

        .tbl-btn {
            padding: 5px 10px;
            border-radius: 10px;
            border: none;
            font-family: 'Quicksand', sans-serif;
            font-weight: 700;
            font-size: 12px;
            cursor: pointer;
            margin: 2px;
        }

        .tbl-edit {
            background: #fff176;
            color: #333;
        }

        .tbl-delete {
            background: #ffcdd2;
            color: #b71c1c;
        }

        .tbl-save {
            background: #c8e6c9;
            color: #1b5e20;
        }

        .tbl-cancel {
            background: #eeeeee;
            color: #555;
        }

        .edit-row td {
            background: #e3f2fd !important;
            padding: 12px !important;
        }

        .edit-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 10px;
            margin-bottom: 10px;
        }

        .edit-field label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: #555;
            margin-bottom: 4px;
        }

        .edit-field input {
            width: 100%;
            padding: 8px 10px;
            border: 2px solid #1565c0;
            border-radius: 10px;
            font-family: 'Quicksand', sans-serif;
            box-sizing: border-box;
        }

        .flash-ok {
            background: #e8f5e9;
            color: #1b5e20;
            border: 3px solid var(--leaf-green);
            padding: 12px 18px;
            border-radius: 15px;
            margin-bottom: 18px;
            font-weight: 700;
        }

        .flash-err {
            background: #fff3e0;
            color: #bf360c;
            border: 3px solid var(--volcano);
            padding: 12px 18px;
            border-radius: 15px;
            margin-bottom: 18px;
            font-weight: 700;
        }

        @media screen and (max-width: 768px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .edit-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<%
    List<String[]> parents  = (List<String[]>) request.getAttribute("parents");
    List<String[]> students = (List<String[]>) request.getAttribute("students");
    List<String[]> teachers = (List<String[]>) request.getAttribute("teachers");

    int parentCount  = (parents  != null) ? parents.size()  : 0;
    int studentCount = (students != null) ? students.size() : 0;
    int teacherCount = (teachers != null) ? teachers.size() : 0;

    String flashOk = (String) session.getAttribute("flashSuccess");
    if (flashOk != null) {
        session.removeAttribute("flashSuccess");
    }

    String flashErr = (String) session.getAttribute("flashError");
    if (flashErr != null) {
        session.removeAttribute("flashError");
    }
%>

<jsp:include page="header.jsp" />

<div class="main-content">
<div class="dino-container" style="max-width:1000px;">

    <header class="dino-header">
        <div class="dino-mascot">🛡️</div>
        <div class="header-text">
            <h1>Manager Dashboard</h1>
            <p>Welcome, ${sessionScope.user}! Manage the LCMS.</p>
        </div>
    </header>

    <% if (flashOk != null) { %>
        <div class="flash-ok">✅ <%= flashOk %></div>
    <% } %>

    <% if (flashErr != null) { %>
        <div class="flash-err">❌ <%= flashErr %></div>
    <% } %>

    <!-- Quick action cards -->
    <div class="dashboard-grid">

        <div class="action-card"
             onclick="location.href='${pageContext.request.contextPath}/registration.jsp'">
            <div class="icon">🦕</div>
            <h3>Register Student</h3>
            <p>Enroll a new student and link to a parent</p>
        </div>

        <div class="action-card"
             onclick="location.href='${pageContext.request.contextPath}/ClassServlet'">
            <div class="icon">📚</div>
            <h3>Setup Class</h3>
            <p>Create or configure a classroom</p>
        </div>

        <div class="action-card"
             onclick="location.href='${pageContext.request.contextPath}/parentRegister.jsp'">
            <div class="icon">👪</div>
            <h3>Add Parent</h3>
            <p>Register a new parent account</p>
        </div>

        <div class="action-card"
             onclick="location.href='${pageContext.request.contextPath}/ManagerDashboardServlet?action=addTeacher'">
            <div class="icon">🍎</div>
            <h3>Add Teacher</h3>
            <p>Register a new teacher account</p>
        </div>

        <div class="action-card volcano"
             onclick="location.href='${pageContext.request.contextPath}/ManagerDashboardServlet?action=logout'">
            <div class="icon">🚪</div>
            <h3>Logout</h3>
            <p>Return to the login screen</p>
        </div>

    </div>

    <!-- Registered Parents -->
    <fieldset class="dino-card jungle-green" style="margin-bottom:20px;">
        <legend>👪 Registered Parents
            <span class="badge"><%= parentCount %></span>
        </legend>

        <% if (parents == null || parents.isEmpty()) { %>

            <p class="empty-msg">No parents registered yet.</p>

        <% } else { %>

            <div class="table-scroll">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone</th>
                        </tr>
                    </thead>

                    <tbody>
                        <% int i = 1; for (String[] p : parents) { %>
                            <tr>
                                <td><%= i++ %></td>
                                <td><%= p[1] %></td>
                                <td><%= p[2] %></td>
                                <td><%= p[3] %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

        <% } %>
    </fieldset>

    <!-- Registered Students -->
    <fieldset class="dino-card volcano-orange" style="margin-bottom:20px;">
        <legend>🦕 Registered Students
            <span class="badge-orange"><%= studentCount %></span>
        </legend>

        <% if (students == null || students.isEmpty()) { %>

            <p class="empty-msg">No students registered yet.</p>

        <% } else { %>

            <div class="table-scroll">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Full Name</th>
                            <th>DOB</th>
                        </tr>
                    </thead>

                    <tbody>
                        <% int j = 1; for (String[] s : students) { %>
                            <tr>
                                <td><%= j++ %></td>
                                <td><%= s[1] %> <%= s[2] %></td>
                                <td><%= s[3] %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

        <% } %>
    </fieldset>

    <!-- Registered Teachers -->
    <fieldset class="dino-card jungle-green">
        <legend>🍎 Registered Teachers
            <span class="badge-blue"><%= teacherCount %></span>
        </legend>

        <% if (teachers == null || teachers.isEmpty()) { %>

            <p class="empty-msg">
                No teachers registered yet.
                <a href="${pageContext.request.contextPath}/ManagerDashboardServlet?action=addTeacher">
                    Add one now →
                </a>
            </p>

        <% } else { %>

            <div class="table-scroll">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Username</th>
                            <th>Full Name</th>
                            <th>IC Number</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Qualification</th>
                            <th>Experience</th>
                            <th>Subject</th>
                            <th>Actions</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            int k = 1;
                            for (String[] t : teachers) {
                                String tId = t[0];
                        %>

                        <!-- Display Row -->
                        <tr id="t-row-<%= tId %>">
                            <td><%= k++ %></td>
                            <td><%= t[1] %></td>
                            <td><%= t[2] %></td>
                            <td><%= t[3] != null ? t[3] : "-" %></td>
                            <td><%= t[4] != null ? t[4] : "-" %></td>
                            <td><%= t[5] != null ? t[5] : "-" %></td>
                            <td><%= t[6] != null ? t[6] : "-" %></td>
                            <td><%= t[7] != null ? t[7] : "-" %></td>
                            <td><%= t[8] != null ? t[8] : "-" %></td>
                            <td>
                                <button type="button"
                                        class="tbl-btn tbl-edit"
                                        onclick="showTeacherEdit('t-edit-<%= tId %>', 't-row-<%= tId %>')">
                                    ✏️ Edit
                                </button>

                                <button type="button"
                                        class="tbl-btn tbl-delete"
                                        onclick="confirmDeleteTeacher('<%= tId %>', '<%= t[2] %>')">
                                    🗑️ Delete
                                </button>
                            </td>
                        </tr>

                        <!-- Edit Row -->
                        <tr id="t-edit-<%= tId %>" class="edit-row" style="display:none;">
                            <td colspan="10">

                                <form action="${pageContext.request.contextPath}/ManagerDashboardServlet" method="post">

                                    <input type="hidden" name="action" value="editTeacher">
                                    <input type="hidden" name="id" value="<%= tId %>">

                                    <div class="edit-grid">

                                        <div class="edit-field">
                                            <label>Full Name</label>
                                            <input type="text" name="fullName" value="<%= t[2] != null ? t[2] : "" %>" required>
                                        </div>

                                        <div class="edit-field">
                                            <label>IC Number</label>
                                            <input type="text" name="icNumber" value="<%= t[3] != null ? t[3] : "" %>">
                                        </div>

                                        <div class="edit-field">
                                            <label>Email</label>
                                            <input type="email" name="email" value="<%= t[4] != null ? t[4] : "" %>" required>
                                        </div>

                                        <div class="edit-field">
                                            <label>Phone</label>
                                            <input type="text" name="phone" value="<%= t[5] != null ? t[5] : "" %>">
                                        </div>

                                        <div class="edit-field">
                                            <label>Qualification</label>
                                            <input type="text" name="qualification" value="<%= t[6] != null ? t[6] : "" %>">
                                        </div>

                                        <div class="edit-field">
                                            <label>Teaching Experience</label>
                                            <input type="text" name="teachingExperience" value="<%= t[7] != null ? t[7] : "" %>">
                                        </div>

                                        <div class="edit-field">
                                            <label>Subject</label>
                                            <input type="text" name="subject" value="<%= t[8] != null ? t[8] : "" %>">
                                        </div>

                                    </div>

                                    <button type="submit" class="tbl-btn tbl-save">
                                        💾 Save
                                    </button>

                                    <button type="button"
                                            class="tbl-btn tbl-cancel"
                                            onclick="hideTeacherEdit('t-edit-<%= tId %>', 't-row-<%= tId %>')">
                                        ✖ Cancel
                                    </button>

                                </form>

                            </td>
                        </tr>

                        <% } %>
                    </tbody>
                </table>
            </div>

        <% } %>
    </fieldset>

</div>
</div>

<!-- Hidden delete teacher form -->
<form id="deleteTeacherForm"
      action="${pageContext.request.contextPath}/ManagerDashboardServlet"
      method="post"
      style="display:none;">

    <input type="hidden" name="action" value="deleteTeacher">
    <input type="hidden" name="id" id="deleteTeacherId">
</form>

<jsp:include page="footer.jsp" />

<script>
    function showTeacherEdit(editId, rowId) {
        document.getElementById(rowId).style.display = "none";
        document.getElementById(editId).style.display = "table-row";
    }

    function hideTeacherEdit(editId, rowId) {
        document.getElementById(editId).style.display = "none";
        document.getElementById(rowId).style.display = "table-row";
    }

    function confirmDeleteTeacher(id, name) {
        const confirmDelete = confirm("Delete teacher \"" + name + "\"? This action cannot be undone.");

        if (confirmDelete) {
            document.getElementById("deleteTeacherId").value = id;
            document.getElementById("deleteTeacherForm").submit();
        }
    }
</script>

</body>
</html>