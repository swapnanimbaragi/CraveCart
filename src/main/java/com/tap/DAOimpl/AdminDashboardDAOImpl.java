package com.tap.DAOimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.AdminDashboardDAO;
import com.tap.model.DashboardStats;
import com.tap.model.TopRestaurant;
import com.tap.utility.DBConnection;

public class AdminDashboardDAOImpl implements AdminDashboardDAO {

	private static final String TOTAL_CUSTOMERS =
			"SELECT COUNT(*) FROM user WHERE role='CUSTOMER'";

	private static final String TOTAL_RESTAURANTS =
			"SELECT COUNT(*) FROM restaurant";

	private static final String TOTAL_ORDERS =
			"SELECT COUNT(*) FROM ordertable";

	private static final String TOTAL_DELIVERY_PARTNERS =
			"SELECT COUNT(*) FROM user WHERE role='DELIVERY'";

	private static final String TOP_RESTAURANTS =
			"SELECT r.name AS restaurantName, COUNT(o.orderId) AS totalOrders " +
			"FROM restaurant r " +
			"JOIN ordertable o ON r.restaurantId = o.restaurantId " +
			"GROUP BY r.restaurantId, r.name " +
			"ORDER BY totalOrders DESC " +
			"LIMIT 5";

	@Override
	public DashboardStats getDashboardStats() {

		DashboardStats stats = new DashboardStats();

		try {
			Connection con = DBConnection.getConnection();

			// Total Customers
			PreparedStatement ps1 = con.prepareStatement(TOTAL_CUSTOMERS);
			ResultSet rs1 = ps1.executeQuery();
			if (rs1.next()) {
				stats.setTotalCustomers(rs1.getInt(1));
			}

			// Total Restaurants
			PreparedStatement ps2 = con.prepareStatement(TOTAL_RESTAURANTS);
			ResultSet rs2 = ps2.executeQuery();
			if (rs2.next()) {
				stats.setTotalRestaurants(rs2.getInt(1));
			}

			// Total Orders
			PreparedStatement ps3 = con.prepareStatement(TOTAL_ORDERS);
			ResultSet rs3 = ps3.executeQuery();
			if (rs3.next()) {
				stats.setTotalOrders(rs3.getInt(1));
			}

			// Total Delivery Partners
			PreparedStatement ps4 = con.prepareStatement(TOTAL_DELIVERY_PARTNERS);
			ResultSet rs4 = ps4.executeQuery();
			if (rs4.next()) {
				stats.setTotalDeliveryPartners(rs4.getInt(1));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return stats;
	}

	@Override
	public List<TopRestaurant> getTopRestaurants() {

		List<TopRestaurant> topRestaurants = new ArrayList<>();

		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement pstmt = con.prepareStatement(TOP_RESTAURANTS);
			ResultSet rs = pstmt.executeQuery();

			int rank = 1;

			while (rs.next()) {

				TopRestaurant restaurant = new TopRestaurant();

				restaurant.setRank(rank++);
				restaurant.setRestaurantName(rs.getString("restaurantName"));
				restaurant.setTotalOrders(rs.getInt("totalOrders"));

				topRestaurants.add(restaurant);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return topRestaurants;
	}
}