package com.tap.model;

// Model class to store admin dashboard count values
public class DashboardStats {

	private int totalCustomers;
	private int totalRestaurants;
	private int totalOrders;
	private int totalDeliveryPartners;

	public DashboardStats() {
		super();
	}

	public DashboardStats(int totalCustomers, int totalRestaurants, int totalOrders, int totalDeliveryPartners) {
		this.totalCustomers = totalCustomers;
		this.totalRestaurants = totalRestaurants;
		this.totalOrders = totalOrders;
		this.totalDeliveryPartners = totalDeliveryPartners;
	}

	public int getTotalCustomers() {
		return totalCustomers;
	}

	public void setTotalCustomers(int totalCustomers) {
		this.totalCustomers = totalCustomers;
	}

	public int getTotalRestaurants() {
		return totalRestaurants;
	}

	public void setTotalRestaurants(int totalRestaurants) {
		this.totalRestaurants = totalRestaurants;
	}

	public int getTotalOrders() {
		return totalOrders;
	}

	public void setTotalOrders(int totalOrders) {
		this.totalOrders = totalOrders;
	}

	public int getTotalDeliveryPartners() {
		return totalDeliveryPartners;
	}

	public void setTotalDeliveryPartners(int totalDeliveryPartners) {
		this.totalDeliveryPartners = totalDeliveryPartners;
	}
}