package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "CommitUpdate", urlPatterns = {"/commit"})
public class CommitServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/kg-ozone";
    private static final String JDBC_USER = "kgozone";
    private static final String JDBC_PASSWORD = "kgozone";
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement statement = null;
        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked")
        HashMap<String, HashMap<String, String>> allChanges = (HashMap<String, HashMap<String, String>>) session.getAttribute("allChanges");

        try {
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            if (allChanges != null) {
                for (String id : allChanges.keySet()) {
                    HashMap<String, String> changes = allChanges.get(id);
                    Set<String> integerAttributes = new HashSet<>(Arrays.asList("stock", "price")); // replace with your integer attributes
                    if (id != null) { // Only process if id is not null
                        for (String attribute : changes.keySet()) {
                            String query = "UPDATE product SET " + attribute + " = ? WHERE id = ?";
                            statement = conn.prepareStatement(query);

                            if (integerAttributes.contains(attribute)) {
                                statement.setInt(1, Integer.parseInt(changes.get(attribute)));
                            } else {
                                statement.setString(1, changes.get(attribute));
                            }

                            statement.setInt(2, Integer.parseInt(id));
                            statement.executeUpdate();
                        }
                    }
                }
                System.out.println("Changes committed: " + allChanges);
                session.removeAttribute("allChanges"); // Remove all changes from the session
            } else {
                System.out.println("No changes to commit.");
            }
        } catch(SQLException e) {
            System.out.println(e);
        } finally {
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

        // Forward the user back to the inventory page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/inventory.jsp");
        dispatcher.forward(request, response);
    }
}