
package com;

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

@WebServlet(name = "DeleteOrder", urlPatterns = {"/deleteOrder"})
public class DeleteOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = (String) request.getAttribute("orderId");
        String sqlDeleteOrderProduct = "DELETE FROM orders_product WHERE order_id = ?";
        String sqlDeleteOrder = "DELETE FROM orders WHERE order_id = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            try (PreparedStatement statement = conn.prepareStatement(sqlDeleteOrderProduct)) {
                statement.setInt(1, Integer.parseInt(orderId));
                statement.executeUpdate();
            }
            try (PreparedStatement statement = conn.prepareStatement(sqlDeleteOrder)) {
                statement.setInt(1, Integer.parseInt(orderId));
                statement.executeUpdate();
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        response.sendRedirect("orders");
    }
}