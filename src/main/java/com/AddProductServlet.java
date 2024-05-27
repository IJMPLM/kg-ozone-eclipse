package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name = "AddProduct", urlPatterns = {"/addProduct"})
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";

    @SuppressWarnings("resource")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            String name = request.getParameter("name");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            String brand = request.getParameter("brand");
            String stock = request.getParameter("stock");
            String price = request.getParameter("price");

            // Get the maximum id from the product table
            String sql = "SELECT MAX(id) AS max_id FROM product";
            statement = conn.prepareStatement(sql);
            resultSet = statement.executeQuery();
            int id = 1; // Default id if no entries in the table
            if (resultSet.next()) {
                id = resultSet.getInt("max_id") + 1; // Increment the maximum id
            }

            // Insert the new product with the generated id
            sql = "INSERT INTO product (id, name, category, description, brand, stock, price) VALUES (?, ?, ?, ?, ?, ?, ?)";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            statement.setString(2, name);
            statement.setString(3, category);
            statement.setString(4, description);
            statement.setString(5, brand);
            statement.setInt(6, Integer.parseInt(stock));
            statement.setDouble(7, Double.parseDouble(price));

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("inventory?requery=true");
    }
}