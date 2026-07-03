package com.tap.DAOimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.DeliveryPartnerDAO;
import com.tap.model.DeliveryPartner;
import com.tap.utility.DBConnection;

public class DeliveryPartnerDAOImpl implements DeliveryPartnerDAO {

	private static final String ADD_PARTNER =
			"INSERT INTO delivery_partner "
			+ "(partnerName, email, phoneNumber, vehicleNumber, status, totalDeliveries, rating) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?)";

	private static final String GET_PARTNER =
			"SELECT * FROM delivery_partner WHERE deliveryPartnerId=?";

	private static final String UPDATE_PARTNER =
			"UPDATE delivery_partner SET partnerName=?, email=?, phoneNumber=?, vehicleNumber=?, "
			+ "status=?, totalDeliveries=?, rating=? WHERE deliveryPartnerId=?";

	private static final String DELETE_PARTNER =
			"DELETE FROM delivery_partner WHERE deliveryPartnerId=?";

	private static final String GET_ALL_PARTNERS =
			"SELECT * FROM delivery_partner";

	@Override
	public void addDeliveryPartner(DeliveryPartner partner) {
		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement pstmt = con.prepareStatement(ADD_PARTNER);

			pstmt.setString(1, partner.getPartnerName());
			pstmt.setString(2, partner.getEmail());
			pstmt.setString(3, partner.getPhoneNumber());
			pstmt.setString(4, partner.getVehicleNumber());
			pstmt.setString(5, partner.getStatus());
			pstmt.setInt(6, partner.getTotalDeliveries());
			pstmt.setDouble(7, partner.getRating());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public DeliveryPartner getDeliveryPartner(int deliveryPartnerId) {

		DeliveryPartner partner = null;

		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement pstmt = con.prepareStatement(GET_PARTNER);

			pstmt.setInt(1, deliveryPartnerId);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				partner = extractPartner(rs);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return partner;
	}

	@Override
	public void updateDeliveryPartner(DeliveryPartner partner) {
		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement pstmt = con.prepareStatement(UPDATE_PARTNER);

			pstmt.setString(1, partner.getPartnerName());
			pstmt.setString(2, partner.getEmail());
			pstmt.setString(3, partner.getPhoneNumber());
			pstmt.setString(4, partner.getVehicleNumber());
			pstmt.setString(5, partner.getStatus());
			pstmt.setInt(6, partner.getTotalDeliveries());
			pstmt.setDouble(7, partner.getRating());
			pstmt.setInt(8, partner.getDeliveryPartnerId());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteDeliveryPartner(int deliveryPartnerId) {
		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement pstmt = con.prepareStatement(DELETE_PARTNER);

			pstmt.setInt(1, deliveryPartnerId);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<DeliveryPartner> getAllDeliveryPartners() {

		List<DeliveryPartner> partners = new ArrayList<>();

		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement pstmt = con.prepareStatement(GET_ALL_PARTNERS);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				partners.add(extractPartner(rs));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return partners;
	}

	private DeliveryPartner extractPartner(ResultSet rs) throws Exception {

		return new DeliveryPartner(
				rs.getInt("deliveryPartnerId"),
				rs.getString("partnerName"),
				rs.getString("email"),
				rs.getString("phoneNumber"),
				rs.getString("vehicleNumber"),
				rs.getString("status"),
				rs.getInt("totalDeliveries"),
				rs.getDouble("rating")
		);
	}
	public void incrementDeliveryCount(int deliveryPartnerId) {

		String sql = "UPDATE delivery_partner SET totalDeliveries = totalDeliveries + 1 WHERE deliveryPartnerId=?";

		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, deliveryPartnerId);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}