package com.tap.DAOimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.CartItemDAO;
import com.tap.model.CartItem;
import com.tap.utility.DBConnection;

public class CartItemDAOImpl implements CartItemDAO {

	private static final String ADD_CART_ITEM =
			"INSERT INTO cartitem (cartId, menuId, quantity, itemTotal, isSavedForLater) VALUES (?,?,?,?,?)";

	private static final String GET_CART_ITEM =
			"SELECT * FROM cartitem WHERE cartItemId=?";

	private static final String UPDATE_CART_ITEM =
			"UPDATE cartitem SET cartId=?, menuId=?, quantity=?, itemTotal=?, isSavedForLater=? WHERE cartItemId=?";

	private static final String DELETE_CART_ITEM =
			"DELETE FROM cartitem WHERE cartItemId=?";

	private static final String GET_ALL_CART_ITEMS =
			"SELECT * FROM cartitem";

	private static final String GET_CART_ITEMS_BY_CART_ID =
			"SELECT * FROM cartitem WHERE cartId=?";
	
	private static final String GET_CART_ITEM_BY_CART_AND_MENU =
	        "SELECT * FROM cartitem WHERE cartId=? AND menuId=?";

	@Override
	public void addCartItem(CartItem cartItem) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(ADD_CART_ITEM);

			pstmt.setInt(1, cartItem.getCartId());
			pstmt.setInt(2, cartItem.getMenuId());
			pstmt.setInt(3, cartItem.getQuantity());
			pstmt.setDouble(4, cartItem.getItemTotal());
			pstmt.setBoolean(5, cartItem.isSavedForLater());

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public CartItem getCartItem(int cartItemId) {

		Connection connection = DBConnection.getConnection();
		CartItem cartItem = null;

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_CART_ITEM);

			pstmt.setInt(1, cartItemId);

			ResultSet res = pstmt.executeQuery();

			if (res.next()) {
				cartItem = extractCartItem(res);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cartItem;
	}

	@Override
	public void updateCartItem(CartItem cartItem) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_CART_ITEM);

			pstmt.setInt(1, cartItem.getCartId());
			pstmt.setInt(2, cartItem.getMenuId());
			pstmt.setInt(3, cartItem.getQuantity());
			pstmt.setDouble(4, cartItem.getItemTotal());
			pstmt.setBoolean(5, cartItem.isSavedForLater());
			pstmt.setInt(6, cartItem.getCartItemId());

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteCartItem(int cartItemId) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_CART_ITEM);

			pstmt.setInt(1, cartItemId);

			int i = pstmt.executeUpdate();

			System.out.println(i);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<CartItem> getAllCartItems() {

		Connection connection = DBConnection.getConnection();
		List<CartItem> cartItemList = new ArrayList<CartItem>();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ALL_CART_ITEMS);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {
				cartItemList.add(extractCartItem(res));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cartItemList;
	}

	@Override
	public List<CartItem> getCartItemsByCartId(int cartId) {

		Connection connection = DBConnection.getConnection();
		List<CartItem> cartItemList = new ArrayList<CartItem>();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_CART_ITEMS_BY_CART_ID);

			pstmt.setInt(1, cartId);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {
				cartItemList.add(extractCartItem(res));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cartItemList;
	}
	
	@Override
	public CartItem getCartItemByCartIdAndMenuId(int cartId, int menuId) {

	    Connection connection = DBConnection.getConnection();
	    CartItem cartItem = null;

	    try {
	        PreparedStatement pstmt =
	                connection.prepareStatement(GET_CART_ITEM_BY_CART_AND_MENU);

	        pstmt.setInt(1, cartId);
	        pstmt.setInt(2, menuId);

	        ResultSet res = pstmt.executeQuery();

	        if (res.next()) {
	            cartItem = extractCartItem(res);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return cartItem;
	}

	private CartItem extractCartItem(ResultSet res) throws SQLException {

		return new CartItem(
				res.getInt("cartItemId"),
				res.getInt("cartId"),
				res.getInt("menuId"),
				res.getInt("quantity"),
				res.getTimestamp("addedAt"),
				res.getDouble("itemTotal"),
				res.getBoolean("isSavedForLater")
		);
	}
	
	
}