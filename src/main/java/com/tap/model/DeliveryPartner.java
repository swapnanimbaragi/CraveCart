package com.tap.model;

public class DeliveryPartner {

	private int deliveryPartnerId;
	private String partnerName;
	private String email;
	private String phoneNumber;
	private String vehicleNumber;
	private String status;
	private int totalDeliveries;
	private double rating;

	public DeliveryPartner() {
	}

	public DeliveryPartner(int deliveryPartnerId, String partnerName, String email,
			String phoneNumber, String vehicleNumber,
			String status, int totalDeliveries, double rating) {

		this.deliveryPartnerId = deliveryPartnerId;
		this.partnerName = partnerName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.vehicleNumber = vehicleNumber;
		this.status = status;
		this.totalDeliveries = totalDeliveries;
		this.rating = rating;
	}

	public DeliveryPartner(String partnerName, String email,
			String phoneNumber, String vehicleNumber,
			String status, int totalDeliveries, double rating) {

		this.partnerName = partnerName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.vehicleNumber = vehicleNumber;
		this.status = status;
		this.totalDeliveries = totalDeliveries;
		this.rating = rating;
	}

	public int getDeliveryPartnerId() {
		return deliveryPartnerId;
	}

	public void setDeliveryPartnerId(int deliveryPartnerId) {
		this.deliveryPartnerId = deliveryPartnerId;
	}

	public String getPartnerName() {
		return partnerName;
	}

	public void setPartnerName(String partnerName) {
		this.partnerName = partnerName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getVehicleNumber() {
		return vehicleNumber;
	}

	public void setVehicleNumber(String vehicleNumber) {
		this.vehicleNumber = vehicleNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getTotalDeliveries() {
		return totalDeliveries;
	}

	public void setTotalDeliveries(int totalDeliveries) {
		this.totalDeliveries = totalDeliveries;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}
}