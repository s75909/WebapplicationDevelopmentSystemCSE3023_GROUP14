<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.lcms.dao.managerDAO, java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dino Student Registration</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
    <style>
        select {
            width: 100%; padding: 12px; border: 3px solid #e0e0e0;
            border-radius: 15px; box-sizing: border-box;
            font-family: 'Quicksand', sans-serif; font-size: 15px;
            transition: border-color 0.3s; background: white;
        }
        select:focus { border-color: var(--leaf-green); outline: none; }
    </style>
</head>
<body>
   <%
    String role = (String) session.getAttribute("role");
    boolean isManager = "manager".equals(role);

    String flashError = (String) session.getAttribute("flashError");
    if (flashError != null) {
        session.removeAttribute("flashError");
    }

    List<String[]> parents = null;
    if (isManager) {
        try {
            managerDAO dao = new managerDAO();
            parents = dao.getAllParents();
        } catch (Exception e) { /* table may not exist yet */ }
    }
%>
    <jsp:include page="header.jsp" />

    <div class="main-content">
    <div class="dino-container">
        <header class="dino-header">
            <div class="dino-mascot">🦕</div>
            <div class="header-text">
                <h1>Child Registration</h1>
                <p><%= isManager ? "Register a student (Manager View)" : "Enroll a new little dinosaur to the LCMS!" %></p>
            </div>
        </header>
        <form action="${pageContext.request.contextPath}/StudentServlet" method="post">

            <% if (isManager && parents != null && !parents.isEmpty()) { %>
            <fieldset class="dino-card forest-green">
                <legend>👪 Link to Parent</legend>
                <div class="input-field">
                    <label>Select Parent *</label>
                    <select name="parentId" required>
                        <option value="">-- Choose a parent --</option>
                        <% for (String[] p : parents) { %>
                            <option value="<%= p[0] %>"><%= p[1] %> (<%= p[2] %>)</option>
                        <% } %>
                    </select>
                </div>
            </fieldset>
            <% } else if (isManager) { %>
            <div class="dino-card volcano-orange" style="margin-bottom:15px;">
                <p style="margin:0;">⚠️ No parents registered yet. Register parents first before linking a student.</p>
            </div>
            <% } %>

            <fieldset class="dino-card jungle-green">
                <legend>🦖 Child Information</legend>
                <div class="row">
                    <div class="input-field">
                        <label>First Name *</label>
                        <input type="text" name="fname" placeholder="Enter first name" required>
                    </div>
                    <div class="input-field">
                        <label>Last Name *</label>
                        <input type="text" name="lname" placeholder="Enter last name" required>
                    </div>
                </div>
                <div class="input-field">
                    <label>Date of Birth *</label>
                    <input type="date" name="dob" required>
                </div>
                <div class="input-field">
                    <label>Gender *</label>
                    <div class="radio-group">
                       <label class="dino-radio">
    <input type="radio" name="gender" value="male" required> Male
</label>

<label class="dino-radio">
    <input type="radio" name="gender" value="female" required> Female
</label>
                    </div>
                </div>
            </fieldset>

            <fieldset class="dino-card volcano-orange">
                <legend>🌴 Guardian Information</legend>
                <div class="input-field">
                    <label>Guardian Name *</label>
                    <input type="text" name="gname" placeholder="Enter guardian name" required>
                </div>
                <div class="row">
                    <div class="input-field">
                        <label>Relationship *</label>
                        <input type="text" name="rel" placeholder="e.g. Mother" required>
                    </div>
                    <div class="input-field">
                        <label>Guardian Phone *</label>
                        <input type="tel" name="phone" placeholder="+60 12-345 6789" required>
                    </div>
                </div>
                <div class="input-field">
                    <label>Guardian Email *</label>
                    <input type="email" name="email" placeholder="guardian@example.com" required>
                </div>
            </fieldset>

            <div class="dino-actions">
                <button type="submit" class="btn-leaf">Register Student! 🐾</button>
                <button type="button" class="btn-stone" onclick="location.href='${pageContext.request.contextPath}/ManagerDashboardServlet'">Cancel</button>
            </div>
        </form>
    </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>