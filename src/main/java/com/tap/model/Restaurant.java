package com.tap.model;

import java.sql.Time;

public class Restaurant {

	private int restaurantId;
	private String restaurantName;
	private String restaurantImg;
	private String cuisineType;
	private int deliveryTime;
	private String address;
	private double rating;
	private boolean isActive;
	private String description;
	private Time openingTime;
	private Time closingTime;
	private String contactNumber;
	private double minimumOrderAmount;
	private double deliveryFee;
	private String signatureDish;
	private String restaurantTag;
	private int adminUserId;

	public Restaurant() {
		
	}

	public Restaurant(int restaurantId, String restaurantName, String restaurantImg, String cuisineType,
			int deliveryTime, String address, double rating, boolean isActive, String description,
			Time openingTime, Time closingTime, String contactNumber, double minimumOrderAmount,
			double deliveryFee, String signatureDish, String restaurantTag, int adminUserId) {
		
		this.restaurantId = restaurantId;
		this.restaurantName = restaurantName;
		this.restaurantImg = restaurantImg;
		this.cuisineType = cuisineType;
		this.deliveryTime = deliveryTime;
		this.address = address;
		this.rating = rating;
		this.isActive = isActive;
		this.description = description;
		this.openingTime = openingTime;
		this.closingTime = closingTime;
		this.contactNumber = contactNumber;
		this.minimumOrderAmount = minimumOrderAmount;
		this.deliveryFee = deliveryFee;
		this.signatureDish = signatureDish;
		this.restaurantTag = restaurantTag;
		this.adminUserId = adminUserId;
	}

	public Restaurant(String restaurantName, String restaurantImg, String cuisineType, int deliveryTime,
			String address, double rating, boolean isActive, String description, Time openingTime,
			Time closingTime, String contactNumber, double minimumOrderAmount, double deliveryFee,
			String signatureDish, String restaurantTag, int adminUserId) {
		
		this.restaurantName = restaurantName;
		this.restaurantImg = restaurantImg;
		this.cuisineType = cuisineType;
		this.deliveryTime = deliveryTime;
		this.address = address;
		this.rating = rating;
		this.isActive = isActive;
		this.description = description;
		this.openingTime = openingTime;
		this.closingTime = closingTime;
		this.contactNumber = contactNumber;
		this.minimumOrderAmount = minimumOrderAmount;
		this.deliveryFee = deliveryFee;
		this.signatureDish = signatureDish;
		this.restaurantTag = restaurantTag;
		this.adminUserId = adminUserId;
	}

	public int getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	public String getRestaurantName() {
		return restaurantName;
	}

	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}

	public String getRestaurantImg() {
		return restaurantImg;
	}

	public void setRestaurantImg(String restaurantImg) {
		this.restaurantImg = restaurantImg;
	}

	public String getCuisineType() {
		return cuisineType;
	}

	public void setCuisineType(String cuisineType) {
		this.cuisineType = cuisineType;
	}

	public int getDeliveryTime() {
		return deliveryTime;
	}

	public void setDeliveryTime(int deliveryTime) {
		this.deliveryTime = deliveryTime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Time getOpeningTime() {
		return openingTime;
	}

	public void setOpeningTime(Time openingTime) {
		this.openingTime = openingTime;
	}

	public Time getClosingTime() {
		return closingTime;
	}

	public void setClosingTime(Time closingTime) {
		this.closingTime = closingTime;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public double getMinimumOrderAmount() {
		return minimumOrderAmount;
	}

	public void setMinimumOrderAmount(double minimumOrderAmount) {
		this.minimumOrderAmount = minimumOrderAmount;
	}

	public double getDeliveryFee() {
		return deliveryFee;
	}

	public void setDeliveryFee(double deliveryFee) {
		this.deliveryFee = deliveryFee;
	}

	public String getSignatureDish() {
		return signatureDish;
	}

	public void setSignatureDish(String signatureDish) {
		this.signatureDish = signatureDish;
	}

	public String getRestaurantTag() {
		return restaurantTag;
	}

	public void setRestaurantTag(String restaurantTag) {
		this.restaurantTag = restaurantTag;
	}

	public int getAdminUserId() {
		return adminUserId;
	}

	public void setAdminUserId(int adminUserId) {
		this.adminUserId = adminUserId;
	}

	@Override
	public String toString() {
		return "Restaurant [restaurantId=" + restaurantId + ", restaurantName=" + restaurantName
				+ ", restaurantImg=" + restaurantImg + ", cuisineType=" + cuisineType
				+ ", deliveryTime=" + deliveryTime + ", address=" + address + ", rating=" + rating
				+ ", isActive=" + isActive + ", description=" + description + ", openingTime="
				+ openingTime + ", closingTime=" + closingTime + ", contactNumber=" + contactNumber
				+ ", minimumOrderAmount=" + minimumOrderAmount + ", deliveryFee=" + deliveryFee
				+ ", signatureDish=" + signatureDish + ", restaurantTag=" + restaurantTag
				+ ", adminUserId=" + adminUserId + "]";
	}
}
