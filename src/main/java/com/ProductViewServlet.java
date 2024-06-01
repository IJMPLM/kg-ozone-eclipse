package com;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "Product", urlPatterns = {"/product"})
public class ProductViewServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        ArrayList<HashMap<String, String>> productList = (ArrayList<HashMap<String, String>>) session.getAttribute("productList");
        if (productList == null) {
            // The session is empty, redirect to the productDAOServlet
            response.sendRedirect("productList");
            return;
        }
        HashMap<String, String> selectedProduct = null;

        for (HashMap<String, String> product : productList) {
            if (product.get("id").equals(id)) {
                selectedProduct = product;
                break;
            }
        }

        if (selectedProduct != null) {
            request.setAttribute("selectedProduct", selectedProduct);
            request.getRequestDispatcher("/WEB-INF/product.jsp").forward(request, response);
            System.out.println("Product Info: ");
            System.out.println(Arrays.toString(selectedProduct.entrySet().toArray()));
        } else {
        	System.out.println("Product not found");
        }
    }       	
}
