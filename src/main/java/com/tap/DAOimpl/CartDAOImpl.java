package com.tap.DAOimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.CartDAO;
import com.tap.model.Cart;
import com.tap.utility.DBConnection;

public class CartDAOImpl implements CartDAO {

	private static final String ADD_CART =
			"INSERT INTO cart (userId, couponCode, discountAmount, deliveryFee, platformFee, gstAmount, specialInstructions, deliveryAddress, estimatedDeliveryTime) VALUES (?,?,?,?,?,?,?,?,?)";

	private static final String GET_CART =
			"SELECT * FROM cart WHERE cartId=?";

	private static final String UPDATE_CART =
			"UPDATE cart SET userId=?, couponCode=?, discountAmount=?, deliveryFee=?, platformFee=?, gstAmount=?, specialInstructions=?, deliveryAddress=?, estimatedDeliveryTime=? WHERE cartId=?";

	private static final String DELETE_CART =
			"DELETE FROM cart WHERE cartId=?";

	private static final String GET_ALL_CART =
			"SELECT * FROM cart";

	private static final String GET_CART_BY_USER_ID =
			"SELECT * FROM cart WHERE userId=? ORDER BY cartId DESC LIMIT 1";

	@Override
	public void addCart(Cart cart) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(ADD_CART);

			pstmt.setInt(1, cart.getUserId());
			pstmt.setString(2, cart.getCouponCode());
			pstmt.setDouble(3, cart.getDiscountAmount());
			pstmt.setDouble(4, cart.getDeliveryFee());
			pstmt.setDouble(5, cart.getPlatformFee());
			pstmt.setDouble(6, cart.getGstAmount());
			pstmt.setString(7, cart.getSpecialInstructions());
			pstmt.setString(8, cart.getDeliveryAddress());
			pstmt.setInt(9, cart.getEstimatedDeliveryTime());

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Cart getCart(int cartId) {

		Connection connection = DBConnection.getConnection();
		Cart cart = null;

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_CART);
			pstmt.setInt(1, cartId);

			ResultSet res = pstmt.executeQuery();

			if (res.next()) {
				cart = extractCart(res);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cart;
	}

	@Override
	public void updateCart(Cart cart) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_CART);

			pstmt.setInt(1, cart.getUserId());
			pstmt.setString(2, cart.getCouponCode());
			pstmt.setDouble(3, cart.getDiscountAmount());
			pstmt.setDouble(4, cart.getDeliveryFee());
			pstmt.setDouble(5, cart.getPlatformFee());
			pstmt.setDouble(6, cart.getGstAmount());
			pstmt.setString(7, cart.getSpecialInstructions());
			pstmt.setString(8, cart.getDeliveryAddress());
			pstmt.setInt(9, cart.getEstimatedDeliveryTime());
			pstmt.setInt(10, cart.getCartId());

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteCart(int cartId) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_CART);
			pstmt.setInt(1, cartId);

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Cart> getAllCart() {

		Connection connection = DBConnection.getConnection();
		List<Cart> cartList = new ArrayList<Cart>();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ALL_CART);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {
				cartList.add(extractCart(res));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cartList;
	}

	@Override
	public Cart getCartByUserId(int userId) {

		Connection connection = DBConnection.getConnection();
		Cart cart = null;

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_CART_BY_USER_ID);
			pstmt.setInt(1, userId);

			ResultSet res = pstmt.executeQuery();

			if (res.next()) {
				cart = extractCart(res);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cart;
	}

	private Cart extractCart(ResultSet res) throws SQLException {

		return new Cart(
				res.getInt("cartId"),
				res.getInt("userId"),
				res.getTimestamp("createdAt"),
				res.getTimestamp("updatedAt"),
				res.getString("couponCode"),
				res.getDouble("discountAmount"),
				res.getDouble("deliveryFee"),
				res.getDouble("platformFee"),
				res.getDouble("gstAmount"),
				res.getString("specialInstructions"),
				res.getString("deliveryAddress"),
				res.getInt("estimatedDeliveryTime")
		);
	}
}