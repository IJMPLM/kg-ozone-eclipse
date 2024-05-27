<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/sales.css">
</head>
<body>
    <header>
        <h1>KG Ozone</h1>
    </header>
    <nav class="navbar">
        <ul>
            <li><a href="InventoryTry1.html">Inventory</a></li>
            <li><a href="SalesNew1.html"><u>Sales</u></a></li>
            <li><a href="OrdersNew1.html">Orders</a></li>
        </ul>
    </nav>
    <div class="content">
        <div class="Title">
            <h1>Sales</h1>
        </div>
        <hr>
            <nav class="navbar2">
        <ul>
            <li><a href=""><u>Weekly</u></a></li>
            <li><a href="SalesNew2.html">Monthly</a></li>
            <li><a href="SalesNew3.html">All</a></li>
        </ul>
            </nav>
            <div class="SalesMenu">
                <div class="word">Day</div>
                <div class="word">Date</div>
                  <div class="word">Product</div>
                  <div class="word">Price</div>
                  <div class="word">QTY</div>
                  <div class="word">Total</div>
                </div>
            <hr>  
            <div class="SalesStats">
                    <div class="weeksale">M</div>
                    <div class="weeksale">01/04/24</div>
                  <div class="weeksale">Product</div>
                  <div class="weeksale">Price</div>
                  <div class="weeksale">10</div>
                  <div class="weeksale">Total</div>
            </div>
    </div>
    </body>
</html>