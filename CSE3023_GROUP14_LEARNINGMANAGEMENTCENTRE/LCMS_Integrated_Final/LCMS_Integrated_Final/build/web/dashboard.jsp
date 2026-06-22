<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dino-Dashboard | LCMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --grass-bg: #e8f5e9;
            --leaf-green: #4caf50;
            --dark-jungle: #2e7d32;
            --sky-blue: #81d4fa;
            --volcano: #ff7043;
        }

        body {
            background-color: var(--grass-bg);
            font-family: 'Quicksand', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .main-content { flex: 1; padding: 40px; }
        .dashboard-wrapper { max-width: 1000px; margin: 0 auto; }

        /* Header */
        .dashboard-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        h1 { color: var(--dark-jungle); margin: 0; }
        .btn-logout { background: var(--volcano); color: white; border: none; padding: 10px 20px; border-radius: 12px; font-weight: bold; cursor: pointer; transition: transform 0.2s; }
        .btn-logout:hover { transform: scale(1.05); }

        /* Grid Cards */
        .stats-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 40px; }
        .stat-card { background: white; padding: 25px; border-radius: 30px; display: flex; align-items: center; gap: 20px; border: 5px solid #fff; box-shadow: 8px 8px 0px rgba(0,0,0,0.05); }
        .stat-card.sky-blue { border-color: var(--sky-blue); }
        .stat-card.leaf-green { border-color: var(--leaf-green); }
        .stat-card.volcano-orange { border-color: var(--volcano); }
        .stat-icon { font-size: 40px; }
        .stat-number { font-size: 32px; font-weight: 800; margin: 0; color: #333; }
        h3 { margin: 0 0 5px 0; color: #666; font-size: 1.1rem; }

        /* Quick Actions */
        .link-buttons { display: flex; flex-wrap: wrap; gap: 15px; }
        .link-buttons button { flex: 1; min-width: 150px; background: white; border: 3px solid var(--leaf-green); padding: 15px; border-radius: 20px; font-family: inherit; font-weight: 700; color: var(--dark-jungle); font-size: 1.1rem; cursor: pointer; transition: all 0.2s; }
        .link-buttons button:hover { background: var(--leaf-green); color: white; transform: translateY(-5px); box-shadow: 0 5px 15px rgba(46, 125, 50, 0.3); }
        
        /* Special style for the delete button */
        .btn-delete { border-color: #ff7043 !important; color: #d84315 !important; }
        .btn-delete:hover { background: #ff7043 !important; color: white !important; box-shadow: 0 5px 15px rgba(216, 67, 21, 0.3) !important; }

    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="main-content">
        <div class="dashboard-wrapper">
            
            <header class="dashboard-header">
                <div class="header-info">
                    <h1>Admin Dashboard 🦖</h1>
                    <p>Welcome back! Here is what's happening at Taska Permata Keluarga.</p>
                </div>
                <button class="btn-logout" onclick="location.href='index.jsp'">Logout 🚪</button>
            </header>

            <% 
                String msg = (String) request.getAttribute("message");
                if(msg != null) { 
            %>
                <div style="background: #e3f2fd; color: #0277bd; padding: 15px; border-radius: 15px; margin-bottom: 25px; font-weight: bold; text-align: center; border: 2px solid #81d4fa;">
                    <%= msg %>
                </div>
            <% } %>

            <div class="stats-grid">
                <div class="stat-card sky-blue">
                    <div class="stat-data">
                        <h3>Total Children</h3>
                        <p class="stat-number"><%= request.getAttribute("totalStudents") != null ? request.getAttribute("totalStudents") : 0 %></p>
                    </div>
                </div>
                <div class="stat-card leaf-green">
                
                    <div class="stat-data">
                        <h3>Active Classes</h3>
                        <p class="stat-number"><%= request.getAttribute("totalClasses") != null ? request.getAttribute("totalClasses") : 0 %></p>
                    </div>
                </div>
                <div class="stat-card volcano-orange">
                  
                    <div class="stat-data">
                        <h3>Present Today</h3>
                        <p class="stat-number"><%= request.getAttribute("presentToday") != null ? request.getAttribute("presentToday") : 0 %></p>
                    </div>
                </div>
            </div>

            <div class="quick-links">
                <h2 style="color: var(--dark-jungle);">Quick Actions</h2>
                <div class="link-buttons">
                    <button onclick="location.href='registration.jsp'">➕ Register</button>
                    <button onclick="location.href='AttendanceReport'">📋 Report</button>
                    <button onclick="location.href='class-setup.jsp'">🦖 Setup Class</button>
                    <button onclick="location.href='markAttendance.jsp'">📝 Arrival</button>
                    
                    <form action="DeleteUnassigned" method="POST" style="margin: 0; padding: 0; display: flex; flex: 1; min-width: 150px;">
                        <button type="submit" class="btn-delete" style="width: 100%;" 
                                onclick="return confirm('Are you sure you want to permanently delete all Unassigned students?');">
                            🗑️ Clean Data
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>