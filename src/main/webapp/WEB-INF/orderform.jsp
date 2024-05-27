<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<div class="content">
	<div id="left">
	        <div class="form-text">name</div>
	        <input class="type-name" type="text" style="width: 1000px;" placeholder="Enter Name..."/>
	        <div class="form-text">contact</div>
	        <input class="type-contact" type="text" style="width: 1000px;" placeholder="Enter Contact Number..."/>
	        <div class="form-text">valid id</div>
			<input type="file" name="validId" id="validId" class="input-file" />
			<label for="validId" class="file-label" id="file-label">Choose a file</label>
				<div class="space">
	        <div class="form-text">ADDRESS</div>
	        <input class="type-address" type="text" style="width: 1000px;" placeholder="Enter Address..."/>
	        <div class="form-text">REGION</div>
	        <input class="type-region" type="text" style="width: 1000px;" placeholder="Enter Region..."/>
	        <div class="form-text">BARANGAY</div>
	        <input class="type-barangay" type="text" style="width: 1000px;" placeholder="Enter Barangay..."/>
	        <div class="form-text">PAYMENT RECEIPT</div>

			<input type="file" name="receipt" id="receipt" class="input-file" />
			<label for="receipt" class="file-label" id="receipt-label">Choose a file</label>

	        <div class="form-text">COURIER</div>
			<select name="courier" id="courier">
				<option value="volvo">J&T Express</option>
				<option value="saab">Ninja Van</option>
				<option value="opel">Entrego</option>
				<option value="audi">Lalamove</option>
			  </select>
				</div>
	</div>
	<%
	    request.getSession();
	    HashMap<String, Integer> orderMap = (HashMap<String, Integer>) session.getAttribute("orderMap");
	    ArrayList<HashMap<String, String>> productList = (ArrayList<HashMap<String, String>>) session.getAttribute("productList");
	%>
	<div id="right">
	    <%
	        if (productList != null && orderMap != null) {
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
        %>
    </div>
</div>
<script>
				// Function to update label text for both inputs
				function updateLabel(inputId, labelId) {
					const inputFile = document.getElementById(inputId);
					const fileLabel = document.getElementById(labelId);
			
					if (inputFile.files.length > 0) {
						fileLabel.textContent = inputFile.files[0].name;
					} else {
						fileLabel.textContent = 'Choose a file';
					}
				}
			
				// Update label for 'validId' input
				document.getElementById('validId').addEventListener('change', function () {
					updateLabel('validId', 'file-label');
				});
			
				// Update label for 'receipt' input
				document.getElementById('receipt').addEventListener('change', function () {
					updateLabel('receipt', 'receipt-label');
				});
			
				// Ensure the "Choose a file" label shows initially
				document.addEventListener('DOMContentLoaded', function () {
					updateLabel('validId', 'file-label');
					updateLabel('receipt', 'receipt-label');
				});
			</script>
</body>
</html>