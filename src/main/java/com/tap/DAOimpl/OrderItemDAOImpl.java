package com.tap.DAOimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderItemDAO;
import com.tap.model.OrderItem;
import com.tap.utility.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

	private static final String ADD_ORDER_ITEM =
			"INSERT INTO orderitem (orderId, menuId, quantity, itemPrice, subtotal, specialRequest, itemRating, itemReview) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

	private static final String GET_ORDER_ITEM =
			"SELECT * FROM orderitem WHERE orderItemId = ?";

	private static final String UPDATE_ORDER_ITEM =
			"UPDATE orderitem SET orderId = ?, menuId = ?, quantity = ?, itemPrice = ?, subtotal = ?, specialRequest = ?, itemRating = ?, itemReview = ? WHERE orderItemId = ?";

	private static final String DELETE_ORDER_ITEM =
			"DELETE FROM orderitem WHERE orderItemId = ?";

	private static final String GET_ALL_ORDER_ITEM =
			"SELECT * FROM orderitem";

	private static final String GET_ORDER_ITEMS_BY_ORDER =
			"SELECT * FROM orderitem WHERE orderId = ?";

	@Override
	public void addOrderItem(OrderItem orderItem) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(ADD_ORDER_ITEM);

			pstmt.setInt(1, orderItem.getOrderId());
			pstmt.setInt(2, orderItem.getMenuId());
			pstmt.setInt(3, orderItem.getQuantity());
			pstmt.setDouble(4, orderItem.getItemPrice());
			pstmt.setDouble(5, orderItem.getSubtotal());
			pstmt.setString(6, orderItem.getSpecialRequest());
			pstmt.setDouble(7, orderItem.getItemRating());
			pstmt.setString(8, orderItem.getItemReview());

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public OrderItem getOrderItem(int orderItemId) {

		Connection connection = DBConnection.getConnection();
		OrderItem orderItem = null;

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ORDER_ITEM);

			pstmt.setInt(1, orderItemId);

			ResultSet res = pstmt.executeQuery();

			if (res.next()) {
				orderItem = extractOrderItem(res);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orderItem;
	}

	@Override
	public void updateOrderItem(OrderItem orderItem) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_ORDER_ITEM);

			pstmt.setInt(1, orderItem.getOrderId());
			pstmt.setInt(2, orderItem.getMenuId());
			pstmt.setInt(3, orderItem.getQuantity());
			pstmt.setDouble(4, orderItem.getItemPrice());
			pstmt.setDouble(5, orderItem.getSubtotal());
			pstmt.setString(6, orderItem.getSpecialRequest());
			pstmt.setDouble(7, orderItem.getItemRating());
			pstmt.setString(8, orderItem.getItemReview());
			pstmt.setInt(9, orderItem.getOrderItemId());

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrderItem(int orderItemId) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_ORDER_ITEM);

			pstmt.setInt(1, orderItemId);

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<OrderItem> getAllOrderItem() {

		Connection connection = DBConnection.getConnection();
		List<OrderItem> orderItemList = new ArrayList<OrderItem>();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ALL_ORDER_ITEM);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {
				orderItemList.add(extractOrderItem(res));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orderItemList;
	}

	@Override
	public List<OrderItem> getOrderItemsByOrder(int orderId) {

		Connection connection = DBConnection.getConnection();
		List<OrderItem> orderItemList = new ArrayList<OrderItem>();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ORDER_ITEMS_BY_ORDER);

			pstmt.setInt(1, orderId);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {
				orderItemList.add(extractOrderItem(res));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orderItemList;
	}

	private OrderItem extractOrderItem(ResultSet res) throws SQLException {

		return new OrderItem(
				res.getInt("orderItemId"),
				res.getInt("orderId"),
				res.getInt("menuId"),
				res.getInt("quantity"),
				res.getDouble("itemPrice"),
				res.getDouble("subtotal"),
				res.getString("specialRequest"),
				res.getDouble("itemRating"),
				res.getString("itemReview")
		);
	}
}
