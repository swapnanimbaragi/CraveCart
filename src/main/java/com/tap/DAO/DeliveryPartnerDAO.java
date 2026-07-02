package com.tap.DAO;

import java.util.List;
import com.tap.model.DeliveryPartner;

public interface DeliveryPartnerDAO {

	void addDeliveryPartner(DeliveryPartner partner);

	DeliveryPartner getDeliveryPartner(int deliveryPartnerId);

	void updateDeliveryPartner(DeliveryPartner partner);

	void deleteDeliveryPartner(int deliveryPartnerId);

	List<DeliveryPartner> getAllDeliveryPartners();
}