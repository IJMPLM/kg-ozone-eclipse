<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/website-images/logo-icon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/orderform.css">
    <title>Checkout</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Julius+Sans+One&family=Kufam:ital,wght@0,400..900;1,400..900&family=Rozha+One&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Rozha+One:wght@400&display=swap"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Judson:wght@400&display=swap"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Rubik:wght@300&display=swap"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Kufam:wght@400;600&display=swap"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Julius+Sans+One:wght@400&display=swap"/>
</head>
<body>
    <%
        request.getSession();
        HashMap<String, Integer> buyNowProduct = (HashMap<String, Integer>) session.getAttribute("buyNowProduct");
        HashMap<String, Integer> orderMap = (HashMap<String, Integer>) session.getAttribute("orderMap");
        ArrayList<HashMap<String, String>> productList = (ArrayList<HashMap<String, String>>) session.getAttribute("productList");
    %>
    <%
	    // Initialize total amount
	    double totalAmount = 0;
	
	    if (productList != null) {
	        if (buyNowProduct != null) {
	            // Calculate total for the "Buy Now" product
	            String productId = buyNowProduct.keySet().iterator().next();
	            int quantity = buyNowProduct.get(productId);
	            for (HashMap<String, String> product : productList) {
	                if (product.get("id").equals(productId)) {
	                    double price = Double.parseDouble(product.get("price"));
	                    totalAmount += price * quantity;
	                }
	            }
	        } else if (orderMap != null) {
	            // Calculate total for all products in the orderMap
	            for (HashMap<String, String> product : productList) {
	                String productId = product.get("id");
	                if (orderMap.containsKey(productId)) {
	                    int quantity = orderMap.get(productId);
	                    double price = Double.parseDouble(product.get("price"));
	                    totalAmount += price * quantity;
	                }
	            }
	        }
	    }
	%>
	<div class="back-button" id="back-button" onclick="history.back()"><img src="<%= request.getContextPath() %>/website-images/back.png" alt="back"></div>
	<div class="content">
    <div id="left">
    <form id="orderForm" action="createorder" method="post" enctype="multipart/form-data">
        <%
            if (productList != null) {
                if (buyNowProduct != null) {
                    // Create hidden inputs for the "Buy Now" product
                    String productId = buyNowProduct.keySet().iterator().next();
                    int quantity = buyNowProduct.get(productId);
        %>
                    <input type="hidden" name="productId" value="<%= productId %>">
                    <input type="hidden" name="quantity" value="<%= quantity %>">
        <%
                } else if (orderMap != null) {
                    // Create hidden inputs for all products in the orderMap
                    for (HashMap<String, String> product : productList) {
                        String productId = product.get("id");
                        if (orderMap.containsKey(productId)) {
                            int quantity = orderMap.get(productId);
        %>
                            <input type="hidden" name="productId" value="<%= productId %>">
                            <input type="hidden" name="quantity" value="<%= quantity %>">
        <%
                        }
                    }
                }
            }
        %>
            <div class="form-text">Name</div>
            <input class="type-name" type="text" name="name" style="width: 1000px;" placeholder="Enter Name..." required/>
            <div class="form-text">Contact</div>
            <input class="type-contact" type="text" name="contact" style="width: 1000px;" placeholder="Enter Contact Number..." required/>
            <div class="form-text">Valid ID</div>
            <input type="file" name="validId" id="validId" class="input-file" required />
            <label for="validId" class="file-label" id="file-label">Choose a file</label>
            <div class="space"><br><br>
                <div class="form-text">REGION</div>
                <select name="region" id="region" onchange="updateCities()" required>
                    <option value="">Select a region</option>
                    <option value="NCR">NCR</option>
                    <option value="Region I">Region I</option>
                    <option value="Region II">Region II</option>
                    <option value="Region III">Region III</option>
                    <option value="Region IV-A">Region IV‑A</option>
                    <option value="MIMAROPA">MIMAROPA</option>
                    <option value="Region V">Region V</option>
                    <option value="Region VI">Region VI</option>
                    <option value="Region VII">Region VII</option>
                    <option value="Region VIII">Region VIII</option>
                    <option value="Region IX">Region IX</option>
                    <option value="Region X">Region X</option>
                    <option value="Region XI">Region XI</option>
                    <option value="Region XII">Region XII</option>
                    <option value="Region XIII">Region XIII</option>
                    <option value="CAR">CAR</option>
                    <option value="BARMM">BARMM</option>
                </select>

                <div class="form-text">CITY</div>
                <select name="barangay" id="city" required>
                    <option value="">Select a city</option>
                </select>
               
               
                <div class="form-text">BARANGAY, LOT NUMBER, AND STREET NAME</div>
                <input class="type-lot-and-street" type="text" name="address" style="width: 1000px;" placeholder="Enter Barangay Name, Lot No., and Street Name..." required/>
               
               
               
                <div class="form-text">PAYMENT RECEIPT</div>
                <input type="file" name="receipt" id="receipt" class="input-file" required />
                <label for="receipt" class="file-label" id="receipt-label">Choose a file</label>
                <div class="form-text">COURIER</div>
                <select name="courier" id="courier" required>
                    <option value="J&T Express">J&T Express</option>
                    <option value="Ninja Van">Ninja Van</option>
                    <option value="Entrego">Entrego</option>
                    <option value="Lalamove">Lalamove</option>
                </select>
            </div>
            <div id="lower">
                <div class="price">PHP <%= totalAmount %></div>
                <div class="total">TOTAL</div>
                <button id="complete" type="submit" class="popup-complete-order">Complete Order</button><br><br>
            </div>
        </form>
    </div>
    <div id="right">
        <%
            if (productList != null) {
                if (buyNowProduct != null) {
                    // Display the "Buy Now" product
                    String productId = buyNowProduct.keySet().iterator().next();
                    int quantity = buyNowProduct.get(productId);
                    for (HashMap<String, String> product : productList) {
                        if (product.get("id").equals(productId)) {
        %>
                            <div class="product">
                                <img src="<%= product.get("img_thumbnail") %>" alt="Product image">
                                <div class="product-info">
                                    <div class="product-text"><%= product.get("brand") %></div>
                                    <div class="product-text"><%= product.get("name") %></div>
                                    <br><br>
                                    <div class="product-text">Quantity: <%= quantity %></div>
                                    <div class="product-text">Price: <%= product.get("price") %></div>
                                </div>
                            </div>
        <%
                        }
                    }
                } else if (orderMap != null) {
                    // Display all products in the orderMap
                    for (HashMap<String, String> product : productList) {
                        String productId = product.get("id");
                        if (orderMap.containsKey(productId)) {
                            int quantity = orderMap.get(productId);
        %>
                            <div class="product">
                                <img src="<%= product.get("img_thumbnail") %>" alt="Product image">
                                <div class="product-info">
                                    <div class="product-text"><%= product.get("brand") %></div>
                                    <div class="product-text"><%= product.get("name") %></div>
                                    <br><br>
                                    <div class="product-text">Quantity: <%= quantity %></div>
                                    <div class="product-text">Price: <%= product.get("price") %></div>
                                </div>
                            </div>
        <%
                        }
                    }
                }
            }
        %>
    </div>
</div>
    <script src="<%= request.getContextPath() %>/stylesheets/orderform.js"></script>
</body>
</html>