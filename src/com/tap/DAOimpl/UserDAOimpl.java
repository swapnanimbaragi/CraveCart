package com.tap.DAOimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import com.tap.DAO.UserDAO;
import com.tap.model.User;
import com.tap.utility.DBConnection;

public class UserDAOimpl implements UserDAO {

	String INSERT_QUERY = "INSERT INTO user(userName,email,password,address,role,createdDate,lastLoginDate) "
			+ "VALUES(?,?,?,?,?,?,?)";

	@Override
	public void addUser(User user) {
		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(INSERT_QUERY);

			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getAddress());
			pstmt.setString(5, user.getRole());
			pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pstmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));

			int i = pstmt.executeUpdate();
			System.out.println(i);
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public User getUser(int userId) {
		return null;
	}

	@Override
	public void updateUser(User user) {
		
	}

	@Override
	public void deleteUser(int userId) {
		
	}

	@Override
	public List<User> getAllUser() {
		return null;
	}
}