<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.Order" %>
<%@ page import="com.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/seller-header.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/order.css">
</head>
<body>
<header>
    <div id="logo">
        <img src="<%= request.getContextPath() %>/website-images/logo.png" alt="Logo">
    </div>
    
    <nav>
        <a id="one" href="inventory" >Inventory</a>
        <a id="two"  href="orders" class="active">Orders</a>
        <a id="three" href="sales">Sales</a>
        <a id="four" href="logout" onclick="return confirm('Are you sure you want to logout?')">Logout</a>
    </nav>
</header>
	<section id="content">
		<table>
            <tr>
                <th>Status</th>
                <th>Date</th>
                <th>Name</th>
                <th>Products</th>
                <th>Total</th>
            </tr>
            <%
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd EEE");
			List<Order> orders = (List<Order>) request.getAttribute("orders");
			for (Order order : orders) {
			%>
				<form id="orderForm_<%=order.getOrderId()%>" action="orderopr" method="POST">
			        <input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
			    </form>
			    <tr id="order_<%=order.getOrderId()%>" onclick="submitForm(<%=order.getOrderId()%>)">
			        <td><%=order.getStatus()%></td>
			        <td><%=formatter.format(order.getOrderDate())%></td>
			        <td><%=order.getName()%></td>
			        <td>
			            <% 
			            for (Product product : order.getProducts()) {
			            %>
			                <%=product.getProductName()%> x <%=product.getQuantity()%><br/>
			            <% 
			            }
			            %>
			        </td>
			        <td><%=order.getTotal()%></td>
			    </tr>
			<% 
			}
			%>
        </table>
	</section>
	<script>
        function submitForm(orderId) {
            var form = document.getElementById('orderForm_' + orderId);
            form.submit();
        }
    </script>
   	</body>
</html>