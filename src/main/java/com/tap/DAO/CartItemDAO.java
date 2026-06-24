package com.tap.DAO;

import java.util.List;

import com.tap.model.CartItem;

public interface CartItemDAO {

	void addCartItem(CartItem cartItem);
	CartItem getCartItem(int cartItemId);
	void updateCartItem(CartItem cartItem);
	void deleteCartItem(int cartItemId);
	List<CartItem> getAllCartItem();
	List<CartItem> getCartItemsByCart(int cartId);
}