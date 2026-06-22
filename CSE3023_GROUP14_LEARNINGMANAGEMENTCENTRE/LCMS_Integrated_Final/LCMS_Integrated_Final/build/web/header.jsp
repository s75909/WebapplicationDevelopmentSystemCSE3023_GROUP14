<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/global.css">

<%
    String headerRole = (String) session.getAttribute("role");

    String profileName = (String) session.getAttribute("name");

    if (profileName == null || profileName.trim().equals("")) {
        profileName = (String) session.getAttribute("parentName");
    }

    if (profileName == null || profileName.trim().equals("")) {
        profileName = (String) session.getAttribute("user");
    }

    if (profileName == null || profileName.trim().equals("")) {
        profileName = "Guest";
    }

    String profileRole = headerRole;

    if (profileRole == null || profileRole.trim().equals("")) {
        profileRole = "";
    }
%>

<nav class="navbar">

    <a href="<%= request.getContextPath() %>/index.jsp" class="nav-brand">
        <span>🦕</span> TASKA PERMATA LCMS
    </a>

    <ul class="nav-links">

        <% if ("manager".equals(headerRole)) { %>

            <li>
                <a href="<%= request.getContextPath() %>/ManagerDashboardServlet">
                    Admin Dashboard
                </a>
            </li>

            <li>
                <a href="<%= request.getContextPath() %>/registration_1.jsp">
                    Register Child
                </a>
            </li>

            <li>
                <a href="<%= request.getContextPath() %>/AttendanceReport">
                    Attendance Report
                </a>
            </li>

            <li>
                <a href="<%= request.getContextPath() %>/markAttendance.jsp">
                    Mark Attendance
                </a>
            </li>

            <li>
                <a href="<%= request.getContextPath() %>/ClassServlet">
                    Class Setup
                </a>
            </li>

            <li>
                <a href="<%= request.getContextPath() %>/paymentHistory.jsp">
                    Payment Dashboard
                </a>
            </li>

            <li>
                <a href="<%= request.getContextPath() %>/paymentVerification.jsp">
                    Verify Payment
                </a>
            </li>

        <% } else if ("teacher".equals(headerRole)) { %>

            <li>
                <a href="<%= request.getContextPath() %>/TeacherServlet">
                    Instructor Dashboard
                </a>
            </li>

            <li>
                <a href="<%= request.getContextPath() %>/markAttendance.jsp">
                    Mark Attendance
                </a>
            </li>

            <li>
                <a href="<%= request.getContextPath() %>/AttendanceReport">
                    Attendance Report
                </a>
            </li>

            <li>
                <a href="<%= request.getContextPath() %>/ClassServlet">
                    Class Setup
                </a>
            </li>

        <% } else if ("parent".equals(headerRole)) { %>

            <li>
                <a href="<%= request.getContextPath() %>/payment.jsp">
                    Make Payment
                </a>
            </li>

            <li>
                <a href="<%= request.getContextPath() %>/myPayments.jsp">
                    My Payment History
                </a>
            </li>

            <li>
                <a href="<%= request.getContextPath() %>/registration_1.jsp">
                    Register Child
                </a>
            </li>

        <% } else { %>

            <li>
                <a href="<%= request.getContextPath() %>/login.jsp">
                    Login
                </a>
            </li>

        <% } %>

        <% if (headerRole != null) { %>
            <li>
                <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn-logout">
                    Logout
                </a>
            </li>
        <% } %>

    </ul>

</nav>