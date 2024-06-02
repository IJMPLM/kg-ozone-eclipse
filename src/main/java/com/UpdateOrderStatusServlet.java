package com;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "UpdateOrderStatus", urlPatterns = {"/updateOrderStatus"})
public class UpdateOrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        if ("deleted".equals(status)) {
        	RequestDispatcher dispatcher = request.getRequestDispatcher("/deleteOrder");
            request.setAttribute("orderId", orderId);
            dispatcher.forward(request, response);
        } else {
            String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, status);
                    statement.setInt(2, Integer.parseInt(orderId));
                    statement.executeUpdate();
                }
            } catch (SQLException e) {
                throw new ServletException(e);
            }
            request.setAttribute("message", "Order status updated successfully.");
            request.getRequestDispatcher("/orderopr?orderId=" + orderId).forward(request, response);
        }
    }
}