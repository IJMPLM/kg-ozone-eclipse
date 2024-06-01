package com;

import java.io.IOException;
import java.util.HashMap;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DeleteFromCart", urlPatterns = {"/deleteFromCart"})
public class DeleteFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession orderSession = request.getSession();
        if (orderSession == null) {
            // The session is empty, redirect to the productDAOServlet
            response.sendRedirect("productList");
            return;
        }
        String productId = request.getParameter("productId");

        // Get the order map from the session
        @SuppressWarnings("unchecked")
        HashMap<String, Integer> orderMap = (HashMap<String, Integer>) orderSession.getAttribute("orderMap");
        if (orderMap == null) {
            // If the order map doesn't exist, create a new one
            orderMap = new HashMap<>();
        }

        // Remove the product from the order map
        orderMap.remove(productId);

        // Store the updated order map in the session
        orderSession.setAttribute("orderMap", orderMap);

        System.out.println("Order Removed:" + productId);

        orderSession.setAttribute("message", "Product successfully removed from cart");
        response.sendRedirect("cart.jsp");
    }
}
