<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/order.css">
</head>
<body>
    <header>
        <h1>KG Ozone</h1>
    </header>
    <nav class="navbar">
        <ul>
            <li><a href="InventoryTry1.html">Inventory</a></li>
            <li><a href="SalesNew1.html">Sales</a></li>
            <li><a href="#services"><u>Orders</u></a></li>
        </ul>
    </nav>
    <div class="content">
        <div class="Title">
            <h1>Orders</h1>
        </div>
        <hr>
            <nav class="navbar2">
        <ul>
            <li><a href=""><u>All</u></a></li>
            <li><a href="OrdersNew2.html">Pending</a></li>
            <li><a href="OrdersNew3.html">Shipped</a></li>
            <li><a href="OrdersNew4.html">Trash</a></li>
        </ul>
            </nav>
            <div class="SalesMenu">
                <div class="word">Status</div>
                  <div class="word">Date</div>
                  <div class="word">Customer</div>
                  <div class="word">Products</div>
                  <div class="word">Total</div>
                </div>
            <hr>  
            <div class="SalesStats">
                  <div class="weeksale">Pending</div>
                  <div class="weeksale">01/04/24</div>
                  <div class="weeksale">Name</div>
                  <div class="weeksale">ProductX</div>
                  <div class="weeksale">Total</div>
            </div>
    </div>
   	</body>
</html>