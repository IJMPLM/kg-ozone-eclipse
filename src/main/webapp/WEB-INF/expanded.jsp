
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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/brand-design.css">
    <title>KG Ozone</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Julius+Sans+One&family=Kufam:ital,wght@0,400..900;1,400..900&family=Rozha+One&display=swap" rel="stylesheet">
</head>
<body>
    <section class="Products" id="products-button">
        <div class="content">
            <%
                for (HashMap<String, String> product : productList) {
                    String imgThumbnail = product.get("img_thumbnail");
                    String imgSrc = (imgThumbnail != null && !imgThumbnail.isEmpty()) ? imgThumbnail : "path/to/default/image.jpg"; // default image path

                    // Generate product item
                    out.println("<div class='product-item' id='product-list-" + product.get("id") + "'>");
                    out.println("<img src='" + imgSrc + "' alt='" + product.get("name") + "'>");
                    out.println("<div class='flavor' id='brandA-flavor-" + product.get("id") + "'>" + product.get("name") + "</div>");
                    out.println("</div>");
                }
            %>
        </div>
    </section>
<!-- Rest of your HTML code -->
</body>
</html>