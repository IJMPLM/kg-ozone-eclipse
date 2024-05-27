package com;

import java.io.IOException;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "Checkout", urlPatterns = {"/checkout"})
public class CheckoutCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession orderSession = request.getSession();

        @SuppressWarnings("unchecked")
        HashMap<String, Integer> orderMap = (HashMap<String, Integer>) orderSession.getAttribute("orderMap");

        // Forward the request to the JSP page within the WEB-INF directory
        request.getRequestDispatcher("/WEB-INF/orderform.jsp").forward(request, response);
    }
}