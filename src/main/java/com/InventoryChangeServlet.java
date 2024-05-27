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
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "UpdateInventory", urlPatterns = {"/updateInventory"})
public class InventoryChangeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        ArrayList<HashMap<String, String>> productList = (ArrayList<HashMap<String, String>>) session.getAttribute("productList");

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String brand = request.getParameter("brand");
        String stock = request.getParameter("stock");
        String price = request.getParameter("price");

        @SuppressWarnings("unchecked")
        HashMap<String, HashMap<String, String>> allChanges = (HashMap<String, HashMap<String, String>>) session.getAttribute("allChanges");
        if (allChanges == null) {
            allChanges = new HashMap<>();
        }

        HashMap<String, String> changes = allChanges.getOrDefault(id, new HashMap<>());
        for (HashMap<String, String> product : productList) {
            if (product.get("id") != null && product.get("id").equals(id)) {
                if (product.get("name") == null || !product.get("name").equals(name)) {
                    changes.put("name", name);
                    product.put("name", name);
                }
                if (product.get("category") == null || !product.get("category").equals(category)) {
                    changes.put("category", category);
                    product.put("category", category);
                }
                if (product.get("description") == null || !product.get("description").equals(description)) {
                    changes.put("description", description);
                    product.put("description", description);
                }
                if (product.get("brand") == null || !product.get("brand").equals(brand)) {
                    changes.put("brand", brand);
                    product.put("brand", brand);
                }
                if (product.get("stock") == null || !product.get("stock").equals(stock)) {
                    changes.put("stock", stock);
                    product.put("stock", stock);
                }
                if (product.get("price") == null || !product.get("price").equals(price)) {
                    changes.put("price", price);
                    product.put("price", price);
                }
                break;
            }
        }

        if (!changes.isEmpty()) {
            allChanges.put(id, changes);
            session.setAttribute("allChanges", allChanges);
            System.out.println("Changes saved in session: " + allChanges);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/inventory.jsp");
        dispatcher.forward(request, response);
    }
}