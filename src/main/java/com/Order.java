package com;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Order {
    private int orderId;
    private String status;
    private LocalDateTime orderDate;
    private String name;
    private String contact;
    private String address;
    private String region;
    private String barangay;
    private String courier;
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

    public void setName(String name) {
        this.name = name;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getBarangay() {
        return barangay;
    }

    public void setBarangay(String barangay) {
        this.barangay = barangay;
    }

    public String getCourier() {
        return courier;
    }

    public void setCourier(String courier) {
        this.courier = courier;
    }

    public List<Product> getProducts() {
        return products;
    }

    public double getTotal() {
        return total;
    }
}
