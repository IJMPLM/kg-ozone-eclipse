<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.Sale" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales</title>
</head>
<body>
    <header>
        <nav>
            <a href="inventory">Inventory</a>
            <a href="orders">Orders</a>
            <a href="sales">Sales</a>
        </nav>
    </header>
    <a href="?period=day">Daily</a>
	<a href="?period=week">Weekly</a>
	<a href="?period=month">Monthly</a>
    <section id="content">
        <table>
            <tr>
                <th>Period</th>
                <th>Product Name</th>
                <th>Quantity Sold</th>
                <th>Total Sales</th>
            </tr>
            <% 
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd EEE");
			List<Sale> sales = (List<Sale>) request.getAttribute("sales");
			for (Sale sale : sales) {
			%>
			    <tr>
			        <td><%=formatter.format(sale.getPeriod())%></td>
			        <td><%=sale.getProductName()%></td>
			        <td><%=sale.getQuantity()%></td>
			        <td><%=sale.getTotal()%></td>
			    </tr>
			<% 
			}
			%>
        </table>
    </section>
</body>
</html>