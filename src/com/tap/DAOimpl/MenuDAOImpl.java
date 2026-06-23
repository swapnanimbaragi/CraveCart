package com.tap.DAOimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.tap.DAO.MenuDAO;
import com.tap.model.Menu;
import com.tap.utility.DBConnection;

public class MenuDAOImpl implements MenuDAO {

	private static final String ADD_MENU =
			"INSERT INTO menu (restaurantId,itemName,description,price,category,imageUrl,isAvailable,isVeg,rating,isBestSeller,spiceLevel,portionSize,discountPercentage,isRecommended) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

	private static final String GET_MENU =
			"SELECT * FROM menu WHERE menuId=?";

	private static final String UPDATE_MENU =
			"UPDATE menu SET restaurantId=?,itemName=?,description=?,price=?,category=?,imageUrl=?,isAvailable=?,isVeg=?,rating=?,isBestSeller=?,spiceLevel=?,portionSize=?,discountPercentage=?,isRecommended=? WHERE menuId=?";

	private static final String DELETE_MENU =
			"DELETE FROM menu WHERE menuId=?";

	private static final String GET_ALL_MENU =
			"SELECT * FROM menu";

	private static final String GET_MENU_BY_RESTAURANT =
			"SELECT * FROM menu WHERE restaurantId=?";

	@Override
	public void addMenu(Menu menu) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(ADD_MENU);

			pstmt.setInt(1, menu.getRestaurantId());
			pstmt.setString(2, menu.getItemName());
			pstmt.setString(3, menu.getDescription());
			pstmt.setDouble(4, menu.getPrice());
			pstmt.setString(5, menu.getCategory());
			pstmt.setString(6, menu.getImageUrl());
			pstmt.setBoolean(7, menu.isAvailable());
			pstmt.setBoolean(8, menu.isVeg());
			pstmt.setDouble(9, menu.getRating());
			pstmt.setBoolean(10, menu.isBestSeller());
			pstmt.setString(11, menu.getSpiceLevel());
			pstmt.setString(12, menu.getPortionSize());
			pstmt.setDouble(13, menu.getDiscountPercentage());
			pstmt.setBoolean(14, menu.isRecommended());

			int i = pstmt.executeUpdate();

			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Menu getMenu(int menuId) {

		Connection connection = DBConnection.getConnection();
		Menu menu = null;

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_MENU);

			pstmt.setInt(1, menuId);

			ResultSet res = pstmt.executeQuery();

			if (res.next()) {
				menu = extractMenu(res);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return menu;
	}

	@Override
	public void updateMenu(Menu menu) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_MENU);

			pstmt.setInt(1, menu.getRestaurantId());
			pstmt.setString(2, menu.getItemName());
			pstmt.setString(3, menu.getDescription());
			pstmt.setDouble(4, menu.getPrice());
			pstmt.setString(5, menu.getCategory());
			pstmt.setString(6, menu.getImageUrl());
			pstmt.setBoolean(7, menu.isAvailable());
			pstmt.setBoolean(8, menu.isVeg());
			pstmt.setDouble(9, menu.getRating());
			pstmt.setBoolean(10, menu.isBestSeller());
			pstmt.setString(11, menu.getSpiceLevel());
			pstmt.setString(12, menu.getPortionSize());
			pstmt.setDouble(13, menu.getDiscountPercentage());
			pstmt.setBoolean(14, menu.isRecommended());
			pstmt.setInt(15, menu.getMenuId());

			int i = pstmt.executeUpdate();

			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteMenu(int menuId) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_MENU);

			pstmt.setInt(1, menuId);

			int i = pstmt.executeUpdate();

			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Menu> getAllMenu() {

		Connection connection = DBConnection.getConnection();
		List<Menu> menuList = new ArrayList<Menu>();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ALL_MENU);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {
				menuList.add(extractMenu(res));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return menuList;
	}

	@Override
	public List<Menu> getMenuByRestaurant(int restaurantId) {

		Connection connection = DBConnection.getConnection();
		List<Menu> menuList = new ArrayList<Menu>();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_MENU_BY_RESTAURANT);

			pstmt.setInt(1, restaurantId);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {
				menuList.add(extractMenu(res));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return menuList;
	}

	private Menu extractMenu(ResultSet res) throws SQLException {

		return new Menu(
				res.getInt("menuId"),
				res.getInt("restaurantId"),
				res.getString("itemName"),
				res.getString("description"),
				res.getDouble("price"),
				res.getString("category"),
				res.getString("imageUrl"),
				res.getBoolean("isAvailable"),
				res.getBoolean("isVeg"),
				res.getDouble("rating"),
				res.getBoolean("isBestSeller"),
				res.getString("spiceLevel"),
				res.getString("portionSize"),
				res.getDouble("discountPercentage"),
				res.getBoolean("isRecommended"),
				res.getTimestamp("createdAt"),
				res.getTimestamp("updatedAt"),
				res.getTimestamp("deletedAt")
		);
	}
}