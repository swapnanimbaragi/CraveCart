package com.tap.DAO;

import java.util.List;

import com.tap.model.DashboardStats;
import com.tap.model.TopRestaurant;

public interface AdminDashboardDAO {

	// Get total customers, restaurants, orders and delivery partners
	DashboardStats getDashboardStats();

	// Get top 5 restaurants based on highest orders
	List<TopRestaurant> getTopRestaurants();
}