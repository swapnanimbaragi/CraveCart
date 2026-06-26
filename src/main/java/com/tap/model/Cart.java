package com.tap.model;

import java.sql.Timestamp;

public class Cart {

    private int cartId;
    private int userId;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private String couponCode;
    private double discountAmount;
    private double deliveryFee;
    private double platformFee;
    private double gstAmount;
    private String specialInstructions;
    private String deliveryAddress;
    private int estimatedDeliveryTime;

    public Cart() {
    }

    public Cart(int cartId, int userId, Timestamp createdAt, Timestamp updatedAt,
                String couponCode, double discountAmount, double deliveryFee,
                double platformFee, double gstAmount, String specialInstructions,
                String deliveryAddress, int estimatedDeliveryTime) {
        this.cartId = cartId;
        this.userId = userId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.couponCode = couponCode;
        this.discountAmount = discountAmount;
        this.deliveryFee = deliveryFee;
        this.platformFee = platformFee;
        this.gstAmount = gstAmount;
        this.specialInstructions = specialInstructions;
        this.deliveryAddress = deliveryAddress;
        this.estimatedDeliveryTime = estimatedDeliveryTime;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public double getDeliveryFee() {
        return deliveryFee;
    }

    public void setDeliveryFee(double deliveryFee) {
        this.deliveryFee = deliveryFee;
    }

    public double getPlatformFee() {
        return platformFee;
    }

    public void setPlatformFee(double platformFee) {
        this.platformFee = platformFee;
    }

    public double getGstAmount() {
        return gstAmount;
    }

    public void setGstAmount(double gstAmount) {
        this.gstAmount = gstAmount;
    }

    public String getSpecialInstructions() {
        return specialInstructions;
    }

    public void setSpecialInstructions(String specialInstructions) {
        this.specialInstructions = specialInstructions;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public int getEstimatedDeliveryTime() {
        return estimatedDeliveryTime;
    }

    public void setEstimatedDeliveryTime(int estimatedDeliveryTime) {
        this.estimatedDeliveryTime = estimatedDeliveryTime;
    }

    @Override
    public String toString() {
        return "Cart [cartId=" + cartId + ", userId=" + userId + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt + ", couponCode=" + couponCode
                + ", discountAmount=" + discountAmount + ", deliveryFee=" + deliveryFee
                + ", platformFee=" + platformFee + ", gstAmount=" + gstAmount
                + ", specialInstructions=" + specialInstructions + ", deliveryAddress="
                + deliveryAddress + ", estimatedDeliveryTime=" + estimatedDeliveryTime + "]";
    }
}