<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String childName = request.getParameter("childName");
    String paymentFor = request.getParameter("paymentFor");
    String amount = request.getParameter("amount");
    String paymentDate = request.getParameter("paymentDate");

    if (childName == null) {
        childName = "Muhammad Ikhwan";
    }
    if (paymentFor == null) {
        paymentFor = "Monthly Educational Fee";
    }
    if (amount == null) {
        amount = "480.00";
    }
    if (paymentDate == null)
        paymentDate = "14 April 2026";
%>

<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Official Receipt</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">

        <style>

            body{
                margin:0;
                padding:30px;
                background:#eef3e5;
                font-family:'Poppins',sans-serif;
            }

            .receipt-wrapper{
                width:100%;
                max-width:800px;
                margin:0 auto;
                background:#fdfdfd;
                padding:45px;
                border-radius:10px;
                box-shadow:0px 8px 20px rgba(0,0,0,0.25);
                box-sizing:border-box;
                overflow:hidden;
            }

            .top-section{
                display:flex;
                justify-content:space-between;
                align-items:flex-start;
                margin-bottom:40px;
                gap:20px;
            }

            .title-left{
                color:#1e3a8a;
                flex:1;
            }

            .title-left h2{
                margin:0;
                font-size:22px;
                font-weight:700;
            }

            .title-right{
                text-align:right;
                color:#444;
                flex:1;
            }

            .title-right h3{
                margin:0;
                font-size:24px;
                white-space:nowrap;
            }

            .info-section{
                display:grid;
                grid-template-columns:1fr 1fr;
                gap:35px;
                margin-bottom:35px;
            }

            .info-box{
                width:100%;
            }

            .label{
                font-size:12px;
                color:#555;
                font-weight:700;
                margin-bottom:5px;
                text-transform:uppercase;
            }

            .value{
                font-size:16px;
                color:#222;
                margin-bottom:20px;
            }

            table{
                width:100%;
                border-collapse:collapse;
                margin-top:20px;
                table-layout:fixed;
            }

            table th{
                text-align:left;
                padding:15px 10px;
                border-bottom:2px solid #ddd;
                color:#555;
                font-size:14px;
            }

            table th:last-child,
            table td:last-child{
                width:180px;
                text-align:right;
            }

            table td{
                padding:18px 10px;
                border-bottom:1px solid #eee;
                font-size:15px;
                word-wrap:break-word;
            }

            .total-section{
                margin-top:35px;
                display:flex;
                justify-content:space-between;
                align-items:center;
                gap:20px;
            }

            .total-title{
                font-size:22px;
                font-weight:700;
                color:#222;
            }

            .total-amount{
                font-size:24px;
                font-weight:bold;
                color:#1e40af;
                text-align:right;
                white-space:nowrap;
            }

            .print-btn{
                margin-top:40px;
                float:right;
                background:#1d4ed8;
                color:white;
                border:none;
                padding:14px 28px;
                border-radius:6px;
                cursor:pointer;
                font-size:15px;
                font-weight:600;
            }

            .print-btn:hover{
                background:#1e3a8a;
            }

            @media print{
                @page{
                    size:A4;
                    margin:12mm;
                }

                html, body{
                    width:100%;
                    margin:0;
                    padding:0;
                    background:white;
                }

                .receipt-wrapper{
                    width:100%;
                    max-width:100%;
                    margin:0;
                    padding:25px;
                    box-shadow:none;
                    border-radius:0;
                    box-sizing:border-box;
                }

                .print-btn{
                    display:none;
                }
            }

            @page{
                size:A4;
                margin:12mm;
            }
            th:last-child,
            td:last-child{
                width:180px;
                text-align:right;
            }


        </style>

    </head>

    <body>



        <div class="main-content">
            <div class="receipt-wrapper">

                <div class="top-section">

                    <div class="title-left">
                        <h2>TASKA PERMATA KELUARGA</h2>
                    </div>

                    <div class="title-right">
                        <h3>OFFICIAL RECEIPT</h3>
                    </div>

                </div>


                <div class="info-section">

                    <div class="info-box">

                        <div class="label">Receipt Number</div>
                        <div class="value">REC/2026/0842</div>

                        <div class="label">Payer Account</div>
                        <div class="value">ACC-76216 (<%= childName%>)</div>

                    </div>


                    <div class="info-box">

                        <div class="label">Date of Issue</div>
                        <div class="value"><%= paymentDate%></div>

                        <div class="label">Payment Mode</div>
                        <div class="value">Online Banking (FPX)</div>

                    </div>

                </div>


                <table>

                    <thead>
                        <tr>
                            <th>DESCRIPTION OF SERVICES</th>
                            <th>AMOUNT (RM)</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td><%= paymentFor%></td>
                            <td>RM <%= amount%></td>
                        </tr>
                    </tbody>

                </table>


                <div class="total-section">

                    <div class="total-title">
                        TOTAL AMOUNT PAID
                    </div>

                    <div class="total-amount">
                        RM <%= amount%>
                    </div>

                </div>


                <button class="print-btn" onclick="window.print()">
                    Print Official Record
                </button>

            </div>
        </div>



    </body>
</html>