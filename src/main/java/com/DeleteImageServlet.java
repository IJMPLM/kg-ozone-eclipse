package com;

import java.io.File;
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


@WebServlet(name = "DeleteImage", urlPatterns = {"/deleteImg"})
public class DeleteImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";

    @SuppressWarnings("resource")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String imgKey = request.getParameter("imgKey");
        String id = request.getParameter("id");

        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        String imagePath = null;
        try {
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            String sql = "SELECT " + imgKey + " FROM product WHERE id = ?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(id));
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                imagePath = resultSet.getString(imgKey);
            }

            // Delete the image file from the system
            if (imagePath != null) {
                String uploadPath = getServletContext().getInitParameter("file-upload-path");
                String filePath = uploadPath + File.separator + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + imagePath;
                File file = new File(filePath);
                if (file.delete()) {
                    System.out.println("File deleted successfully!");
                } else {
                    System.out.println("Failed to delete the file!");
                }
            }

            // Set the image field in the database to null
            String sqlUpdate = "UPDATE product SET " + imgKey + " = NULL WHERE id = ?";
            statement = conn.prepareStatement(sqlUpdate);
            statement.setInt(1, Integer.parseInt(id));
            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
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
}