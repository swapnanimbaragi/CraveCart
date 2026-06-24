package com.tap.DAO;

import java.util.List;

import com.tap.model.Cart;

public interface CartDAO {

	void addCart(Cart cart);
	Cart getCart(int cartId);
	void updateCart(Cart cart);
	void deleteCart(int cartId);
	List<Cart> getAllCart();
	Cart getCartByUser(int userId);
}
