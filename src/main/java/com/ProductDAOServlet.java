package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "ProductDAO", urlPatterns = {"/productList"})
public class ProductDAOServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    //doGet for web.xml
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            Context initContext;
            try {
                initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                BasicDataSource dataSource = (BasicDataSource) envContext.lookup("jdbc/kg-ozone");
                HttpSession session = request.getSession();
                String orderSuccessMessage = (String) session.getAttribute("orderSuccess");
                if (orderSuccessMessage != null) {
                    request.setAttribute("orderSuccess", orderSuccessMessage);
                    session.removeAttribute("orderSuccess"); // remove it from the session
                }
                
                @SuppressWarnings("unchecked")
                ArrayList<HashMap<String, String>> productList = (ArrayList<HashMap<String, String>>) session.getAttribute("productList");

                if (productList == null) {
                    productList = new ArrayList<>();
                    conn = dataSource.getConnection();
                    String sql = "SELECT * FROM product ORDER BY brand";    //ordered by brand for home display
                    statement = conn.prepareStatement(sql);    
                    resultSet = statement.executeQuery();

                    while (resultSet.next()) {
                        HashMap<String, String> product = new HashMap<>();
                        ResultSetMetaData rsmd = resultSet.getMetaData();
                        int columnsNumber = rsmd.getColumnCount();
                        product.put("id", resultSet.getString("id"));
                        product.put("name", resultSet.getString("name"));
                        product.put("category", resultSet.getString("category"));
                        product.put("description", resultSet.getString("description"));
                        product.put("price", resultSet.getString("price"));
                        product.put("stock", resultSet.getString("stock"));
                        product.put("img_thumbnail", resultSet.getString("img_thumbnail"));
                        for (int i = 1; i <= columnsNumber; i++) {
                            String columnName = rsmd.getColumnName(i);
                            if (columnName.equals("img1") || columnName.equals("img2") || columnName.equals("img3")) {
                                String columnValue = resultSet.getString(columnName);
                                product.put(columnName, columnValue != null ? columnValue : "null");
                            }
                        }
                        product.put("brand", resultSet.getString("brand"));
                        productList.add(product);
                    }
                    session.setAttribute("productList", productList);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/home.jsp");
                    dispatcher.forward(request, response);
                } else {
					session.setAttribute("productList", productList);
					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/home.jsp");
					dispatcher.forward(request, response);
                }
                System.out.println("Product List: ");
                System.out.println(Arrays.toString(productList.toArray()));
                
                
                
                
            } catch (NamingException e) {
                e.printStackTrace();
            }
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
    }
}