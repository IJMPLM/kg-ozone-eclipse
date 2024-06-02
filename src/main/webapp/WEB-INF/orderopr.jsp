<%@ page import="com.Order" %>
<%@ page import="com.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Operation</title>
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
        <nav>
            <a href="inventory">Inventory</a>
            <a href="orders">Orders</a>
            <a href="sales">Sales</a>
        </nav>
    </header>
    <section id="content">
        <%
        Order order = (Order) request.getAttribute("order");
        %>
        <h2>Order ID: <%=order.getOrderId()%></h2>
        <form action="updateOrderStatus" method="POST">
            <input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
            <label for="status">Status:</label>
            <select id="status" name="status">
                <option value="<%=order.getStatus()%>" selected><%=order.getStatus()%></option>
                <% if(order.getStatus().equals("accepted")) { %>
                    <option value="voided">Voided</option>
                    <option value="deleted">Deleted</option>
                <% } else if(order.getStatus().equals("declined") || order.getStatus().equals("voided")) { %>
                    <option value="deleted">Deleted</option>
                <% } else if(order.getStatus().equals("pending")) { %>
                    <option value="accepted">Accepted</option>
                    <option value="declined">Declined</option>
                <% } %>
            </select>
            <input type="submit" value="Update Status">
        </form>
        <h2>Order ID: <%=order.getOrderId()%></h2>
		<p>Name: <%=order.getName()%></p>
		<p>Contact: <%=order.getContact()%></p>
		<p>Address: <%=order.getAddress()%></p>
		<p>Region: <%=order.getRegion()%></p>
		<p>Barangay: <%=order.getBarangay()%></p>
		<p>Courier: <%=order.getCourier()%></p>
        <table>
            <tr>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
            <% 
            for (Product product : order.getProducts()) {
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
    </section>
</body>
</html>