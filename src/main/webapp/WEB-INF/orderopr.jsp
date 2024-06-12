<%@ page import="com.Order" %>
<%@ page import="com.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Operation</title>
    
	<link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/seller-header.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/orderopr.css">
</head>
<body>
    <%
    String message = (String) request.getAttribute("message");
    if (message != null) {
    %>
        <script>
            alert("<%=message%>");
        </script>
        <% request.removeAttribute("message"); %>
    <%
    }
    %>
	<header>
	    <div id="logo">
	        <img src="<%= request.getContextPath() %>/website-images/logo.png" alt="Logo">
	    </div>
	    
	    <nav>
	        <a id="one" href="orders" class="active">Back to Orders</a>
	        <a id="two"  href="inventory">Inventory</a>
	        <a id="three" href="sales">Sales</a>
	        <a id="four" href="logout" onclick="return confirm('Are you sure you want to logout?')">Logout</a>
	    </nav>
	</header>
    <section id="content">
        <%
        Order order = (Order) request.getAttribute("order");
        %>
        <h2>Order ID: <%=order.getOrderId()%></h2>
		<p>Name: <%=order.getName()%></p>
		<p>Contact: <%=order.getContact()%></p>
		<p>Region: <%=order.getRegion()%></p>
		<p>City: <%=order.getBarangay()%></p>
		<p>Brgy., Lot, & Street: <%=order.getAddress()%></p>
		<p>Courier: <%=order.getCourier()%></p>
        <table>
            <tr>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
            <% 
            double total = 0;
            for (Product product : order.getProducts()) {
            	total += product.getPrice() * product.getQuantity();
            %>
                <tr>
                    <td><%=product.getProductName()%></td>
                    <td><%=product.getQuantity()%></td>
                    <td><%=product.getPrice()%></td>
                </tr>
            <% 
            }
            %>
        </table>
        <p id="total">Total: <%=total%></p>
    </section>
    <section id = "statusControls">
    <form action="updateOrderStatus" method="POST">
        <input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
        <p>Status: <%=order.getStatus()%></p>
        <% if(order.getStatus().equals("accepted")) { %>
            <button type="submit" name="status" value="voided" onclick="return confirm('Are you sure you want to void this order?')">Void</button>
            <button type="submit" name="status" value="deleted" onclick="return confirm('Are you sure you want to delete this order?')">Delete</button>
        <% } else if(order.getStatus().equals("declined") || order.getStatus().equals("voided")) { %>
             <button type="submit" name="status" value="deleted" onclick="return confirm('Are you sure you want to delete this order?')">Delete</button>
        <% } else if(order.getStatus().equals("pending")) { %>
             <button type="submit" name="status" value="accepted" onclick="return confirm('Are you sure you want to accept this order?')">Accept</button>
            <button type="submit" name="status" value="declined" onclick="return confirm('Are you sure you want to decline this order?')">Decline</button>
        <% } %>
    </form>
</section>
</body>
</html>