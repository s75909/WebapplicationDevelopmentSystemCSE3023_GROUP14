<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.lcms.dao.PaymentDAO"%>
<%@page import="com.lcms.model.Payment"%>
<%@page import="java.util.List"%>

<%
    if (!"manager".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp?error=admin_only");
        return;
    }

    PaymentDAO dao = new PaymentDAO();
    List<Payment> list = dao.getAllPayments();

    double totalRevenue = 0;

    for (Payment p : list) {
        if ("Paid".equals(p.getStatus())) {
            totalRevenue += p.getAmount();
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Financial Overview</title>
        <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">

        <style>
            body{
                margin:0;
                padding:0;
                background:#184d47;
                font-family:'Quicksand',sans-serif;
            }

            .main-container{
                max-width:1150px;
                margin:40px auto;
            }

            .overview-box{
                background:#81d4fa;
                border:4px solid #4caf50;
                border-radius:30px;
                padding:25px 35px;
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:30px;
                box-shadow:6px 6px 0px #2e7d32;
            }

            .overview-left h2{
                margin:0;
                color:#1b5e20;
                font-size:30px;
            }

            .overview-left p{
                margin-top:10px;
                color:#444;
                font-size:18px;
            }

            .overview-right{
                background:white;
                padding:18px 30px;
                border-radius:20px;
                text-align:center;
                border:3px solid #90caf9;
            }

            .overview-right small{
                color:#666;
                font-size:14px;
            }

            .overview-right h1{
                margin:8px 0 0 0;
                color:#2e7d32;
                font-size:34px;
            }

            .table-container{
                background:white;
                border:5px solid #4caf50;
                border-radius:35px;
                padding:30px;
                box-shadow:8px 8px 0px #2e7d32;
            }

            table{
                width:100%;
                border-collapse:collapse;
            }

            th{
                padding:15px;
                text-align:left;
                color:#2e7d32;
                font-size:15px;
                border-bottom:3px solid #a5d6a7;
            }

            td{
                padding:15px;
                border-bottom:1px solid #eee;
                font-size:14px;
                vertical-align:middle;
            }

            tr:hover{
                background:#f9fff4;
            }

            .paid, .pending, .rejected{
                color:white;
                padding:8px 18px;
                border-radius:20px;
                font-size:13px;
                font-weight:bold;
                display:inline-block;
            }

            .paid{
                background:#66bb6a;
            }
            .pending{
                background:#ff7043;
            }
            .rejected{
                background:#d32f2f;
            }

            .btn-group{
                margin-top:30px;
                display:flex;
                gap:15px;
                flex-wrap:wrap;
            }

            .btn-export, .btn-print, .btn-verify{
                color:white;
                border:none;
                padding:14px 25px;
                border-radius:15px;
                cursor:pointer;
                font-weight:bold;
                font-size:15px;
                text-decoration:none;
                display:inline-block;
                font-family:'Quicksand',sans-serif;
            }

            .btn-export{
                background:#fbc02d;
            }
            .btn-print{
                background:#43a047;
            }
            .btn-verify{
                background:#1976d2;
            }

            .btn-export:hover{
                background:#f9a825;
            }
            .btn-print:hover{
                background:#2e7d32;
            }
            .btn-verify:hover{
                background:#0d47a1;
            }

            .action-box{
                display:flex;
                align-items:center;
                gap:8px;
                flex-wrap:nowrap;
            }

            .inline-form{
                display:flex;
                align-items:center;
                gap:6px;
                margin:0;
            }

            .status-select{
                padding:8px 10px;
                border:2px solid #4caf50;
                border-radius:10px;
                font-family:'Quicksand',sans-serif;
                font-weight:bold;
                background:white;
            }

            .btn-update, .btn-delete{
                color:white;
                border:none;
                padding:8px 12px;
                border-radius:10px;
                cursor:pointer;
                font-weight:bold;
                font-family:'Quicksand',sans-serif;
            }

            .btn-update{
                background:#1565c0;
            }
            .btn-delete{
                background:#d32f2f;
            }

            .btn-update:hover{
                background:#0d47a1;
            }
            .btn-delete:hover{
                background:#b71c1c;
            }

            .empty-msg{
                text-align:center;
                color:#777;
                padding:30px;
                font-size:16px;
            }

         @media print {
    .navbar,
    .nav-links,
    .nav-user-area,
    .btn-group,
    .action-column,
    footer {
        display: none !important;
    }

    body {
        background: white !important;
        padding: 0 !important;
        margin: 0 !important;
    }

    .main-container {
        margin: 0 auto !important;
        max-width: 100% !important;
    }

    .overview-box,
    .table-container {
        box-shadow: none !important;
    }
}
        </style>
    </head>

    <body>

        <%@ include file="header.jsp" %>

        <div class="main-container">

            <div class="overview-box">
                <div class="overview-left">
                    <h2>💰 Financial Overview (Monthly)</h2>
                    <p>Monthly Revenue Tracking</p>
                </div>

                <div class="overview-right">
                    <small>Total Revenue</small>
                    <h1>RM <%= String.format("%.2f", totalRevenue)%></h1>
                </div>
            </div>

            <div class="table-container">
                <table>
                    <tr>
                        <th>Child Name</th>
                        <th>Payment ID</th>
                        <th>Description</th>
                        <th>Amount (RM)</th>
                        <th>Status</th>
                        <th class="action-column">Actions</th>
                    </tr>

                    <% if (list == null || list.isEmpty()) { %>
                    <tr>
                        <td colspan="6" class="empty-msg">
                            No payment records found.
                        </td>
                    </tr>
                    <% } else { %>

                    <% for (Payment p : list) {%>
                    <tr>
                        <td><%= p.getChildName()%></td>
                        <td>PAY-<%= p.getPaymentId()%></td>
                        <td><%= p.getPaymentFor()%></td>
                        <td>RM <%= String.format("%.2f", p.getAmount())%></td>

                        <td>
                            <%
                                String badgeClass = "pending";

                                if ("Paid".equals(p.getStatus())) {
                                    badgeClass = "paid";
                                } else if ("Rejected".equals(p.getStatus())) {
                                    badgeClass = "rejected";
                                }
                            %>

                            <span class="<%= badgeClass%>">
                                <%= p.getStatus()%>
                            </span>
                        </td>

                        <td class="action-column">
                            <div class="action-box">

                                <form action="${pageContext.request.contextPath}/PaymentCRUDServlet"
                                      method="post"
                                      class="inline-form">

                                    <input type="hidden" name="action" value="updateStatus">
                                    <input type="hidden" name="paymentId" value="<%= p.getPaymentId()%>">

                                    <select name="status" class="status-select">
                                        <option value="Pending" <%= "Pending".equals(p.getStatus()) ? "selected" : ""%>>Pending</option>
                                        <option value="Paid" <%= "Paid".equals(p.getStatus()) ? "selected" : ""%>>Paid</option>
                                        <option value="Rejected" <%= "Rejected".equals(p.getStatus()) ? "selected" : ""%>>Rejected</option>
                                    </select>

                                    <button type="submit" class="btn-update">Update</button>
                                </form>

                                <form action="${pageContext.request.contextPath}/PaymentCRUDServlet"
                                      method="post"
                                      class="inline-form"
                                      onsubmit="return confirm('Are you sure you want to delete this payment record?');">

                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="paymentId" value="<%= p.getPaymentId()%>">

                                    <button type="submit" class="btn-delete">Delete</button>
                                </form>

                            </div>
                        </td>
                    </tr>
                    <% } %>

                    <% }%>
                </table>

                <div class="btn-group">
                 <a class="btn-export" href="<%= request.getContextPath() %>/ExportPaymentExcelServlet">
    Export to Excel 📊
</a>
                    <button class="btn-print" onclick="window.print()">
                        Print PDF 🖨
                    </button>

                    <a href="paymentVerification.jsp" class="btn-verify">
                        Open Verification Dashboard
                    </a>
                </div>
            </div>

        </div>

        <%@ include file="footer.jsp" %>

    </body>
</html>