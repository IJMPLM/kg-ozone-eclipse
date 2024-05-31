
package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "OrderOperation", urlPatterns = {"/orderopr"})
public class OrderOperationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        Order order = null;
        String sql = "SELECT o.order_id, o.status, o.order_date, o.order_name, p.id, p.name, op.product_quantity, p.price " +
                "FROM orders o " +
                "JOIN orders_product op ON o.order_id = op.order_id " +
                "JOIN product p ON op.product_id = p.id " +
                "WHERE o.order_id = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
            	statement.setInt(1, Integer.parseInt(orderId)); // Fix the SQL injection vulnerability
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        if (order == null) {
                            int id = resultSet.getInt("order_id");
                            String status = resultSet.getString("status");
                            Timestamp orderDate = resultSet.getTimestamp("order_date");
                            String name = resultSet.getString("order_name");
                            order = new Order(id, status, orderDate.toLocalDateTime(), name);
                        }
                        int productId = resultSet.getInt("id");
                        String productName = resultSet.getString("name");
                        int quantity = resultSet.getInt("product_quantity");
                        double price = resultSet.getDouble("price");
                        order.addProduct(productId, productName, quantity, price);
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        request.setAttribute("order", order);
        request.getRequestDispatcher("/WEB-INF/orderopr.jsp").forward(request, response);
    }
}