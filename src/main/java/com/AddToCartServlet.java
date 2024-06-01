package com;

import java.io.IOException;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddToCart", urlPatterns = {"/addtocart"})
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession orderSession = request.getSession();
        if (orderSession == null) {
            // The session is empty, redirect to the productDAOServlet
            response.sendRedirect("productList");
            return;
        }
        String productId = request.getParameter("productId");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Get the order map from the session
        @SuppressWarnings("unchecked")
		HashMap<String, Integer> orderMap = (HashMap<String, Integer>) orderSession.getAttribute("orderMap");
        if (orderMap == null) {
            // If the order map doesn't exist, create a new one
            orderMap = new HashMap<>();
        }

        // Add the product to the order map
        orderMap.put(productId, quantity);

        // Store the order map in the session
        orderSession.setAttribute("orderMap", orderMap);

        System.out.println("Order Added:" + productId + " Quantity: " + quantity);

        orderSession.setAttribute("message", "Product successfully added to cart");
        response.sendRedirect("product?id=" + productId);
    }
}