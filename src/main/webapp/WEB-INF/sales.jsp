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
	<link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/seller-header.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/order.css">
</head>
<body>
	<%
            String period = request.getParameter("period");
            period = period != null ? period : "day"; // Set default period to "day" if not provided
			String pattern;
			switch (period) {
			    case "week":
			        pattern = "'Week 'W 'of' MMMM yyyy";
			        break;
			    case "month":
			        pattern = "MMMM yyyy";
			        break;
			    default:
			        pattern = "yyyy-MM-dd EEE";
			}
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
			List<Sale> sales = (List<Sale>) request.getAttribute("sales");
			%>
    <header>
        <nav>
            <a href="inventory">Inventory</a>
            <a href="orders">Orders</a>
            <a href="sales" class="active">Sales</a>
            <a href="logout">Logout</a>
        </nav>
    </header>
		<a href="?period=day" class="<%= period.equals("day") ? "active" : "" %>">Daily</a>
		<a href="?period=week" class="<%= period.equals("week") ? "active" : "" %>">Weekly</a>
		<a href="?period=month" class="<%= period.equals("month") ? "active" : "" %>">Monthly</a>
    <section id="content">
        <table>
            <tr>
                <th>Period</th>
                <th>Product Name</th>
                <th>Quantity Sold</th>
                <th>Total Sales</th>
            </tr>
			<%
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