package com.tap.model;

import java.sql.Timestamp;

public class CartItem {

	private int cartItemId;
	private int cartId;
	private int menuId;
	private int quantity;
	private Timestamp addedAt;

	public CartItem() {
	}

	public CartItem(int cartItemId, int cartId, int menuId, int quantity, Timestamp addedAt) {
		this.cartItemId = cartItemId;
		this.cartId = cartId;
		this.menuId = menuId;
		this.quantity = quantity;
		this.addedAt = addedAt;
	}

	public CartItem(int cartId, int menuId, int quantity) {
		this.cartId = cartId;
		this.menuId = menuId;
		this.quantity = quantity;
	}

	public int getCartItemId() { return cartItemId; }
	public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }

	public int getCartId() { return cartId; }
	public void setCartId(int cartId) { this.cartId = cartId; }

	public int getMenuId() { return menuId; }
	public void setMenuId(int menuId) { this.menuId = menuId; }

	public int getQuantity() { return quantity; }
	public void setQuantity(int quantity) { this.quantity = quantity; }

	public Timestamp getAddedAt() { return addedAt; }
	public void setAddedAt(Timestamp addedAt) { this.addedAt = addedAt; }

	@Override
	public String toString() {
		return "CartItem [cartItemId=" + cartItemId + ", cartId=" + cartId + ", menuId=" + menuId
				+ ", quantity=" + quantity + ", addedAt=" + addedAt + "]";
	}
}