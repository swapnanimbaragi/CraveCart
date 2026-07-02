package com.tap.model;

// Model class for restaurant leaderboard
public class TopRestaurant {

	private int rank;
	private String restaurantName;
	private int totalOrders;

	public TopRestaurant() {
		super();
	}

	public TopRestaurant(int rank, String restaurantName, int totalOrders) {
		this.rank = rank;
		this.restaurantName = restaurantName;
		this.totalOrders = totalOrders;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public String getRestaurantName() {
		return restaurantName;
	}

	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}

	public int getTotalOrders() {
		return totalOrders;
	}

	public void setTotalOrders(int totalOrders) {
		this.totalOrders = totalOrders;
	}
}