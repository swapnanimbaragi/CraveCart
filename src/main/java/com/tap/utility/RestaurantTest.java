package com.tap.utility;

import java.sql.Time;
import java.util.List;
import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Restaurant;

public class RestaurantTest {

	public static void main(String[] args) {

		RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
//Add Resturant 
//		Restaurant restaurant = new Restaurant(
//				"Pizza Hut",
//				"https://example.com/pizza.jpg",
//				"Pizza",
//				30,
//				"Bangalore",
//				4.5,
//				true,
//				"Famous for Pizza",
//				Time.valueOf("10:00:00"),
//				Time.valueOf("11:00:00"),
//				"9872583610",
//				250.00,
//				30.00,
//				"Corn Pizza",
//				"Best Seller",
//				2
//				);
//
//		restaurantDAOImpl.addRestaurant(restaurant);
//
//		System.out.println("Restaurant Added Successfully");
//		
//		GET ONE RESTAURANT
//		Restaurant restaurant = restaurantDAOImpl.getRestaurant(1);
//		System.out.println(restaurant);


//		UPDATE RESTAURANT
//		Restaurant restaurant = restaurantDAOImpl.getRestaurant(1);
//
//		restaurant.setRestaurantName("Meghana Foods Updated");
//		restaurant.setRating(4.8);
//		restaurant.setDeliveryTime(25);
//		restaurant.setDeliveryFee(30.00);
//		restaurant.setSignatureDish("Special Chicken Biryani");
//
//		restaurantDAOImpl.updateRestaurant(restaurant);
//		System.out.println("Restaurant Updated Successfully");


//		DELETE RESTAURANT
//		restaurantDAOImpl.deleteRestaurant(2);
//		System.out.println("Restaurant Deleted Successfully");


//		GET ALL RESTAURANTS
		List<Restaurant> restaurants = restaurantDAOImpl.getAllRestaurant();

		for(Restaurant restaurant : restaurants) {
			System.out.println(restaurant);
		}
	}
}