package com.tap.DAOimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

	private static final String ADD_RESTAURANT =
			"INSERT INTO restaurant "
			+ "(restaurantName, restaurantImg, cuisineType, deliveryTime, address, rating, isActive, "
			+ "description, openingTime, closingTime, contactNumber, minimumOrderAmount, deliveryFee, "
			+ "signatureDish, restaurantTag, adminUserId) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	private static final String GET_RESTAURANT =
			"SELECT * FROM restaurant WHERE restaurantId = ?";

	private static final String UPDATE_RESTAURANT =
			"UPDATE restaurant SET restaurantName = ?, restaurantImg = ?, cuisineType = ?, deliveryTime = ?, "
			+ "address = ?, rating = ?, isActive = ?, description = ?, openingTime = ?, closingTime = ?, "
			+ "contactNumber = ?, minimumOrderAmount = ?, deliveryFee = ?, signatureDish = ?, "
			+ "restaurantTag = ?, adminUserId = ? WHERE restaurantId = ?";

	private static final String DELETE_RESTAURANT =
			"DELETE FROM restaurant WHERE restaurantId = ?";

	private static final String GET_ALL_RESTAURANT =
			"SELECT * FROM restaurant";

	@Override
	public void addRestaurant(Restaurant restaurant) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(ADD_RESTAURANT);

			pstmt.setString(1, restaurant.getRestaurantName());
			pstmt.setString(2, restaurant.getRestaurantImg());
			pstmt.setString(3, restaurant.getCuisineType());
			pstmt.setInt(4, restaurant.getDeliveryTime());
			pstmt.setString(5, restaurant.getAddress());
			pstmt.setDouble(6, restaurant.getRating());
			pstmt.setBoolean(7, restaurant.isActive());
			pstmt.setString(8, restaurant.getDescription());
			pstmt.setTime(9, restaurant.getOpeningTime());
			pstmt.setTime(10, restaurant.getClosingTime());
			pstmt.setString(11, restaurant.getContactNumber());
			pstmt.setDouble(12, restaurant.getMinimumOrderAmount());
			pstmt.setDouble(13, restaurant.getDeliveryFee());
			pstmt.setString(14, restaurant.getSignatureDish());
			pstmt.setString(15, restaurant.getRestaurantTag());
			pstmt.setInt(16, restaurant.getAdminUserId());

			int i = pstmt.executeUpdate();

			System.out.println(i);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Restaurant getRestaurant(int restaurantId) {

		Connection connection = DBConnection.getConnection();
		Restaurant restaurant = null;

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_RESTAURANT);

			pstmt.setInt(1, restaurantId);

			ResultSet res = pstmt.executeQuery();

			if(res.next()) {
				restaurant = extractRestaurant(res);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}

		return restaurant;
	}

	@Override
	public void updateRestaurant(Restaurant restaurant) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_RESTAURANT);

			pstmt.setString(1, restaurant.getRestaurantName());
			pstmt.setString(2, restaurant.getRestaurantImg());
			pstmt.setString(3, restaurant.getCuisineType());
			pstmt.setInt(4, restaurant.getDeliveryTime());
			pstmt.setString(5, restaurant.getAddress());
			pstmt.setDouble(6, restaurant.getRating());
			pstmt.setBoolean(7, restaurant.isActive());
			pstmt.setString(8, restaurant.getDescription());
			pstmt.setTime(9, restaurant.getOpeningTime());
			pstmt.setTime(10, restaurant.getClosingTime());
			pstmt.setString(11, restaurant.getContactNumber());
			pstmt.setDouble(12, restaurant.getMinimumOrderAmount());
			pstmt.setDouble(13, restaurant.getDeliveryFee());
			pstmt.setString(14, restaurant.getSignatureDish());
			pstmt.setString(15, restaurant.getRestaurantTag());
			pstmt.setInt(16, restaurant.getAdminUserId());
			pstmt.setInt(17, restaurant.getRestaurantId());

			int i = pstmt.executeUpdate();

			System.out.println(i);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteRestaurant(int restaurantId) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_RESTAURANT);

			pstmt.setInt(1, restaurantId);

			int i = pstmt.executeUpdate();

			System.out.println(i);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Restaurant> getAllRestaurant() {

		Connection connection = DBConnection.getConnection();
		List<Restaurant> restaurantList = new ArrayList<Restaurant>();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ALL_RESTAURANT);

			ResultSet res = pstmt.executeQuery();

			while(res.next()) {
				Restaurant restaurant = extractRestaurant(res);
				restaurantList.add(restaurant);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}

		return restaurantList;
	}

	private Restaurant extractRestaurant(ResultSet res) throws SQLException {

		return new Restaurant(
				res.getInt("restaurantId"),
				res.getString("restaurantName"),
				res.getString("restaurantImg"),
				res.getString("cuisineType"),
				res.getInt("deliveryTime"),
				res.getString("address"),
				res.getDouble("rating"),
				res.getBoolean("isActive"),
				res.getString("description"),
				res.getTime("openingTime"),
				res.getTime("closingTime"),
				res.getString("contactNumber"),
				res.getDouble("minimumOrderAmount"),
				res.getDouble("deliveryFee"),
				res.getString("signatureDish"),
				res.getString("restaurantTag"),
				res.getInt("adminUserId")
				);
	}
}
