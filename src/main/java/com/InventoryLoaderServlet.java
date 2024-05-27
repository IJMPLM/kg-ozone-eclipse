package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "Inventory", urlPatterns = {"/inventory"})
public class InventoryLoaderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";

    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<HashMap<String, String>> productList;
        HashMap<String, HashMap<String, String>> allChanges;

        // Check if the request attribute 'requery' is set to true
        String requeryStatus = request.getParameter("requery");
        if (requeryStatus != null && requeryStatus.equals("true")) {
            productList = new ArrayList<>();
            allChanges = new HashMap<>();
            Connection conn = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;
            try {
                conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                String sql = "SELECT * FROM product ORDER BY id ASC";
                statement = conn.prepareStatement(sql);
                resultSet = statement.executeQuery();
                String contextPath = request.getContextPath();
                while (resultSet.next()) {
                    HashMap<String, String> product = new HashMap<>();
                    product.put("id", resultSet.getString("id"));
                    product.put("name", resultSet.getString("name"));
                    product.put("category", resultSet.getString("category"));
                    product.put("img_thumbnail", contextPath + "/" + resultSet.getString("img_thumbnail"));
                    product.put("img1", contextPath + "/" + resultSet.getString("img1"));
                    product.put("img2", contextPath + "/" + resultSet.getString("img2"));
                    product.put("img3", contextPath + "/" + resultSet.getString("img3"));
                    product.put("description", resultSet.getString("description"));
                    product.put("brand", resultSet.getString("brand"));
                    product.put("stock", resultSet.getString("stock"));
                    product.put("price", resultSet.getString("price"));
                    productList.add(product);
                }
                session.setAttribute("productList", productList);
                session.setAttribute("allChanges", allChanges);
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            System.out.println("requery happened");
        } else {
            productList = (ArrayList<HashMap<String, String>>) session.getAttribute("productList");
            allChanges = (HashMap<String, HashMap<String, String>>) session.getAttribute("allChanges");
        }

        request.setAttribute("productList", productList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/inventory.jsp");
        dispatcher.forward(request, response);
    }
}