package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Orders", urlPatterns = {"/orders"})
public class OrdersLoaderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
        	String sql = "SELECT o.order_id, o.status, o.order_date, o.order_name, p.id, p.name, op.product_quantity, p.price " +
        	        "FROM orders o " +
        	        "JOIN orders_product op ON o.order_id = op.order_id " +
        	        "JOIN product p ON op.product_id = p.id " +
        	        "ORDER BY o.order_date DESC";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        int orderId = resultSet.getInt("order_id");
                        String status = resultSet.getString("status");
                        Timestamp orderDate = resultSet.getTimestamp("order_date");
                        String name = resultSet.getString("order_name");
                        int productId = resultSet.getInt("id");
                        String productName = resultSet.getString("name");
                        int quantity = resultSet.getInt("product_quantity");
                        double price = resultSet.getDouble("price");

                        Order order = findOrder(orders, orderId);
                        if (order == null) {
                            order = new Order(orderId, status, orderDate.toLocalDateTime(), name);
                            orders.add(order);
                        }
                        order.addProduct(productId, productName, quantity, price);
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/WEB-INF/order.jsp").forward(request, response);
    }

    private Order findOrder(List<Order> orders, int orderId) {
        for (Order order : orders) {
            if (order.getOrderId() == orderId) {
                return order;
            }
        }
        return null;
    }
}