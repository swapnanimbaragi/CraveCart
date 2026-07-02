package com.tap.DAOimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.tap.DAO.AdminDAO;
import com.tap.model.User;
import com.tap.utility.DBConnection;

public class AdminDAOImpl implements AdminDAO {

    private static final String ADMIN_LOGIN =
        "SELECT * FROM user WHERE email=? AND password=? AND role='ADMIN'";

    @Override
    public User adminLogin(String email, String password) {

        User user = null;

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstmt = con.prepareStatement(ADMIN_LOGIN);

            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();

                user.setUserId(rs.getInt("userId"));
                user.setUserName(rs.getString("userName"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setAddress(rs.getString("address"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}