<%-- 
    Document   : studentResult
    Created on : May 15, 2026, 7:06:25 AM
    Author     : Dini <s75909@ocean.umt.edu.my>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Boolean success = (Boolean) request.getAttribute("success");
    String message = (String) request.getAttribute("message");

    if (message == null || message.trim().isEmpty()) {
        message = "No status message available.";
    }

    String registerPage = request.getContextPath() + "/registration_1.jsp";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Status Report</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
</head>

<body>
    <jsp:include page="header.jsp" />

    <div class="main-content">
        <div class="dino-container">

            <header class="dino-header">
                <div class="dino-mascot">🐾</div>
                <div class="header-text">
                    <h1>Action Status</h1>
                </div>
            </header>

            <% if (Boolean.TRUE.equals(success)) { %>

                <div class="dino-card jungle-green">
                    <legend>✅ Success!</legend>
                    <p><%= message %></p>
                </div>

                <div class="dino-actions">
                    <a href="<%= registerPage %>"
                       class="btn-leaf"
                       style="text-decoration:none; text-align:center; display:block;">
                        Go Back
                    </a>
                </div>

            <% } else { %>

                <div class="dino-card volcano-orange">
                    <legend>⚠️ Error</legend>
                    <p><%= message %></p>
                </div>

                <div class="dino-actions">
                    <a href="<%= registerPage %>"
                       class="btn-leaf"
                       style="text-decoration:none; text-align:center; display:block;">
                        Try Again
                    </a>
                </div>

            <% } %>

        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>