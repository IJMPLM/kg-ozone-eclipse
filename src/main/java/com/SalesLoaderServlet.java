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

@WebServlet(name = "Sales", urlPatterns = {"/sales"})
public class SalesLoaderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	List<Sale> sales = new ArrayList<>();
        String period = request.getParameter("period");
        period = period != null ? period : "day"; // Set default period to "day" if not provided
        String sql = "SELECT date_trunc(?, o.order_date) as period, p.name, sum(op.product_quantity) as quantity, sum(op.product_quantity * p.price) as total " +
                "FROM orders o " +
                "JOIN orders_product op ON o.order_id = op.order_id " +
                "JOIN product p ON op.product_id = p.id " +
                "GROUP BY period, p.name " +
                "ORDER BY period, p.name";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, period);
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        Timestamp periodTimestamp = resultSet.getTimestamp("period");
                        String productName = resultSet.getString("name");
                        int quantity = resultSet.getInt("quantity");
                        double total = resultSet.getDouble("total");
                        sales.add(new Sale(periodTimestamp.toLocalDateTime(), productName, quantity, total));
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        request.setAttribute("sales", sales);
        request.getRequestDispatcher("/WEB-INF/sales.jsp").forward(request, response);
    }
}