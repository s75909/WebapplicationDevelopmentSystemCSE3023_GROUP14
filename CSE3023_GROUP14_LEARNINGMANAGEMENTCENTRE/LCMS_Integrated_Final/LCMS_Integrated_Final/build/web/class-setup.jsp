<%@page import="com.lcms.dao.InstructorDAO"%>
<%@page import="com.lcms.model.Instructor"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dino-Class Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --leaf-green: #4caf50;
            --dark-forest: #2e7d32;
            --volcano-orange: #ff7043;
            --sky-blue: #81d4fa;
            --dino-yellow: #fff176;
        }

        .dino-container {
            background: white;
            max-width: 950px; /* Wide layout to fit both sections */
            width: 100%;
            margin: 0 auto; 
            border: 6px solid var(--leaf-green);
            border-radius: 40px;
            padding: 30px;
            box-shadow: 10px 10px 0px var(--dark-forest);
        }

        .dino-header { display: flex; align-items: center; gap: 20px; margin-bottom: 30px; background: var(--sky-blue); padding: 15px; border-radius: 25px; }
        .dino-mascot { font-size: 50px; }
        h1 { color: var(--dark-forest); margin: 0; font-size: 24px; }
        
        .form-columns {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 25px;
        }

        .dino-card { border: 3px dashed var(--leaf-green); border-radius: 20px; padding: 20px; }
        legend { background: var(--dino-yellow); padding: 5px 15px; border-radius: 15px; font-weight: bold; color: var(--dark-forest); border: 2px solid var(--leaf-green); }
        
        .grid-row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        
        /* Applied consistent styling to both inputs and selects */
        input, select { width: 100%; padding: 12px; margin-top: 8px; border: 3px solid #eee; border-radius: 15px; box-sizing: border-box; font-family: inherit; }
        input:focus, select:focus { border-color: var(--leaf-green); outline: none; }
        
        .dino-days { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px; }
        .dino-check { background: #f1f8e9; padding: 8px 12px; border-radius: 12px; cursor: pointer; border: 2px solid transparent; }
        .dino-check:has(input:checked) { background: var(--leaf-green); color: white; border-color: var(--dark-forest); }
        
        .dino-actions { display: flex; gap: 15px; }
        .btn-leaf { background: var(--leaf-green); color: white; flex: 2; padding: 15px; border-radius: 20px; border: none; font-weight: bold; font-size: 18px; cursor: pointer; box-shadow: 0 5px 0 var(--dark-forest); }
        .btn-volcano { background: var(--volcano-orange); color: white; flex: 1; border-radius: 20px; border: none; font-weight: bold; cursor: pointer; }
        button:active { transform: translateY(4px); box-shadow: none; }

        .success-msg { background: #c8e6c9; color: #2e7d32; padding: 15px; border-radius: 15px; margin-bottom: 20px; font-weight: bold; text-align: center; border: 2px solid #4caf50; }
        .error-msg { background: #ffccbc; color: #d84315; padding: 15px; border-radius: 15px; margin-bottom: 20px; font-weight: bold; text-align: center; border: 2px solid #ff7043; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="main-content">
        <div class="dino-container">
            <header class="dino-header">
                <div class="dino-mascot">🦕</div>
                <div class="header-text">
                    <h1>Class Setup</h1>
                    <p>Let's create a new learning adventure!</p>
                </div>
            </header>

            <% 
                String msg = (String) request.getAttribute("message");
                if(msg != null) { 
                    String cssClass = msg.contains("Oops") ? "error-msg" : "success-msg";
            %>
                <div class="<%= cssClass %>"><%= msg %></div>
            <% } %>

            <form action="ClassSetupServlet" method="POST">
                
                <div class="form-columns">
                    
                    <fieldset class="dino-card jungle-green">
                        <legend>🦖 Course Details</legend>
                        <div class="input-field">
                            <label>Class Name *</label>
                            <input type="text" name="className" placeholder="e.g., Little Explorers" required>
                        </div>
                        <div class="input-field">
                            <label>Class Code *</label>
                            <input type="text" name="classCode" placeholder="e.g., K4-A" required>
                        </div>
                    </fieldset>

                    <fieldset class="dino-card forest-green">
                        <legend>🌴 Schedule & Size</legend>
                        <div class="grid-row">
                            <div class="input-field">
                                <label>Max Children *</label>
                                <input type="number" name="maxChildren" placeholder="20" required>
                            </div>
                            
                            <div class="input-field">
                                <label>Lead Teacher *</label>
                                <select name="leadTeacher" required>
                                    <option value="">-- Select Instructor --</option>
                                    <% 
                                        try {
                                            InstructorDAO instDao = new InstructorDAO();
                                            List<Instructor> instructors = instDao.getAllInstructors();
                                            if(instructors != null) {
                                                for(Instructor inst : instructors) {
                                    %>
                                        <option value="<%= inst.getFullName() %>"><%= inst.getFullName() %></option>
                                    <%          }
                                            }
                                        } catch(Exception e) {
                                            out.println("<option value=''>Error loading instructors</option>");
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        
                        <label>Class Days *</label>
                        <div class="dino-days">
                            <label class="dino-check"><input type="checkbox" name="classDays" value="Mon"> Mon</label>
                            <label class="dino-check"><input type="checkbox" name="classDays" value="Tue"> Tue</label>
                            <label class="dino-check"><input type="checkbox" name="classDays" value="Wed"> Wed</label>
                            <label class="dino-check"><input type="checkbox" name="classDays" value="Thu"> Thu</label>
                            <label class="dino-check"><input type="checkbox" name="classDays" value="Fri"> Fri</label>
                        </div>
                    </fieldset>
                    
                </div>

                <div class="dino-actions">
                    <button type="button" class="btn-volcano" onclick="window.location.href='Dashboard'">Cancel</button>
                    <button type="submit" class="btn-leaf">Save Adventure!</button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>