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
            <li><a href="nav?section=home-button">Home</a></li>
            <li><a href="nav?section=products-button">Products</a></li>
            <li><a href="nav?section=about-button">About</a></li>
            <li>
                <a href="cart.jsp">
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
   	if (selectedProduct == null) {
    	 // The session is empty, redirect to the productDAOServlet
    	 response.sendRedirect("nav?section=products-button");
    	 return;
   	}
%>
<section class = "content">
<div class="back-button" id="back-button"> <a href="nav?section=products-button"><img src="<%= request.getContextPath() %>/website-images/back.png" alt="back"></a> </div>
<div class="container">
    <div id="div1">
    	<div id="images">
	        <div id="thumbnail">
	            <% if (selectedProduct.get("img_thumbnail") != null) { %>
	                <img src="<%= selectedProduct.get("img_thumbnail") %>" class="preview-image" />
	            <% } %>
	        </div>
	        <div id="preview">
			    <% if (selectedProduct.get("img1") != null && !selectedProduct.get("img1").contains("null")) { %>
			        <img src="<%= selectedProduct.get("img1") %>" class="preview-image" />
			    <% } %>
			    <% if (selectedProduct.get("img2") != null && !selectedProduct.get("img2").contains("null")) { %>
			        <img src="<%= selectedProduct.get("img2") %>" class="preview-image" />
			    <% } %>
			    <% if (selectedProduct.get("img3") != null && !selectedProduct.get("img3").contains("null")) { %>
			        <img src="<%= selectedProduct.get("img3") %>" class="preview-image" />
			    <% } %>
			</div>
    	</div>
    </div>
    <div id="div2">
	    <div class="brand" id="product-name"><%= selectedProduct.get("brand") %></div>
	    <div></div>
	    <div class="flavor"><%= selectedProduct.get("name") %></div>
	    <div class="description-header">DESCRIPTION</div>
	    <div class="description">
	        <p id="product-description"><%= selectedProduct.get("description") %></p>
	    </div>
	    <div class="price-header">PRICE</div>
	    <div class="price">₱ <%= selectedProduct.get("price") %></div>
	    <div class="quantity-header">QUANTITY</div>
	    <form>
	        <div class="quantity-input">
	            <button type="button" onclick="decreaseValue()" id="decrease">-</button>
	            <input type="number" class="quantity" id="quantity" value="1" min="1" max="<%= selectedProduct.get("stock") %>"  name="quantity"/>
	            <button type="button" onclick="increaseValue()" id="increase">+</button>
	            <div class="stock">Stock: <%= selectedProduct.get("stock") %></div>
	        </div>
	        <input type="hidden" id="productId" name="productId" value="<%= selectedProduct.get("id") %>">
	        <input id="addtocart-button" type="submit" value="ADD TO CART">
	        <input id="buynow-button" type="submit" value="BUY NOW">
	    </form>
	</div>
</div>
</section>



<script>
//quantity side buttons
function decreaseValue() {
    var value = parseInt(document.getElementById('quantity').value, 10);
    value = isNaN(value) ? 1 : value;
    value--;
    value = value < 1 ? 1 : value;
    document.getElementById('quantity').value = value;
}

function increaseValue() {
    var value = parseInt(document.getElementById('quantity').value, 10);
    var stock = parseInt('<%= selectedProduct.get("stock") %>', 10);
    value = isNaN(value) ? 1 : value;
    if (value < stock) {
        value++;
    }
    document.getElementById('quantity').value = value;
}

document.getElementById('quantity').addEventListener('input', function (e) {
    var input = e.target;
    var max = parseInt(input.max);
    var min = parseInt(input.min);
    var value = parseInt(input.value);

    if (value > max) {
        input.value = max;
    } else if (value < min) {
        input.value = min;
    }
});

//make target of form action dynamic
window.onload = function() {
    var inputs = document.querySelectorAll('input');
    inputs.forEach(function(input) {
        // Exclude the 'ADD TO CART' and 'BUY NOW' buttons
        if (input.id !== 'addtocart-button' && input.id !== 'buynow-button') {
            input.addEventListener('keydown', function(event) {
                if (event.keyCode == 13) {
                    event.preventDefault();
                    input.blur(); // remove focus from the input field
                }
            });
        }
    });

    document.getElementById('addtocart-button').addEventListener('click', function(e) {
        e.preventDefault();
        var form = this.closest('form');
        form.action = 'addtocart';
        form.method = 'POST';
        form.submit();
    });

    document.getElementById('buynow-button').addEventListener('click', function(e) {
        e.preventDefault();
        var form = this.closest('form');
        form.action = 'buynow';
        form.method = 'POST';
        form.submit();
    });
};

document.addEventListener("DOMContentLoaded", function() {
    const navLinks = document.querySelectorAll("header nav ul li a");

    navLinks.forEach(function(link) {
        link.addEventListener("click", function() {

            navLinks.forEach(function(link) {
                link.parentElement.classList.remove("active");
            });

            this.parentElement.classList.add("active");
        });
    });
});
</script>


<%
    String message = (String) session.getAttribute("message");
    if (message != null) {
        session.removeAttribute("message"); // remove the attribute so it doesn't get displayed on every page
%>
        <script>
            alert('<%= message %>');
        </script>
        <% request.removeAttribute("message"); %>
<%
    }
%>
</body>

	
	
	
</body>

</html>