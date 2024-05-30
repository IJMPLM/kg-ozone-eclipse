package com;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet(name = "Order", urlPatterns = {"/order"})
public class CreateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String region = request.getParameter("region");
        String barangay = request.getParameter("barangay");
        String courier = request.getParameter("courier");

        System.out.println("Name: " + name);
        System.out.println("Contact: " + contact);
        System.out.println("Address: " + address);
        System.out.println("Region: " + region);
        System.out.println("Barangay: " + barangay);
        System.out.println("Courier: " + courier);

     // For each product in the order
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        if (productIds != null && quantities != null) {
            for (int i = 0; i < productIds.length; i++) {
                System.out.println("Product ID: " + productIds[i]);
                System.out.println("Quantity: " + quantities[i]);
            }
        }
        
        try {
			Part partId = request.getPart("validId");
			Part partRceipt = request.getPart("receipt");
			
			String fileNameId = partId.getSubmittedFileName();
			String fileNameReceipt = partRceipt.getSubmittedFileName();
			
			String uploadPath = getServletContext().getInitParameter("file-upload-path");
			String pathId = uploadPath+File.separator+"src"+File.separator+"main"+File.separator +"webapp"+File.separator+"WEB-INF"+File.separator+"CustomerSubmissions"+File.separator+"Valid_Ids"+File.separator+fileNameId;
			String pathReceipt = uploadPath+File.separator+"src"+File.separator+"main"+File.separator +"webapp"+File.separator+"WEB-INF"+File.separator+"CustomerSubmissions"+File.separator+"Receipts"+File.separator+fileNameReceipt;
			
			String relativePathId = "Valid_Ids/"+fileNameId;
			String relativePathReceipt = "Receipts/"+fileNameReceipt;
			
			System.out.println("ValidId File path: " + pathId);
			System.out.println("Receipt File path: " + pathReceipt);
			
			InputStream isId = partId.getInputStream();
			InputStream isReceipt = partRceipt.getInputStream();
			
			if (uploadFile(isId, pathId)) {
				System.out.println("ValidId File uploaded successfully!");
			} else {
				System.out.println("ValidId File upload failed!");
			}
			
			if (uploadFile(isReceipt, pathReceipt)) {
				System.out.println("Receipt File uploaded successfully!");
			} else {
				System.out.println("Receipt File upload failed!");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
        HttpSession session = request.getSession();
        session.invalidate();
    }
    public boolean uploadFile(InputStream is, String path) {
	    boolean test = false;
	    try {
	        FileOutputStream fos = new FileOutputStream(path);
	        byte[] buffer = new byte[1024];
	        int bytesRead;
	        while ((bytesRead = is.read(buffer)) != -1) {
	            fos.write(buffer, 0, bytesRead);
	        }
	        fos.flush();
	        fos.close();
	        test = true;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return test;
	}
}