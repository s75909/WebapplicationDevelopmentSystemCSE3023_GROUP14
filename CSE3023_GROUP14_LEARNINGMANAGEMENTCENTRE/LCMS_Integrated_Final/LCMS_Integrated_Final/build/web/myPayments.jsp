<%-- 
    Document   : myPayments
    Created on : 20 May 2026, 4:27:24 am
    Author     : Acer
--%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lcms.dao.PaymentDAO"%>
<%@page import="com.lcms.model.Payment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("role");
    Integer parentId = (Integer) session.getAttribute("parentId");

    if (!"parent".equals(role) || parentId == null) {
        response.sendRedirect("login.jsp?error=login_required");
        return;
    }

    PaymentDAO dao = new PaymentDAO();
    List<Payment> paymentList = dao.getParentPayments(parentId);

    double totalPaid = 0;
    double totalPending = 0;
    double totalRejected = 0;

    for (Payment p : paymentList) {
        if ("Paid".equalsIgnoreCase(p.getStatus()) || "Approved".equalsIgnoreCase(p.getStatus())) {
            totalPaid += p.getAmount();
        } else if ("Pending".equalsIgnoreCase(p.getStatus())) {
            totalPending += p.getAmount();
        } else if ("Rejected".equalsIgnoreCase(p.getStatus())) {
            totalRejected += p.getAmount();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>My Payments</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:Arial, sans-serif;
        }

        body{
            min-height:100vh;
        }

        .container{
            width:90%;
            margin:40px auto;
        }

        .title{
            font-size:32px;
            font-weight:bold;
            margin-bottom:25px;
            color:#2e7d32;
        }

        .summary-box{
            display:flex;
            gap:20px;
            margin:0 0 30px 0;
        }

        .summary-card{
            flex:1;
            background:white;
            border-left:8px solid #4caf50;
            padding:18px 25px;
            border-radius:15px;
            box-shadow:0 4px 12px rgba(0,0,0,0.08);
        }

        .summary-card span{
            display:block;
            color:#555;
            font-weight:bold;
            margin-bottom:8px;
        }

        .summary-card strong{
            font-size:24px;
            color:#2e7d32;
        }

        .pending-card{
            border-left-color:orange;
        }

        .pending-card strong{
            color:orange;
        }

        .rejected-card{
            border-left-color:red;
        }

        .rejected-card strong{
            color:red;
        }

        table{
            width:100%;
            border-collapse:collapse;
            background:white;
            border-radius:10px;
            overflow:hidden;
            box-shadow:0 2px 10px rgba(0,0,0,0.1);
        }

        table th{
            background:#4CAF50;
            color:white;
            padding:15px;
            text-align:center;
        }

        table td{
            padding:15px;
            text-align:center;
            border-bottom:1px solid #ddd;
        }

        table tr:hover{
            background:#f1f1f1;
        }

        .status{
            padding:8px 15px;
            border-radius:20px;
            color:white;
            font-weight:bold;
            display:inline-block;
            min-width:100px;
        }

        .pending{
            background:orange;
        }

        .paid{
            background:green;
        }

        .rejected{
            background:red;
        }

        .receipt-actions{
            display:flex;
            flex-direction:column;
            align-items:center;
            gap:8px;
        }

        .receipt-btn{
            text-decoration:none;
            background:#3498db;
            color:white;
            padding:8px 15px;
            border-radius:5px;
            transition:0.3s;
            display:inline-block;
            min-width:120px;
        }

        .receipt-btn:hover{
            background:#2980b9;
        }

        .print-btn{
            background:#2e7d32;
        }

        .print-btn:hover{
            background:#1b5e20;
        }

        .no-data{
            background:white;
            padding:40px;
            text-align:center;
            border-radius:10px;
            font-size:20px;
            color:gray;
            box-shadow:0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="main-content">
    <div class="container">

        <div class="title">
            My Payment History
        </div>

        <div class="summary-box">
            <div class="summary-card">
                <span>Total Paid</span>
                <strong>RM <%= String.format("%.2f", totalPaid) %></strong>
            </div>

            <div class="summary-card pending-card">
                <span>Total Pending</span>
                <strong>RM <%= String.format("%.2f", totalPending) %></strong>
            </div>

            <div class="summary-card rejected-card">
                <span>Total Rejected</span>
                <strong>RM <%= String.format("%.2f", totalRejected) %></strong>
            </div>
        </div>

        <% if (paymentList.isEmpty()) { %>

            <div class="no-data">
                No payment records found.
            </div>

        <% } else { %>

            <table>
                <tr>
                    <th>Payment ID</th>
                    <th>Child Name</th>
                    <th>Payment For</th>
                    <th>Amount (RM)</th>
                    <th>Payment Date</th>
                    <th>Payment Receipt</th>
                    <th>Status</th>
                </tr>

                <% for (Payment p : paymentList) { %>

                <tr>
                    <td><%= p.getPaymentId() %></td>

                    <td><%= p.getChildName() %></td>

                    <td><%= p.getPaymentFor() %></td>

                    <td>
                        RM <%= String.format("%.2f", p.getAmount()) %>
                    </td>

                    <td><%= p.getPaymentDate() %></td>

                    <td>
                        <div class="receipt-actions">

                            <a class="receipt-btn"
                               href="<%= p.getReceiptPath() %>"
                               target="_blank">
                                View Receipt
                            </a>

                            <a class="receipt-btn print-btn"
                               href="receipt.jsp?childName=<%= URLEncoder.encode(p.getChildName(), "UTF-8") %>&paymentFor=<%= URLEncoder.encode(p.getPaymentFor(), "UTF-8") %>&amount=<%= String.format("%.2f", p.getAmount()) %>&paymentDate=<%= URLEncoder.encode(String.valueOf(p.getPaymentDate()), "UTF-8") %>"
                               target="_blank">
                                Print Receipt
                            </a>

                        </div>
                    </td>

                    <td>
                        <% if ("Pending".equalsIgnoreCase(p.getStatus())) { %>

                            <span class="status pending">
                                Pending
                            </span>

                        <% } else if ("Paid".equalsIgnoreCase(p.getStatus()) || "Approved".equalsIgnoreCase(p.getStatus())) { %>

                            <span class="status paid">
                                Approved
                            </span>

                        <% } else { %>

                            <span class="status rejected">
                                Rejected
                            </span>

                        <% } %>
                    </td>
                </tr>

                <% } %>

            </table>

        <% } %>

    </div>
</div>

<jsp:include page="footer.jsp" />

</body>
</html>