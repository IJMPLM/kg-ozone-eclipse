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
                <option value="pending" <%=order.getStatus().equals("pending") ? "selected" : ""%>>Pending</option>
                <option value="declined" <%=order.getStatus().equals("declined") ? "selected" : ""%>>Declined</option>
                <option value="accepted" <%=order.getStatus().equals("accepted") ? "selected" : ""%>>Accepted</option>
            </select>
            <input type="submit" value="Update Status">
        </form>
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