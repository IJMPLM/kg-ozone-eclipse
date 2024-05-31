package com;

import java.time.LocalDateTime;

public class Sale {
    private LocalDateTime period;
    private String productName;
    private int quantity;
    private double total;

    public Sale(LocalDateTime period, String productName, int quantity, double total) {
        this.period = period;
        this.productName = productName;
        this.quantity = quantity;
        this.total = total;
    }

    public LocalDateTime getPeriod() {
        return period;
    }

    public String getProductName() {
        return productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getTotal() {
        return total;
    }
}