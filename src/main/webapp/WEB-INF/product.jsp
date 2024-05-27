<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>KG Ozone</title>
    
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/website-images/logo-icon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/product.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/header.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Julius+Sans+One&family=Kufam:ital,wght@0,400..900;1,400..900&family=Rozha+One&display=swap" rel="stylesheet"> 
</head>
<body>
<header>
	<div id="logo-button">
        <img src="<%= request.getContextPath() %>/website-images/logo.png" alt="Logo">
    </div>
    <input type="checkbox" id="nav_check" hidden>
    <nav>
        <ul>
            <li><a href="productList" class="active">Home</a></li>
            <li><a href="#" onclick="history.back()">Products</a></li>
            <li><a href="#" onclick="history.back()">About</a></li>
            <li>
                <a href="#search-button">
                    <div class="Search"><img src="<%= request.getContextPath() %>/website-images/search.png" alt="search"></div>
                </a>
            </li>
            <li>
                <a href="#cart-button">
                    <div class="Cart"><img src="<%= request.getContextPath() %>/website-images/cart.png" alt="cart"></div>
                </a>
            </li>
            <li>
                <a href="login">
                    <div class="User"><img src="<%= request.getContextPath() %>/website-images/user.png" alt="User"></div>
                </a>
            </li>
        </ul>
    </nav>
    <label for="nav_check" class="hamburger">
        <div></div>
        <div></div>
        <div></div>
    </label>
	</header>

<!-- CHECKOUT -->
<%
	HashMap<String, String> selectedProduct = (HashMap<String, String>) request.getAttribute("selectedProduct"); 
%>
<section class = "content">
<div class="back-button" id="back-button" onclick="history.back()"> <img src="<%= request.getContextPath() %>/website-images/back.png" alt="back"></div>
<div class="container">
    <div id="div1">
    	<div id="images">
	        <div id="thumbnail">
	            <% if (selectedProduct.get("img_thumbnail") != null) { %>
	                <img src="<%= selectedProduct.get("img_thumbnail") %>" class="preview-image" />
	            <% } %>
	        </div>
	        <div id="preview">
	            <% if (selectedProduct.get("img1") != null) { %>
	                <img src="<%= selectedProduct.get("img1") %>" class="preview-image" />
	            <% } %>
	            <% if (selectedProduct.get("img2") != null) { %>
	                <img src="<%= selectedProduct.get("img2") %>" class="preview-image" />
	            <% } %>
	            <% if (selectedProduct.get("img3") != null) { %>
	                <img src="<%= selectedProduct.get("img3") %>" class="preview-image" />
	            <% } %>
	        </div>
    	</div>
    </div>
    <div id="div2">
				<div class="brand" id="product-name">Black Elite</div>
				<div></div>
				<div class="flavor">Bazook Gum</div>
				<div class="description-header">DESCRIPTION</div>
				<div class="description">
					<p id="product-description">The Black Elite is a premium
					e-liquid that offers a rich and satisfying vaping experience. It
					has a bold and intense flavor that is perfect for those who enjoy a
					strong and robust vape. The Black Elite is made with high-quality
					ingredients and is designed to provide a smooth and satisfying vape
					every time. It is available in a variety of nicotine strengths to
					suit your individual preferences. Try the Black Elite today and
					experience the ultimate vaping pleasure.</p>
				</div>
				<div class="price-header">PRICE</div>
				<div class="price">₱ 100.00</div>
				<div class="quantity-header">QUANTITY</div>
				<form>
					<div class="quantity-input">
				    <button type="button" onclick="decreaseValue()" id="decrease">-</button>
				    <input type="number" class="quantity" id="quantity" value="1" min="1"/>
				    <button type="button" onclick="increaseValue()" id="increase">+</button>
				    <div class="stock">Stock: 1</div>
				</div>
					<input id="addtocart-button" type="submit" value="ADD TO CART">
					<input id="buynow-button" type="submit" value="BUY NOW">
				</form>
			</div>
</div>
</section>



<script>
function decreaseValue() {
    var value = parseInt(document.getElementById('quantity').value, 10);
    value = isNaN(value) ? 1 : value;
    value--;
    value = value < 1 ? 1 : value;
    document.getElementById('quantity').value = value;
}

function increaseValue() {
    var value = parseInt(document.getElementById('quantity').value, 10);
    value = isNaN(value) ? 1 : value;
    value++;
    document.getElementById('quantity').value = value;
}
</script>
</body>

	
	
	
</body>

</html>