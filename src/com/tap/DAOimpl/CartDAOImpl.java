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
			"INSERT INTO cart (userId) VALUES (?)";

	private static final String GET_CART =
			"SELECT * FROM cart WHERE cartId = ?";

	private static final String UPDATE_CART =
			"UPDATE cart SET userId = ? WHERE cartId = ?";

	private static final String DELETE_CART =
			"DELETE FROM cart WHERE cartId = ?";

	private static final String GET_ALL_CART =
			"SELECT * FROM cart";

	private static final String GET_CART_BY_USER =
			"SELECT * FROM cart WHERE userId = ?";

	@Override
	public void addCart(Cart cart) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(ADD_CART);

			pstmt.setInt(1, cart.getUserId());

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
			pstmt.setInt(2, cart.getCartId());

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
	public Cart getCartByUser(int userId) {

		Connection connection = DBConnection.getConnection();
		Cart cart = null;

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_CART_BY_USER);

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
				res.getTimestamp("updatedAt")
		);
	}
}