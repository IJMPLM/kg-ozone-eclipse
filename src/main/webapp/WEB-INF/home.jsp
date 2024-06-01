<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	@SuppressWarnings("unchecked")
    ArrayList<HashMap<String, String>> productList = (ArrayList<HashMap<String, String>>) session.getAttribute("productList");
	if (productList == null) {
	    // The session is empty, redirect to the productDAOServlet
	    response.sendRedirect("productDAOServlet");
	    return;
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>KG Ozone</title>
    
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/website-images/logo-icon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/home.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/header.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/home-products.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/about.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Julius+Sans+One&family=Kufam:ital,wght@0,400..900;1,400..900&family=Rozha+One&display=swap" rel="stylesheet"> 
</head>
<body>
	<% if (request.getAttribute("orderSuccess") != null) { %>
	    <script>
	        alert("<%= request.getAttribute("orderSuccess") %>");
	    </script>
	    <% request.removeAttribute("orderSuccess"); %>
	<% } %>
	<header>
	<div id="logo-button">
        <img src="<%= request.getContextPath() %>/website-images/logo.png" alt="Logo">
    </div>
    <input type="checkbox" id="nav_check" hidden>
    <nav>
        <ul>
            <li><a href="#home-button" class="active">Home</a></li>
            <li><a href="#products-button">Products</a></li>
            <li><a href="#about-button">About</a></li>
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
	
	<section class="Home" id="home-button">
    <div class="content">
        <h1>KG Ozone</h1>
        <h3>Vape Store</h3>
        <h5>Affordable Clouds, Boundless Happiness</h5>
    </div>
</section>

<%
    // Step 1: Create a HashMap where the key is the category and the value is an ArrayList of products in that category.
    HashMap<String, ArrayList<HashMap<String, String>>> categorizedProducts = new HashMap<>();

    // Step 2: Iterate over the productList and for each product, get its category and add it to the corresponding ArrayList in the HashMap.
    for (HashMap<String, String> product : productList) {
        String brand = product.get("brand");
        ArrayList<HashMap<String, String>> productsInBrand = categorizedProducts.getOrDefault(brand, new ArrayList<>());
        productsInBrand.add(product);
        categorizedProducts.put(brand, productsInBrand);
    }
%>

<section class="Products" id="products-button">
    <div class="content">
        <%
        int size = categorizedProducts.size();
        int counter = 1;
            // Step 3: Iterate over the HashMap and for each category, get the ArrayList of products and display the first three products.
            for (Map.Entry<String, ArrayList<HashMap<String, String>>> entry : categorizedProducts.entrySet()) {
                String brand = entry.getKey();
                ArrayList<HashMap<String, String>> productsInBrand = entry.getValue();
				
                	out.println("<div class = 'product-section'>");
	                out.println("<h1>" + brand + "</h1>");
					out.println("<br><a href='expand?brand=" + brand + "'><h1 id ='brand-expand'>View All</h1></a>");
	                out.println("<div class='product-list' id = '"+brand+"'>");

                for (int i = 0; i < Math.min(3, productsInBrand.size()); i++) {
                    HashMap<String, String> product = productsInBrand.get(i);
                    out.println("<div class='product-item'>");
	                    out.println("<a href='product?id=" + product.get("id") + "'>");
		                    out.println("<img src='" + product.get("img_thumbnail") + "' alt='" + product.get("name") + "'>");
		                    out.println("<div class='flavor'>" + product.get("name") + "</div>");
		                out.println("</a>");
                    out.println("</div>");
                }
				
                	out.println("</div>");
                out.println("</div>");
                
                if (counter < size) {
                    out.println("<hr>");
                    counter++;
                }
            }
        %>
    </div>
</section>

<section class="About" id="about-button">
    <div class="content">
        <div id="about-center">
            <h6 id="faq">FAQ</h6>
            <p id="quest">
                ● Do we accept COD? Yes, we are accepting COD<br>
                ● Do we ship nationwide? Yes, to any part of the Philippines.<br>
                ● Do we accept returned items? No, if the seal is broken<br>
            </p>
            <h5>About Us</h5>
            <p id="about">
                Welcome to KG Ozone, your go-to for affordable, top-notch vape gear. We're all about quality without the hefty price tag. Plus, we're serious <br>about responsible vaping. We only sell to adults 21 and up, ensuring a safe and legal experience for all. Join us for premium vaping solutions<br> that won't disappoint. Experience excellence, affordability, and responsibility with KG Ozone.
            </p>
            <h6 id="first">Contact Us</h6>
            <div class="icon-container">
                <div class="icon-wrapper">
                    <a href="https://www.facebook.com/johnandrei.reyes.1/" target="_blank"><img src="<%= request.getContextPath() %>/website-images/ig.png"></a>
                </div>
                <div class="icon-wrapper">
                    <a href="https://www.instagram.com/_j.dreiii/" target="_blank"><img src="<%= request.getContextPath() %>/website-images/gmail.png"></a>
                </div>
                <div class="icon-wrapper">
                    <a href="https://www.youtube.com/@johnandreireyes2035" target="_blank"><img src="<%= request.getContextPath() %>/website-images/fb.png"></a>
                </div>
                <div class="icon-wrapper">
                    <a href="https://www.youtube.com/@johnandreireyes2035" target="_blank"><img src="<%= request.getContextPath() %>/website-images/tiktok.png"></a>
                </div>
            </div>
            <br><h6 id="last">OZONE ©2024 Made by US THANK YOU</h6>
        </div>
    </div>
</section>
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
        window.onload = function() {
            var section = '<%= request.getAttribute("section") %>';
            if (section && section !== 'null') {
                var element = document.getElementById(section);
                if (element) {
                    element.scrollIntoView();
                }
            }
        };
    </script>
</body>
</html>