package com;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name = "ExpandProduct", urlPatterns = {"/expand"})
public class ExpandProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String brand = request.getParameter("brand");
	    // Retrieve the product list from the session
	    @SuppressWarnings("unchecked")
	    ArrayList<HashMap<String, String>> allProducts = (ArrayList<HashMap<String, String>>) request.getSession().getAttribute("productList");

	    // Filter the list to get only the products of the selected brand
	    ArrayList<HashMap<String, String>> productList = new ArrayList<>();
	    for (HashMap<String, String> product : allProducts) {
	        if (product.get("brand").equals(brand)) {
	            productList.add(product);
	        }
	    }
	    request.setAttribute("productList", productList);
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/expanded.jsp");
	    dispatcher.forward(request, response);
	}
}