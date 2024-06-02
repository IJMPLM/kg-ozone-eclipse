
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

@WebServlet(name = "CreateChangeLog", urlPatterns = {"/createChangeLog"})
public class CreateChangeLogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String changeSession = request.getParameter("changeSession");
        String changeText = request.getParameter("changeText");

        String sql = "INSERT INTO changelog (change_session, change_text) VALUES (?, ?)";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, changeSession);
            statement.setString(2, changeText);
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
