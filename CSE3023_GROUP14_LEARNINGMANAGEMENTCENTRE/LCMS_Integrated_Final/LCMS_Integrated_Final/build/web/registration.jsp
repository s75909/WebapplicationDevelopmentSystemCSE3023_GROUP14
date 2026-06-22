<%-- 
    Document   : registration
    Created on : 13 May 2026, 11:31:46 pm
    Author     : Ikhwan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Dino Student Registration</title>
        <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --leaf-green: #4caf50;
                --dark-jungle: #2e7d32;
                --volcano: #ff7043;
                --sky: #81d4fa;
                --dino-egg: #fff9c4;
            }

            .dino-container {
                background: white;
                max-width: 950px;
                width: 100%;
                margin: 0 auto;
                border: 6px solid var(--leaf-green);
                border-radius: 40px;
                padding: 30px;
                box-shadow: 12px 12px 0px var(--dark-jungle);
            }

            .dino-header {
                display: flex;
                align-items: center;
                gap: 15px;
                background: var(--sky);
                padding: 20px;
                border-radius: 30px;
                margin-bottom: 30px;
                border: 3px solid #0288d1;
            }

            .dino-mascot {
                font-size: 50px;
            }

            h1 {
                color: var(--dark-jungle);
                margin: 0;
                font-size: 26px;
            }


            .form-columns {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 30px;
                margin-bottom: 25px;
            }

            .dino-card {
                border: 4px dashed var(--leaf-green);
                border-radius: 25px;
                padding: 20px;
                background: #fdfdfd;
                margin-bottom: 0;
            }

            .volcano-orange {
                border-color: var(--volcano);
            }

            legend {
                background: var(--dino-egg);
                padding: 8px 20px;
                border-radius: 20px;
                font-weight: 700;
                color: var(--dark-jungle);
                border: 3px solid var(--leaf-green);
            }

            .row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }

            .input-field {
                margin-bottom: 15px;
            }

            label {
                display: block;
                font-weight: 700;
                margin-bottom: 5px;
                color: #444;
            }

            input {
                width: 100%;
                padding: 12px;
                border: 3px solid #e0e0e0;
                border-radius: 15px;
                box-sizing: border-box;
                font-family: inherit;
                transition: border-color 0.3s;
            }

            input:focus {
                border-color: var(--leaf-green);
                outline: none;
            }

            .radio-group {
                display: flex;
                gap: 20px;
                padding: 10px 0;
            }

            .btn-leaf {
                background: var(--leaf-green);
                color: white;
                flex: 2;
                padding: 18px;
                border-radius: 25px;
                border: none;
                font-weight: 700;
                font-size: 18px;
                cursor: pointer;
                box-shadow: 0 6px 0 var(--dark-jungle);
            }

            .btn-stone {
                background: #90a4ae;
                color: white;
                flex: 1;
                border-radius: 25px;
                border: none;
                font-weight: 700;
                cursor: pointer;
            }

            .dino-actions {
                display: flex;
                gap: 15px;
                margin-top: 10px;
            }

            button:active {
                transform: translateY(4px);
                box-shadow: none;
            }

            .success-msg {
                background: #c8e6c9;
                color: #2e7d32;
                padding: 15px;
                border-radius: 15px;
                margin-bottom: 20px;
                font-weight: bold;
                text-align: center;
                border: 2px solid #4caf50;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div class="main-content">
            <div class="dino-container">
                <header class="dino-header">
                    <div class="dino-mascot">🦕</div>
                    <div class="header-text">
                        <h1>Child Registration</h1>
                        <p>Enroll a new little dinosaur to the LCMS!</p>
                    </div>
                </header>

                <% if (request.getAttribute("message") != null) {%>
                <div class="success-msg">
                    <%= request.getAttribute("message")%>
                </div>
                <% }%>

                <form action="StudentServlet" method="POST">

                    <div class="form-columns">

                        <fieldset class="dino-card jungle-green">
                            <legend>🦖 Child Information</legend>
                            <div class="row">
                                <div class="input-field">
                                    <label>First Name *</label>
                                    <input type="text" name="firstName" placeholder="Enter first name" required>
                                </div>
                                <div class="input-field">
                                    <label>Last Name *</label>
                                    <input type="text" name="lastName" placeholder="Enter last name" required>
                                </div>
                            </div>
                            <div class="input-field">
                                <label>Date of Birth *</label>
                                <input type="date" name="dob" required>
                            </div>
                            <div class="input-field">
                                <label>Gender *</label>
                                <div class="radio-group">
                                    <label class="dino-radio"><input type="radio" name="gender" value="male" required> Male</label>
                                    <label class="dino-radio"><input type="radio" name="gender" value="female" required> Female</label>
                                </div>
                            </div>
                        </fieldset>

                        <fieldset class="dino-card volcano-orange">
                            <legend>🌴 Guardian Information</legend>
                            <div class="input-field">
                                <label>Guardian Name *</label>
                                <input type="text" name="guardianName" placeholder="Enter guardian name" required>
                            </div>
                            <div class="row">
                                <div class="input-field">
                                    <label>Relationship *</label>
                                    <input type="text" name="relationship" placeholder="e.g. Mother" required>
                                </div>
                                <div class="input-field">
                                    <label>Guardian Phone *</label>
                                    <input type="tel" name="guardianPhone" placeholder="+60 12-345 6789" required>
                                </div>
                            </div>
                            <div class="input-field">
                                <label>Guardian Email *</label>
                                <input type="email" name="guardianEmail" placeholder="guardian@example.com" required>
                            </div>
                        </fieldset>

                    </div> <div class="dino-actions">
                        <button type="submit" class="btn-leaf">Register Student! 🐾</button>
                        <button type="button" class="btn-stone" onclick="window.history.back()">Cancel</button>
                    </div>
                </form>
            </div>
        </div> 

        <jsp:include page="footer.jsp" />
    </body>
</html>