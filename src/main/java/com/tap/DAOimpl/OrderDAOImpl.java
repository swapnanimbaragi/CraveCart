package com.tap.DAOimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderDAO;
import com.tap.model.Order;
import com.tap.utility.DBConnection;

public class OrderDAOImpl implements OrderDAO {

	private static final String ADD_ORDER =
			"INSERT INTO ordertable "
			+ "(userId, restaurantId, totalAmount, paymentMode, orderStatus, deliveryAddress, "
			+ "specialInstructions, couponCode, discountAmount, deliveryFee, estimatedDeliveryTime, "
			+ "deliveryLatitude, deliveryLongitude) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	private static final String GET_ORDER =
			"SELECT * FROM ordertable WHERE orderId = ?";

	private static final String UPDATE_ORDER =
			"UPDATE ordertable SET userId = ?, restaurantId = ?, totalAmount = ?, paymentMode = ?, "
			+ "orderStatus = ?, deliveryAddress = ?, specialInstructions = ?, couponCode = ?, "
			+ "discountAmount = ?, deliveryFee = ?, estimatedDeliveryTime = ?, "
			+ "deliveryLatitude = ?, deliveryLongitude = ? WHERE orderId = ?";

	private static final String DELETE_ORDER =
			"DELETE FROM ordertable WHERE orderId = ?";

	private static final String GET_ALL_ORDER =
			"SELECT * FROM ordertable";

	private static final String GET_ORDERS_BY_USER =
			"SELECT * FROM ordertable WHERE userId = ?";

	@Override
	public void addOrder(Order order) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(ADD_ORDER);

			pstmt.setInt(1, order.getUserId());
			pstmt.setInt(2, order.getRestaurantId());
			pstmt.setDouble(3, order.getTotalAmount());
			pstmt.setString(4, order.getPaymentMode());
			pstmt.setString(5, order.getOrderStatus());
			pstmt.setString(6, order.getDeliveryAddress());
			pstmt.setString(7, order.getSpecialInstructions());
			pstmt.setString(8, order.getCouponCode());
			pstmt.setDouble(9, order.getDiscountAmount());
			pstmt.setDouble(10, order.getDeliveryFee());
			pstmt.setInt(11, order.getEstimatedDeliveryTime());
			pstmt.setDouble(12, order.getDeliveryLatitude());
			pstmt.setDouble(13, order.getDeliveryLongitude());

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public int addOrderAndReturnId(Order order) {

		Connection connection = DBConnection.getConnection();
		int generatedOrderId = 0;

		try {
			PreparedStatement pstmt = connection.prepareStatement(
					ADD_ORDER,
					PreparedStatement.RETURN_GENERATED_KEYS
			);

			pstmt.setInt(1, order.getUserId());
			pstmt.setInt(2, order.getRestaurantId());
			pstmt.setDouble(3, order.getTotalAmount());
			pstmt.setString(4, order.getPaymentMode());
			pstmt.setString(5, order.getOrderStatus());
			pstmt.setString(6, order.getDeliveryAddress());
			pstmt.setString(7, order.getSpecialInstructions());
			pstmt.setString(8, order.getCouponCode());
			pstmt.setDouble(9, order.getDiscountAmount());
			pstmt.setDouble(10, order.getDeliveryFee());
			pstmt.setInt(11, order.getEstimatedDeliveryTime());
			pstmt.setDouble(12, order.getDeliveryLatitude());
			pstmt.setDouble(13, order.getDeliveryLongitude());

			pstmt.executeUpdate();

			ResultSet keys = pstmt.getGeneratedKeys();

			if (keys.next()) {
				generatedOrderId = keys.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return generatedOrderId;
	}

	@Override
	public Order getOrder(int orderId) {

		Connection connection = DBConnection.getConnection();
		Order order = null;

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ORDER);
			pstmt.setInt(1, orderId);

			ResultSet res = pstmt.executeQuery();

			if (res.next()) {
				order = extractOrder(res);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return order;
	}

	@Override
	public void updateOrder(Order order) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_ORDER);

			pstmt.setInt(1, order.getUserId());
			pstmt.setInt(2, order.getRestaurantId());
			pstmt.setDouble(3, order.getTotalAmount());
			pstmt.setString(4, order.getPaymentMode());
			pstmt.setString(5, order.getOrderStatus());
			pstmt.setString(6, order.getDeliveryAddress());
			pstmt.setString(7, order.getSpecialInstructions());
			pstmt.setString(8, order.getCouponCode());
			pstmt.setDouble(9, order.getDiscountAmount());
			pstmt.setDouble(10, order.getDeliveryFee());
			pstmt.setInt(11, order.getEstimatedDeliveryTime());
			pstmt.setDouble(12, order.getDeliveryLatitude());
			pstmt.setDouble(13, order.getDeliveryLongitude());
			pstmt.setInt(14, order.getOrderId());

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrder(int orderId) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_ORDER);
			pstmt.setInt(1, orderId);

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Order> getAllOrder() {

		Connection connection = DBConnection.getConnection();
		List<Order> orderList = new ArrayList<Order>();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ALL_ORDER);
			ResultSet res = pstmt.executeQuery();

			while (res.next()) {
				orderList.add(extractOrder(res));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orderList;
	}

	@Override
	public List<Order> getOrdersByUser(int userId) {

		Connection connection = DBConnection.getConnection();
		List<Order> orderList = new ArrayList<Order>();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ORDERS_BY_USER);
			pstmt.setInt(1, userId);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {
				orderList.add(extractOrder(res));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orderList;
	}

	private Order extractOrder(ResultSet res) throws SQLException {

		return new Order(
				res.getInt("orderId"),
				res.getInt("userId"),
				res.getInt("restaurantId"),
				res.getDouble("totalAmount"),
				res.getString("paymentMode"),
				res.getString("orderStatus"),
				res.getString("deliveryAddress"),
				res.getString("specialInstructions"),
				res.getString("couponCode"),
				res.getDouble("discountAmount"),
				res.getDouble("deliveryFee"),
				res.getInt("estimatedDeliveryTime"),
				res.getDouble("deliveryLatitude"),
				res.getDouble("deliveryLongitude"),
				res.getTimestamp("orderDate"),
				res.getTimestamp("updatedAt")
		);
	}
}