package com.tap.model;

import java.sql.Timestamp;

public class Order {

	private int orderId;
	private int userId;
	private int restaurantId;
	private double totalAmount;
	private String paymentMode;
	private String orderStatus;
	private String deliveryAddress;
	private String specialInstructions;
	private String couponCode;
	private double discountAmount;
	private double deliveryFee;
	private int estimatedDeliveryTime;
	private double deliveryLatitude;
	private double deliveryLongitude;
	private Timestamp orderDate;
	private Timestamp updatedAt;

	public Order() {
	}

	public Order(int orderId, int userId, int restaurantId, double totalAmount, String paymentMode,
			String orderStatus, String deliveryAddress, String specialInstructions, String couponCode,
			double discountAmount, double deliveryFee, int estimatedDeliveryTime,
			double deliveryLatitude, double deliveryLongitude,
			Timestamp orderDate, Timestamp updatedAt) {

		this.orderId = orderId;
		this.userId = userId;
		this.restaurantId = restaurantId;
		this.totalAmount = totalAmount;
		this.paymentMode = paymentMode;
		this.orderStatus = orderStatus;
		this.deliveryAddress = deliveryAddress;
		this.specialInstructions = specialInstructions;
		this.couponCode = couponCode;
		this.discountAmount = discountAmount;
		this.deliveryFee = deliveryFee;
		this.estimatedDeliveryTime = estimatedDeliveryTime;
		this.deliveryLatitude = deliveryLatitude;
		this.deliveryLongitude = deliveryLongitude;
		this.orderDate = orderDate;
		this.updatedAt = updatedAt;
	}

	public Order(int userId, int restaurantId, double totalAmount, String paymentMode,
			String orderStatus, String deliveryAddress, String specialInstructions, String couponCode,
			double discountAmount, double deliveryFee, int estimatedDeliveryTime) {

		this.userId = userId;
		this.restaurantId = restaurantId;
		this.totalAmount = totalAmount;
		this.paymentMode = paymentMode;
		this.orderStatus = orderStatus;
		this.deliveryAddress = deliveryAddress;
		this.specialInstructions = specialInstructions;
		this.couponCode = couponCode;
		this.discountAmount = discountAmount;
		this.deliveryFee = deliveryFee;
		this.estimatedDeliveryTime = estimatedDeliveryTime;
	}

	public int getOrderId() { return orderId; }
	public void setOrderId(int orderId) { this.orderId = orderId; }

	public int getUserId() { return userId; }
	public void setUserId(int userId) { this.userId = userId; }

	public int getRestaurantId() { return restaurantId; }
	public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

	public double getTotalAmount() { return totalAmount; }
	public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

	public String getPaymentMode() { return paymentMode; }
	public void setPaymentMode(String paymentMode) { this.paymentMode = paymentMode; }

	public String getOrderStatus() { return orderStatus; }
	public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }

	public String getDeliveryAddress() { return deliveryAddress; }
	public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }

	public String getSpecialInstructions() { return specialInstructions; }
	public void setSpecialInstructions(String specialInstructions) { this.specialInstructions = specialInstructions; }

	public String getCouponCode() { return couponCode; }
	public void setCouponCode(String couponCode) { this.couponCode = couponCode; }

	public double getDiscountAmount() { return discountAmount; }
	public void setDiscountAmount(double discountAmount) { this.discountAmount = discountAmount; }

	public double getDeliveryFee() { return deliveryFee; }
	public void setDeliveryFee(double deliveryFee) { this.deliveryFee = deliveryFee; }

	public int getEstimatedDeliveryTime() { return estimatedDeliveryTime; }
	public void setEstimatedDeliveryTime(int estimatedDeliveryTime) { this.estimatedDeliveryTime = estimatedDeliveryTime; }

	public double getDeliveryLatitude() { return deliveryLatitude; }
	public void setDeliveryLatitude(double deliveryLatitude) { this.deliveryLatitude = deliveryLatitude; }

	public double getDeliveryLongitude() { return deliveryLongitude; }
	public void setDeliveryLongitude(double deliveryLongitude) { this.deliveryLongitude = deliveryLongitude; }

	public Timestamp getOrderDate() { return orderDate; }
	public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }

	public Timestamp getUpdatedAt() { return updatedAt; }
	public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

	@Override
	public String toString() {
		return "Order [orderId=" + orderId + ", userId=" + userId + ", restaurantId=" + restaurantId
				+ ", totalAmount=" + totalAmount + ", paymentMode=" + paymentMode
				+ ", orderStatus=" + orderStatus + ", deliveryAddress=" + deliveryAddress
				+ ", specialInstructions=" + specialInstructions + ", couponCode=" + couponCode
				+ ", discountAmount=" + discountAmount + ", deliveryFee=" + deliveryFee
				+ ", estimatedDeliveryTime=" + estimatedDeliveryTime
				+ ", deliveryLatitude=" + deliveryLatitude
				+ ", deliveryLongitude=" + deliveryLongitude
				+ ", orderDate=" + orderDate
				+ ", updatedAt=" + updatedAt + "]";
	}
}