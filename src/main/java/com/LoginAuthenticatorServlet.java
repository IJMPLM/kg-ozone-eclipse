package com;

import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name = "LoginAuth", urlPatterns = {"/loginAuth"})
public class LoginAuthenticatorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";
    Connection conn = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    private final static Logger LOGGER = Logger.getLogger(LoginAuthenticatorServlet.class.getName());
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LOGGER.info("LoginServlet doPost called");
		try {
			String username = request.getParameter("username");
		    String password = request.getParameter("password");
		    LOGGER.info("Received username: " + username + " and password: " + password);
		    String sql = "SELECT password FROM credentials WHERE username = ?";
			conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
			statement = conn.prepareStatement(sql);
			statement.setString(1, username);
	        resultSet = statement.executeQuery();
			if (resultSet.next()) {
	            String storedPasswordHash = resultSet.getString("password");
	            String hashedPassword = hashPassword(password);
	            if (hashedPassword.equals(storedPasswordHash)) {
	            	request.getSession().setAttribute("loginStatus", true);
	                response.sendRedirect("inventory?requery=true");
	            } else {
	                request.setAttribute("loginStatus", false);
	                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/login.jsp");
	                dispatcher.forward(request, response);
	            }
	        } else {
	            request.setAttribute("loginStatus", false);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/login.jsp");
	            dispatcher.forward(request, response);
	        }
		} catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e);
            
		} finally {
	        if (resultSet != null) {
	            try {
	                resultSet.close();
	            } catch (SQLException e) { /* ignored */}
	        }
	        if (statement != null) {
	            try {
	                statement.close();
	            } catch (SQLException e) { /* ignored */}
	        }
	        if (conn != null) {
	            try {
	                conn.close();
	            } catch (SQLException e) { /* ignored */}
	        }
	    }
	}
	public String hashPassword(String password) {
	    try {
	        MessageDigest md = MessageDigest.getInstance("SHA-256");
	        byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
	        BigInteger number = new BigInteger(1, hash);
	        StringBuilder hexString = new StringBuilder(number.toString(16));
	        while (hexString.length() < 32) {
	            hexString.insert(0, '0');
	        }
	        return hexString.toString();
	    } catch (NoSuchAlgorithmException e) {
	        throw new RuntimeException(e);
	    }
	}
}
