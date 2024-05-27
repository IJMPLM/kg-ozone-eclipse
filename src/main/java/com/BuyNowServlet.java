package com;

import java.io.IOException;
import java.util.HashMap;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "BuyNow", urlPatterns = {"/buynow"})
public class BuyNowServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession orderSession = request.getSession();

        // Get the order map from the session
        HashMap<String, Integer> orderMap = (HashMap<String, Integer>) orderSession.getAttribute("orderMap");
        if (orderMap == null) {
            // If the order map doesn't exist, create a new one
            orderMap = new HashMap<>();
        }

        String productId = request.getParameter("productId");
        if (productId != null) {
            // If a single product ID is provided, add it to the order map
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            orderMap.put(productId, quantity);
            System.out.println("Order Added:" + productId + " Quantity: " + quantity);
        }

        // Store the order map in the session
        orderSession.setAttribute("orderMap", orderMap);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/orderform.jsp");
        dispatcher.forward(request, response);
    }
}