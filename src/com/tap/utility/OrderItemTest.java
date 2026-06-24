package com.tap.utility;

import java.util.List;

import com.tap.DAOimpl.OrderItemDAOImpl;
import com.tap.model.OrderItem;

public class OrderItemTest 
{

	public static void main(String[] args) 
	{

		OrderItemDAOImpl orderItemDAOImpl = new OrderItemDAOImpl();


//		ADD ORDER ITEM
//		OrderItem orderItem = new OrderItem(
//				2,
//				1,
//				2,
//				400.00,
//				800.00,
//				"Less spicy",
//				4.5,
//				"Very tasty"
//		);
//
//		orderItemDAOImpl.addOrderItem(orderItem);
//		System.out.println("Order Item Added Successfully");



//		GET ONE ORDER ITEM
//		OrderItem orderItem = orderItemDAOImpl.getOrderItem(1);
//		System.out.println(orderItem);



//		UPDATE ORDER ITEM
//		OrderItem orderItem = orderItemDAOImpl.getOrderItem(1);
//
//		orderItem.setQuantity(3);
//		orderItem.setSubtotal(897.00);
//		orderItem.setSpecialRequest("Extra spicy");
//		orderItem.setItemRating(4.8);
//		orderItem.setItemReview("Excellent taste");
//
//		orderItemDAOImpl.updateOrderItem(orderItem);
//		System.out.println("Order Item Updated Successfully");



//		DELETE ORDER ITEM
//		orderItemDAOImpl.deleteOrderItem(1);
//		System.out.println("Order Item Deleted Successfully");



//		GET ALL ORDER ITEMS
//		List<OrderItem> orderItems = orderItemDAOImpl.getAllOrderItem();
//
//		for(OrderItem orderItem : orderItems) 
//		{
//			System.out.println(orderItem);
//		}


		

//		GET ORDER ITEMS BY ORDER ID
//		List<OrderItem> orderItems = orderItemDAOImpl.getOrderItemsByOrder(1);
//
//		for(OrderItem orderItem : orderItems) {
//			System.out.println(orderItem);
//		}
	}
}
