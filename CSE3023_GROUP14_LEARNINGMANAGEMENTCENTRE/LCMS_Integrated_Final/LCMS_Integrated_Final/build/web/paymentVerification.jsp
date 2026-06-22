<%-- 
    Document   : paymentVerification
    Created on : 20 May 2026
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.lcms.dao.PaymentDAO"%>
<%@page import="com.lcms.model.Payment"%>

<%
    if (!"manager".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp?error=admin_only");
        return;
    }

    PaymentDAO dao = new PaymentDAO();
    List<Payment> pendingList = dao.getPendingPayments();
%>

<!DOCTYPE html>
<html>
    <head>

        <title>Payment Verification Dashboard</title>

        <style>

            body{
                font-family: Arial;
            }

            .container{
                max-width:1200px;
                margin:auto;
                background:white;
                padding:30px;
                border-radius:15px;
                box-shadow:0 0 10px rgba(0,0,0,0.1);
            }

            h2{
                color:#2e7d32;
                margin-bottom:30px;
            }

            .payment-card{
                border:1px solid #ddd;
                border-radius:12px;
                padding:20px;
                margin-bottom:20px;
                background:#fafafa;
            }

            .payment-card p{
                margin:8px 0;
            }

            .status{
                display:inline-block;
                padding:6px 14px;
                border-radius:20px;
                background:orange;
                color:white;
                font-size:13px;
                font-weight:bold;
            }

            .receipt-img{
                width:250px;
                margin-top:10px;
                border-radius:10px;
                border:1px solid #ccc;
            }

            .btn{
                padding:10px 18px;
                border:none;
                border-radius:8px;
                cursor:pointer;
                font-size:14px;
                margin-top:15px;
                margin-right:10px;
            }

            .approve-btn{
                background:#43a047;
                color:white;
            }

            .reject-btn{
                background:#e53935;
                color:white;
            }

            .no-payment{
                text-align:center;
                padding:30px;
                color:gray;
                font-size:18px;
            }

        </style>

    </head>

    <body>

        <jsp:include page="header.jsp" />

        <div class="main-content">
        <div class="container">

            <h2>Payment Verification Dashboard</h2>

            <% if (pendingList.isEmpty()) { %>

            <div class="no-payment">
                No pending payments found.
            </div>

            <% } else { %>

            <% for (Payment p : pendingList) {%>

            <div class="payment-card">

                <p>
                    <strong>Child Name:</strong>
                    <%= p.getChildName()%>
                </p>

                <p>
                    <strong>Payment For:</strong>
                    <%= p.getPaymentFor()%>
                </p>

                <p>
                    <strong>Amount:</strong>
                    RM <%= p.getAmount()%>
                </p>

                <p>
                    <strong>Payment Date:</strong>
                    <%= p.getPaymentDate()%>
                </p>

                <p>
                    <strong>Status:</strong>
                    <span class="status">
                        <%= p.getStatus()%>
                    </span>
                </p>

                <p>
                    <strong>Uploaded Receipt:</strong>
                </p>

                <a 
                    href="<%= request.getContextPath() + "/" + p.getReceiptPath()%>" 
                    target="_blank"
                    class="receipt-link"
                    >

                    View Receipt

                </a>

                <br>

                <!-- APPROVE BUTTON -->
                <a href="PaymentServlet?action=approve&id=<%= p.getPaymentId()%>">

                    <button class="btn approve-btn">
                        Approve Payment
                    </button>

                </a>

                <!-- REJECT BUTTON -->
                <a href="PaymentServlet?action=reject&id=<%= p.getPaymentId()%>">

                    <button class="btn reject-btn">
                        Reject Payment
                    </button>

                </a>

            </div>

            <% } %>

            <% }%>

        </div>
        </div>

        <jsp:include page="footer.jsp" />

    </body>
</html>