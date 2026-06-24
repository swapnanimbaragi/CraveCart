package com.tap.utility;

import java.util.List;

import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.model.Order;

public class OrderTest {

	public static void main(String[] args) {

		OrderDAOImpl orderDAOImpl = new OrderDAOImpl();


//		ADD ORDER
//		Order order = new Order(
//				1,
//				1,
//				650.00,
//				"UPI",
//				"Pending",
//				"Bagalkot, Karnataka",
//				"Less spicy please",
//				"NEWUSER50",
//				50.00,
//				40.00,
//				30
//		);
//
//		orderDAOImpl.addOrder(order);
//		System.out.println("Order Added Successfully");



//		GET ONE ORDER
//		Order order = orderDAOImpl.getOrder(1);
//		System.out.println(order);



//		UPDATE ORDER
//		Order order = orderDAOImpl.getOrder(1);
//
//		order.setOrderStatus("Delivered");
//		order.setPaymentMode("Card");
//		order.setEstimatedDeliveryTime(25);
//
//		orderDAOImpl.updateOrder(order);
//
//		System.out.println("Order Updated Successfully");



//		DELETE ORDER
//		orderDAOImpl.deleteOrder(1);
//
//		System.out.println("Order Deleted Successfully");



//		GET ALL ORDERS
//		List<Order> orders = orderDAOImpl.getAllOrder();
//
//		for(Order order : orders) {
//			System.out.println(order);
//		}



//		GET ORDERS BY USER ID
//		List<Order> orders = orderDAOImpl.getOrdersByUser(1);
//
//		for(Order order : orders) {
//			System.out.println(order);
//		}
	}
}