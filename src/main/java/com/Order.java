package com;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Order {
    private int orderId;
    private String status;
    private LocalDateTime orderDate;
    private String name;
    private List<Product> products = new ArrayList<>();
    private double total;

    public Order(int orderId, String status, LocalDateTime orderDate, String name) {
        this.orderId = orderId;
        this.status = status;
        this.orderDate = orderDate;
        this.name = name;
    }

    public void addProduct(int productId, String productName, int quantity, double price) {
        this.products.add(new Product(productId, productName, quantity, price));
        this.total += quantity * price;
    }
    public int getOrderId() {
        return orderId;
    }

    public String getStatus() {
        return status;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public String getName() {
        return name;
    }

    public List<Product> getProducts() {
        return products;
    }

    public double getTotal() {
        return total;
    }
}
