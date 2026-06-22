<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.lcms.dao.PaymentDAO"%>

<%
    PaymentDAO dao = new PaymentDAO();
    double revenue = dao.getMonthlyRevenue();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Monthly Revenue</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .revenue-card {
            background: white;
            max-width: 500px;
            width: 100%;
            margin: 0 auto;
            border: 6px solid #4caf50;
            border-radius: 40px;
            padding: 40px;
            text-align: center;
            box-shadow: 12px 12px 0px #2e7d32;
        }
        .revenue-card h1 {
            color: #2e7d32;
            margin: 0 0 10px;
        }
        .revenue-card h2 {
            color: #1b5e20;
            font-size: 2.5rem;
            margin: 0;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="main-content">
        <div class="revenue-card">
            <h1>Monthly Revenue</h1>
            <h2>RM <%= String.format("%.2f", revenue) %></h2>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>
