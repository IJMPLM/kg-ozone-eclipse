<%@ page import="java.util.List" %>
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
</head>
<body>
    <header>
	<nav>
		<a href="inventory">Inventory</a>
        <a href="orders">Orders</a>
        <a href="sales">Sales</a>
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
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            for (Order order : orders) {
            %>
                <tr id="order_<%=order.getOrderId()%>" onclick="window.location.href='/orderopr?orderId=<%=order.getOrderId()%>'">
                    <td><%=order.getStatus()%></td>
                    <td><%=order.getOrderDate()%></td>
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
   	</body>
</html>