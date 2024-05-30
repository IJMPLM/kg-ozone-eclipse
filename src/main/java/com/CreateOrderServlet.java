package com;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet(name = "Order", urlPatterns = {"/order"})
public class CreateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";
    Connection conn = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String region = request.getParameter("region");
        String barangay = request.getParameter("barangay");
        String courier = request.getParameter("courier");

        System.out.println("Name: " + name);
        System.out.println("Contact: " + contact);
        System.out.println("Address: " + address);
        System.out.println("Region: " + region);
        System.out.println("Barangay: " + barangay);
        System.out.println("Courier: " + courier);
        
        if (name == null || contact == null || address == null || region == null || barangay == null || courier == null) {
            request.setAttribute("errorMessage", "All fields are required.");
            try {
				request.getRequestDispatcher("WEB-INF/orderform.jsp").forward(request, response);
			} catch (ServletException e){
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
            return;
        }
     // For each product in the order
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        if (productIds != null && quantities != null) {
            for (int i = 0; i < productIds.length; i++) {
                System.out.println("Product ID: " + productIds[i]);
                System.out.println("Quantity: " + quantities[i]);
            }
        }
        
        try {
			Part partId = request.getPart("validId");
			Part partRceipt = request.getPart("receipt");
			
			if (partId.getSize() == 0 || partRceipt.getSize() == 0) {
		        request.setAttribute("errorMessage", "All files are required.");
		        request.getRequestDispatcher("WEB-INF/orderform.jsp").forward(request, response);
		        return;
		    }
			
			String fileNameId = partId.getSubmittedFileName();
			String fileNameReceipt = partRceipt.getSubmittedFileName();
			
			String uploadPath = getServletContext().getInitParameter("file-upload-path");
			String pathId = uploadPath+File.separator+"src"+File.separator+"main"+File.separator +"webapp"+File.separator+"WEB-INF"+File.separator+"CustomerSubmissions"+File.separator+"Valid_Ids"+File.separator+fileNameId;
			String pathReceipt = uploadPath+File.separator+"src"+File.separator+"main"+File.separator +"webapp"+File.separator+"WEB-INF"+File.separator+"CustomerSubmissions"+File.separator+"Receipts"+File.separator+fileNameReceipt;
			
			String relativePathId = "Valid_Ids/"+fileNameId;
			String relativePathReceipt = "Receipts/"+fileNameReceipt;
			
			System.out.println("ValidId File path: " + pathId);
			System.out.println("Receipt File path: " + pathReceipt);
			
			InputStream isId = partId.getInputStream();
			InputStream isReceipt = partRceipt.getInputStream();
			
			if (uploadFile(isId, pathId)) {
				System.out.println("ValidId File uploaded successfully!");
			} else {
				System.out.println("ValidId File upload failed!");
			}
			
			if (uploadFile(isReceipt, pathReceipt)) {
				System.out.println("Receipt File uploaded successfully!");
			} else {
				System.out.println("Receipt File upload failed!");
			}
			
			try {
	            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
	            System.out.println("Database connected successfully!");
	            
	            String maxQuery = "SELECT MAX(order_id) AS max_id FROM orders";
	            statement = conn.prepareStatement(maxQuery);
	            resultSet = statement.executeQuery();
	            int id = 1; // Default id if no entries in the table
	            if (resultSet.next()) {
	                id = resultSet.getInt("max_id") + 1; // Increment the maximum id
	            }
	         
	            String orders = "INSERT INTO orders (order_id, name, contact, valid_id, address, region, barangay, receipt, courier, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	            statement = conn.prepareStatement(orders);
	            statement.setInt(1, id);
	            statement.setString(2, name);
	            statement.setString(3, contact);
	            statement.setString(4, relativePathId);
	            statement.setString(5, address);
	            statement.setString(6, region);
	            statement.setString(7, barangay);
	            statement.setString(8, relativePathReceipt);
	            statement.setString(9, courier);
	            statement.setString(10, "pending");
	            int rowsAffected = statement.executeUpdate();
	            System.out.println(rowsAffected + " row(s) inserted into orders table.");
 
	            
	            String orders_product = "INSERT INTO orders_product (order_id, product_id, product_quantity) VALUES (?, ?, ?)";
	            PreparedStatement statementOrderProduct = conn.prepareStatement(orders_product);

	            if (productIds != null && quantities != null) {
	                for (int i = 0; i < productIds.length; i++) {
	                    int productId = Integer.parseInt(productIds[i]);
	                    int quantity = Integer.parseInt(quantities[i]);

	                    statementOrderProduct.setInt(1, id); // order_id
	                    statementOrderProduct.setInt(2, productId); // product_id
	                    statementOrderProduct.setInt(3, quantity); // quantity

	                    int rowsAffectedOrderProduct = statementOrderProduct.executeUpdate();
	                    System.out.println(rowsAffectedOrderProduct + " row(s) inserted into orders_product table.");
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            // close resources
	            if (resultSet != null) {
	                try {
						resultSet.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	            }
	            if (statement != null) {
	                try {
						statement.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	            }
	            if (conn != null) {
	                try {
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	            }
	        }
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
        HttpSession session = request.getSession();
        session.invalidate();
        session = request.getSession(true);
        session.setAttribute("orderSuccess", "Order was successfully made!");
        response.sendRedirect(request.getContextPath() + "/productList");
    }
    
    
    
    
    public boolean uploadFile(InputStream is, String path) {
	    boolean test = false;
	    try {
	        FileOutputStream fos = new FileOutputStream(path);
	        byte[] buffer = new byte[1024];
	        int bytesRead;
	        while ((bytesRead = is.read(buffer)) != -1) {
	            fos.write(buffer, 0, bytesRead);
	        }
	        fos.flush();
	        fos.close();
	        test = true;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return test;
	}
}