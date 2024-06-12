<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/website-images/logo-icon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/login-design.css">
    <title>KG Ozone</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Julius+Sans+One&family=Kufam:ital,wght@0,400..900;1,400..900&family=Rozha+One&display=swap" rel="stylesheet">
</head>

					<% 
					    String loginStatus = "Not logged in";
					    Object loginStatusObj = request.getAttribute("loginStatus");
					    if(loginStatusObj instanceof Boolean && (Boolean)loginStatusObj){
					        loginStatus = "Logged in";
					    } else if(loginStatusObj instanceof String){
					        loginStatus = (String) loginStatusObj;
					    }
					%>
<body>
    <header>
        <div id="logo-button">
            <img src="<%= request.getContextPath() %>/website-images/logo.png" alt="Logo">
        </div>
        <input type="checkbox" id="nav_check" hidden>
    
        <label for="nav_check" class="hamburger">
            <div></div>
            <div></div>
            <div></div>
        </label>
    </header>
       <div class="content">
        <h1>Welcome Back, Seller!</h1>
        
        <div id="log-rectangle"> 
        <form action="loginAuth" method="POST">
            <h2>Enter Unique ID</h2>
            <input type="text" placeholder="Enter Your Unique ID Here..." name="username">
            <h2>Enter Password</h2>
            <input type="password" placeholder="Enter Your Password Here..." name="password">
            <div>Login status: <%=loginStatus %></div>  
            <input id="cancel-button" type="button" value="Cancel" onclick="history.back()"/> 
            <input  id="confirm-button" type="submit" value="Confirm">  
        </form>
        </div>
    </div>
	<script>
	window.onload = function() {
	    var inputs = document.querySelectorAll('input');
	    inputs.forEach(function(input) {
	        input.addEventListener('keydown', function(event) {
	            if (event.keyCode == 13) {
	                event.preventDefault();
	                input.blur(); // remove focus from the input field
	            }
	        });
	    });
	}
	</script>
</body>
</html>