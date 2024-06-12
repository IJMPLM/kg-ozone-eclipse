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
	<link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/sales.css">
</head>
<body>
	<%
		String period = "day";
		String pattern = "yyyy-MM-dd EEE";
		DateTimeFormatter formatterDay = DateTimeFormatter.ofPattern(pattern);
		List<Sale> salesDay = (List<Sale>) request.getAttribute("sales");
		
		period = "week";
		pattern = "'Week 'W 'of' MMMM yyyy";
		DateTimeFormatter formatterWeek = DateTimeFormatter.ofPattern(pattern);
		List<Sale> salesWeek = (List<Sale>) request.getAttribute("sales");
		
		period = "month";
		pattern = "MMMM yyyy";
		DateTimeFormatter formatterMonth = DateTimeFormatter.ofPattern(pattern);
		List<Sale> salesMonth = (List<Sale>) request.getAttribute("sales");
	%>
    <header>
	    <div id="logo">
	        <img src="<%= request.getContextPath() %>/website-images/logo.png" alt="Logo">
	    </div>
	    
	    <nav>
	        <a id="one" href="inventory" >Inventory</a>
	        <a id="two"  href="orders">Orders</a>
	        <a id="three" href="sales" class="active">Sales</a>
  		    <a id="four" href="logout" onclick="return confirm('Are you sure you want to logout?')">Logout</a>
	    </nav>
	</header>
    <section id="content">	
    
    	<div id="daily">
				<div id="dailyToggle">Daily</div>
			<table id="dailyTable">
            	<tr>
                <th>Period</th>
                <th>Product Name</th>
                <th>Quantity Sold</th>
                <th>Total Sales</th>
            </tr>
			<%
			for (Sale sale : salesDay) {
			%>
			    <tr>
			        <td><%=formatterDay.format(sale.getPeriod())%></td>
			        <td><%=sale.getProductName()%></td>
			        <td><%=sale.getQuantity()%></td>
			        <td><%=sale.getTotal()%></td>
			    </tr>
			<%
			}
			%>
        </table>
    	</div>

    	<div id="weekly">
    		<div id="weeklyToggle">Weekly</div>
			<table id="weeklyTable">
            	<tr>
                <th>Period</th>
                <th>Product Name</th>
                <th>Quantity Sold</th>
                <th>Total Sales</th>
            </tr>
			<%
			for (Sale sale : salesWeek) {
			%>
			    <tr>
			        <td><%=formatterWeek.format(sale.getPeriod())%></td>
			        <td><%=sale.getProductName()%></td>
			        <td><%=sale.getQuantity()%></td>
			        <td><%=sale.getTotal()%></td>
			    </tr>
			<%
			}
			%>
        </table>
    	</div>
    	
    	<div id="monthly">
    	<div id="monthlyToggle">Monthly</div>
			<table id="monthlyTable">
            	<tr>
                <th>Period</th>
                <th>Product Name</th>
                <th>Quantity Sold</th>
                <th>Total Sales</th>
            </tr>
			<%
			for (Sale sale : salesMonth) {
			%>
			    <tr>
			        <td><%=formatterMonth.format(sale.getPeriod())%></td>
			        <td><%=sale.getProductName()%></td>
			        <td><%=sale.getQuantity()%></td>
			        <td><%=sale.getTotal()%></td>
			    </tr>
			<%
			}
			%>
        </table>
    	</div>
    	
    </section>
    
<script>
    window.onload = function() {
        var dailyToggle = document.getElementById('dailyToggle');
        var weeklyToggle = document.getElementById('weeklyToggle');
        var monthlyToggle = document.getElementById('monthlyToggle');

        var dailyTable = document.getElementById('dailyTable');
        var weeklyTable = document.getElementById('weeklyTable');
        var monthlyTable = document.getElementById('monthlyTable');

        dailyToggle.onclick = function() {
            dailyTable.style.display = (dailyTable.style.display == 'none') ? 'block' : 'none';
        };

        weeklyToggle.onclick = function() {
            weeklyTable.style.display = (weeklyTable.style.display == 'none') ? 'block' : 'none';
        };

        monthlyToggle.onclick = function() {
            monthlyTable.style.display = (monthlyTable.style.display == 'none') ? 'block' : 'none';
        };
    };
</script>
    
</body>
</html>