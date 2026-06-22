<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.lcms.dao.StudentDAO"%>
<%
    String role = (String) session.getAttribute("role");
    Integer parentId = (Integer) session.getAttribute("parentId");
    if (!"parent".equals(role) || parentId == null) {
        response.sendRedirect("login.jsp?error=login_required");
        return;
    }
    StudentDAO studentDAO = new StudentDAO();
    List<String[]> childList = studentDAO.getStudentOptionsByParent(parentId);
%>

<!DOCTYPE html>
<html>
    <head>

        <title>Payment Form</title>

        <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">

        <style>

            body{
                font-family:'Quicksand',sans-serif;
                background:#f1f8e9;
                margin:0;
                padding:0;
            }

            .payment-container{
                max-width:850px;
                margin:30px auto;
                background:white;
                border:6px solid #4caf50;
                border-radius:35px;
                padding:30px;
                box-shadow:10px 10px 0px #2e7d32;

            }

            .header-box{
                background:#81d4fa;
                border-radius:25px;
                padding:20px;
                text-align:center;
                margin-bottom:25px;
                border:3px solid #0288d1;
            }

            .header-box h2{
                margin:0;
                color:#2e7d32;
                font-size:32px;
            }

            .header-box p{
                margin-top:10px;
                color:#444;
            }

            fieldset{
                border:3px dashed #4caf50;
                border-radius:20px;
                margin-bottom:20px;
                padding:20px;
            }

            legend{
                background:#fff9c4;
                padding:8px 15px;
                border-radius:15px;
                font-weight:bold;
            }

            label{
                font-weight:bold;
                color:#2e7d32;
            }

            input, select{
                width:100%;
                padding:12px;
                margin-top:8px;
                margin-bottom:15px;
                border:2px solid #ddd;
                border-radius:12px;
                box-sizing:border-box;
                font-family:'Quicksand',sans-serif;
            }

            input[type="file"]{
                background:#f5f5f5;
                padding:10px;
            }

            .payment-guide{
                background: #e8f5e9; /* Matching the yellow legend/warm accent tone */
                border: 3px solid #4caf50; /* Crisp solid border */
                border-radius: 25px; /* Matches the header box rounding */
                padding: 20px;
                margin-bottom: 30px; /* Space between guide and form header */
                text-align: center;
                box-sizing: border-box;
                max-width: 850px;
                margin: 40px auto 20px auto;
            }

            .payment-guide h3 {
                margin-top: 0px;
                color: #2e7d32;
                font-size: 24px;

            }

            .payment-guide p {
                margin: 8px 0;
                color: #333;
                font-size: 16px;

            }

            .qr-image{
                margin-top:15px;
            }

            .qr-image img {
                width: 180px;
                border-radius: 15px;
                border: 3px solid #ef6c00;
            }

            .btn-group{
                display:flex;
                gap:15px;
            }

            .btn-submit{
                flex:1;
                background:#4caf50;
                color:white;
                border:none;
                padding:15px;
                border-radius:15px;
                font-weight:bold;
                cursor:pointer;
                font-size:16px;
            }

            .btn-back{
                flex:1;
                background:#ff7043;
                color:white;
                border:none;
                padding:15px;
                border-radius:15px;
                cursor:pointer;
                font-size:16px;
            }

            .btn-submit:hover{
                background:#43a047;
            }

            .btn-back:hover{
                background:#f4511e;
            }

        </style>

    </head>

    <body>

        <%@ include file="header.jsp" %>
        <!-- PAYMENT INSTRUCTIONS -->
        <div class="payment-guide">

            <h3>📌 Payment Instructions</h3>

            <p><strong>Bank:</strong> Maybank</p>
            <p><strong>Account Name:</strong> Learn4Life Center</p>
            <p><strong>Account Number:</strong> 1234567890</p>

            <p>OR scan the QR below:</p>

            <div class="qr-image">
                <img src="images/qr.jpeg" alt="QR Payment">
            </div>

            <p>After payment, please upload your receipt below.</p>

        </div>
        <div class="payment-container">

            <div class="header-box">
                <h2>💰🦖 Payment Form</h2>
                <p>Keep your child’s learning adventure going!</p>
            </div>

            <%
                String success = request.getParameter("success");
                String error = request.getParameter("error");
            %>

            <% if (success != null) { %>
            <script>
                alert("Payment submitted successfully!");
            </script>
            <% } %>

            <% if (error != null) { %>
            <script>
                alert("Failed to submit payment!");
            </script>
            <% }%>



            <!-- PAYMENT FORM -->
            <form action="PaymentServlet" method="post" enctype="multipart/form-data">

                <!-- TRANSACTION DETAILS -->
                <fieldset>

                    <legend>Transaction Details</legend>

                    <label>Select Child</label>

                    <select name="childName" required>
                        <option value="">-- Choose Student --</option>
                        <% for (String[] child : childList) { %>
                            <option value="<%= child[1] %>"><%= child[1] %></option>
                        <% } %>
                    </select>
                    <% if (childList.isEmpty()) { %>
                        <p style="color:#d32f2f; font-weight:bold;">No child is linked to this parent account yet.</p>
                    <% } %>

                    <label>Payment For</label>

                    <select 
                        name="paymentFor" 
                        id="paymentFor"
                        onchange="setAmount()"
                        required>

                        <option value="">-- Select Payment Type --</option>

                        <option value="Monthly Fee">
                            Monthly Fee
                        </option>

                        <option value="Activity Fee">
                            Activity Fee
                        </option>

                        <option value="Material Fee">
                            Material Fee
                        </option>

                    </select>

                </fieldset>

                <!-- PAYMENT INFO -->
                <fieldset>

                    <legend>Payment Information</legend>

                    <label>Amount (RM)</label>
                    <input 
                        type="text" 
                        name="amount"
                        id="amount"
                        readonly
                        required>



                    <label>Payment Date</label>
                    <input type="text"
                           value="<%= java.time.LocalDate.now()%>"
                           readonly>

                    <label>Upload Receipt (Payment Proof)</label>

                    <input 
                        type="file" 
                        name="receipt" 
                        accept=".jpg,.jpeg,.png,.pdf"
                        required>

                </fieldset>

                <!-- BUTTONS -->
                <div class="btn-group">

                    <button class="btn-submit" type="submit">
                        Submit Payment
                    </button>

                    <button class="btn-back" type="button" onclick="history.back();">
                        Back to Menu
                    </button>

                </div>

            </form>

        </div>
        <script>

            function setAmount() {

                var paymentType =
                        document.getElementById("paymentFor").value;

                var amountField =
                        document.getElementById("amount");

                if (paymentType === "Monthly Fee") {
                    amountField.value = "300";
                } else if (paymentType === "Activity Fee") {
                    amountField.value = "100";
                } else if (paymentType === "Material Fee") {
                    amountField.value = "80";
                } else {
                    amountField.value = "";
                }

            }

        </script>
        <%@ include file="footer.jsp" %>

    </body>
</html>