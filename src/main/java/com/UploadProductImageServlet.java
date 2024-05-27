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

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;



@MultipartConfig
@WebServlet(name = "UploadProdImg", urlPatterns = {"/uploadProdImg"})
public class UploadProductImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";
    Connection conn = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Part part = request.getPart("image");
		String fileName = part.getSubmittedFileName();
		String uploadPath = getServletContext().getInitParameter("file-upload-path");
		String path = uploadPath+File.separator+"src"+File.separator+"main"+File.separator +"webapp"+File.separator+"product-images"+File.separator+fileName;
		String relativePath = "product-images/"+fileName;

		System.out.println("File path: " + path);
		
		InputStream is = part.getInputStream();
		if (uploadFile(is, path)) {
			System.out.println("File uploaded successfully!");
		} else {
			System.out.println("File upload failed!");
		}
		try {
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            System.out.println("Database connected successfully!");

            String productId = request.getParameter("productId");
            int productIdInt = Integer.parseInt(productId);
            String sqlSelect = "SELECT CASE WHEN img_thumbnail IS NULL THEN 'img_thumbnail' WHEN img1 IS NULL THEN 'img1' WHEN img2 IS NULL THEN 'img2' WHEN img3 IS NULL THEN 'img3' END AS imgField FROM product WHERE id = ?";
            statement = conn.prepareStatement(sqlSelect);
            statement.setInt(1, productIdInt);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String imgField = resultSet.getString("imgField");
                System.out.println("Image field to update: " + imgField);

                if (imgField != null) {
                    String sqlUpdate = "UPDATE product SET " + imgField + " = ? WHERE id = ?";
                    statement = conn.prepareStatement(sqlUpdate);
                    statement.setString(1, relativePath);
                    statement.setInt(2, productIdInt);
                    int rowsUpdated = statement.executeUpdate();
                    System.out.println("Rows updated: " + rowsUpdated);
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
		response.sendRedirect("inventory?requery=true");
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
