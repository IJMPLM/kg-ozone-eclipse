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

        // Remove the orderMap from the session
        orderSession.removeAttribute("orderMap");

        // Get the product ID and quantity from the request
        String productId = request.getParameter("productId");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Create a new map for the "Buy Now" product
        HashMap<String, Integer> buyNowProduct = new HashMap<>();
        buyNowProduct.put(productId, quantity);

        // Store the "Buy Now" product in the session
        orderSession.setAttribute("buyNowProduct", buyNowProduct);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/orderform.jsp");
        dispatcher.forward(request, response);
    }
}