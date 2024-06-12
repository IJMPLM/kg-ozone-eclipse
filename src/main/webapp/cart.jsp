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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/cart.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/header.css">
    <title>KG Ozone</title>
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
<div class="content">
	<div class="back-button" id="back-button" onclick="history.back()"><img src="<%= request.getContextPath() %>/website-images/back.png" alt="back"></div>
	<%
		request.getSession();
	    HashMap<String, Integer> orderMap = (HashMap<String, Integer>) session.getAttribute("orderMap");
	    ArrayList<HashMap<String, String>> productList = (ArrayList<HashMap<String, String>>) session.getAttribute("productList");
	    if (productList == null) {
            // The session is empty, redirect to the productDAOServlet
            response.sendRedirect("productList");
            return;
        }
	
	    // Debug print statements
	    System.out.println("Order Session: " + orderMap);
	    System.out.println("Product List: " + productList);
	%>
	
	<div class="cart-checkout">
	    <div id="cart-checkout-products">
	        <%
			    // Initialize total amount
			    double totalAmount = 0;
			
			    if (productList != null && orderMap != null) {
			        for (HashMap<String, String> product : productList) {
			            String productId = product.get("id");
			            if (orderMap.containsKey(productId)) {
			                // Get the quantity from the orderMap
			                int quantity = orderMap.get(productId);
			                // Calculate the total price for this product and add it to the total amount
			                double price = Double.parseDouble(product.get("price"));
			                totalAmount += price * quantity;
			%>
			                <div class="cart-checkouts-products-rectangle">
			                    <div class="cart-checkouts-products-picture">
			                        <img src="<%= product.get("img_thumbnail") %>" alt="Product image">
			                    </div>
			                    <div class="product-info">
			                        <h1 class="brand-name"><%= product.get("brand") %></h1>
			                        <h3 class="flavor-name"><%= product.get("name") %></h3>
			                        <h4 class="price-name">Php <%= price %> Qty: <%= quantity %> </h4>
			                        <%
				                        out.println("<form action='deleteFromCart' method='post'>");
						                out.println("<input type='hidden' name='productId' value='" + product.get("id") + "'>");
										out.println("<input class='delete-button' type='submit' value='Delete' onclick='return confirm(\"Are you sure you want to delete this product?\")'>");
						                out.println("</form>");
			                        %>
			                    </div>
			                </div>
			<%
			            }
			        }
			    }
			%>
	    </div>
</div>
</div>

<form action="checkout" method="post">
    <footer id="checkout-footer">
        <div class="left-section">
        </div>
        <div class="right-section">
            <h3>Total Amount:</h3>
            <h3 class="total-amount">Php <%= totalAmount %></h3>
            <div id="checkout-rec"><button type="submit">CHECK OUT</button></div>
        </div>
    </footer>
</form>
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
<script>
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
	
</body>
</html>