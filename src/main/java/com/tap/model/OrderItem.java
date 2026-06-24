package com.tap.model;

public class OrderItem {

	private int orderItemId;
	private int orderId;
	private int menuId;
	private int quantity;
	private double itemPrice;
	private double subtotal;
	private String specialRequest;
	private double itemRating;
	private String itemReview;

	public OrderItem() {
	}

	public OrderItem(int orderItemId, int orderId, int menuId, int quantity, double itemPrice,
			double subtotal, String specialRequest, double itemRating, String itemReview) {

		this.orderItemId = orderItemId;
		this.orderId = orderId;
		this.menuId = menuId;
		this.quantity = quantity;
		this.itemPrice = itemPrice;
		this.subtotal = subtotal;
		this.specialRequest = specialRequest;
		this.itemRating = itemRating;
		this.itemReview = itemReview;
	}

	public OrderItem(int orderId, int menuId, int quantity, double itemPrice,
			double subtotal, String specialRequest, double itemRating, String itemReview) {

		this.orderId = orderId;
		this.menuId = menuId;
		this.quantity = quantity;
		this.itemPrice = itemPrice;
		this.subtotal = subtotal;
		this.specialRequest = specialRequest;
		this.itemRating = itemRating;
		this.itemReview = itemReview;
	}

	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(double itemPrice) {
		this.itemPrice = itemPrice;
	}

	public double getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(double subtotal) {
		this.subtotal = subtotal;
	}

	public String getSpecialRequest() {
		return specialRequest;
	}

	public void setSpecialRequest(String specialRequest) {
		this.specialRequest = specialRequest;
	}

	public double getItemRating() {
		return itemRating;
	}

	public void setItemRating(double itemRating) {
		this.itemRating = itemRating;
	}

	public String getItemReview() {
		return itemReview;
	}

	public void setItemReview(String itemReview) {
		this.itemReview = itemReview;
	}

	@Override
	public String toString() {
		return "OrderItem [orderItemId=" + orderItemId + ", orderId=" + orderId
				+ ", menuId=" + menuId + ", quantity=" + quantity + ", itemPrice=" + itemPrice
				+ ", subtotal=" + subtotal + ", specialRequest=" + specialRequest
				+ ", itemRating=" + itemRating + ", itemReview=" + itemReview + "]";
	}
}