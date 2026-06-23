package com.tap.DAOimpl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.UserDAO;
import com.tap.model.User;
import com.tap.utility.DBConnection;

public class UserDAOimpl implements UserDAO {

	String INSERT_QUERY = "INSERT INTO user(userName,email,password,address,role,createdDate,lastLoginDate) "
			+ "VALUES(?,?,?,?,?,?,?)";
	
	String GET_QUERY = "SELECT * FROM User where userId= ? ";

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
		User user=null;
		Connection connection = DBConnection.getConnection();
		try 
		{
			PreparedStatement pstmt = connection.prepareStatement(GET_QUERY);
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				int id=rs.getInt("userId");
				String name=rs.getString("userName");
				String email=rs.getString("email");
				String password=rs.getString("password");
				String address=rs.getString("address");
				String role=rs.getString("role");
				Timestamp createdDate = rs.getTimestamp("createdDate");
				Timestamp lastLoginDate = rs.getTimestamp("lastLoginDate");
				
				
				user=new User(id,name,email,password,address,role,createdDate,lastLoginDate);
			}
			return user;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	
	@Override
	public void updateUser(User user) {

		String UPDATE_USER = "UPDATE user SET userName=?, password=?, email=?, address=?, lastLoginDate=? "
				+ "WHERE userId=?";

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_USER);

			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getAddress());
			pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
			pstmt.setInt(6, user.getUserId());

			int i = pstmt.executeUpdate();
			System.out.println(i);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteUser(int userId) {
		String DELETE_USER = "DELETE FROM user WHERE userId=?";
		
		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_USER);

			pstmt.setInt(1, userId);

			int i = pstmt.executeUpdate();

			System.out.println(i);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<User> getAllUser() 
	{
		String GET_ALL_USER = "SELECT * FROM user";
		ArrayList<User> list = new ArrayList<User>();

		Connection connection = DBConnection.getConnection();

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(GET_ALL_USER);

			while (rs.next()) {
				User user = extractUserFromResultSet(rs);
				list.add(user);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public static User extractUserFromResultSet(ResultSet rs) throws SQLException
	{
		int id = rs.getInt("userId");
		String name = rs.getString("userName");
		String email = rs.getString("email");
		String password = rs.getString("password");
		String address = rs.getString("address");
		String role = rs.getString("role");
		Timestamp createdDate = rs.getTimestamp("createdDate");
		Timestamp lastLoginDate = rs.getTimestamp("lastLoginDate");

		User user = new User(id, name, email, password, address, role, createdDate, lastLoginDate);
		return user;
	}
}