
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page language="java" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    @SuppressWarnings("unchecked")
    ArrayList<HashMap<String, String>> productList = (ArrayList<HashMap<String, String>>) request.getAttribute("productList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="icon" type="image/x-icon" href="Logs.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/expanded.css">
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
    <section class="Products" id="products-button">
    <div class="back-button" id="back-button" onclick="history.back()"><img src="<%= request.getContextPath() %>/website-images/back.png" alt="back"></div>
        <div class="content">
            <%
	            String brand = request.getParameter("brand");
	            out.println("<h1>" + brand + "</h1>");
	            out.println("<div class='product-list'>");
	            for (HashMap<String, String> product : productList) {
	            	String imgThumbnail = product.get("img_thumbnail");
	            	String imgSrc = (imgThumbnail != null && !imgThumbnail.isEmpty()) ? imgThumbnail : "path/to/default/image.jpg"; // default image path
	
	            	// Generate product item
	            	
	            	out.println("<a href='/product?id=" + product.get("id") + "'>");
	            	out.println("<div class='product-item' id='product-list-" + product.get("id") + "'>");
	            	out.println("<img src='" + imgSrc + "' alt='" + product.get("name") + "'>");
	            	out.println("<div class='flavor' id='brandA-flavor-" + product.get("id") + "'>" + product.get("name") + "</div>");
	            	out.println("</div>");
	            	out.println("</a>");
					
	            }
	            out.println("</div>");
            %>
        </div>
    </section>
<!-- Rest of your HTML code -->
</body>
</html>