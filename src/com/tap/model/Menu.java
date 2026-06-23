package com.tap.model;

import java.sql.Timestamp;

public class Menu {

	private int menuId;
	private int restaurantId;
	private String itemName;
	private String description;
	private double price;
	private String category;
	private String imageUrl;
	private boolean isAvailable;
	private boolean isVeg;
	private double rating;
	private boolean isBestSeller;
	private String spiceLevel;
	private String portionSize;
	private double discountPercentage;
	private boolean isRecommended;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private Timestamp deletedAt;

	public Menu() {
	}

	public Menu(int menuId, int restaurantId, String itemName, String description, double price, String category,
			String imageUrl, boolean isAvailable, boolean isVeg, double rating, boolean isBestSeller,
			String spiceLevel, String portionSize, double discountPercentage, boolean isRecommended,
			Timestamp createdAt, Timestamp updatedAt, Timestamp deletedAt) {
		this.menuId = menuId;
		this.restaurantId = restaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.category = category;
		this.imageUrl = imageUrl;
		this.isAvailable = isAvailable;
		this.isVeg = isVeg;
		this.rating = rating;
		this.isBestSeller = isBestSeller;
		this.spiceLevel = spiceLevel;
		this.portionSize = portionSize;
		this.discountPercentage = discountPercentage;
		this.isRecommended = isRecommended;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.deletedAt = deletedAt;
	}

	public Menu(int restaurantId, String itemName, String description, double price, String category,
			String imageUrl, boolean isAvailable, boolean isVeg, double rating, boolean isBestSeller,
			String spiceLevel, String portionSize, double discountPercentage, boolean isRecommended) {
		this.restaurantId = restaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.category = category;
		this.imageUrl = imageUrl;
		this.isAvailable = isAvailable;
		this.isVeg = isVeg;
		this.rating = rating;
		this.isBestSeller = isBestSeller;
		this.spiceLevel = spiceLevel;
		this.portionSize = portionSize;
		this.discountPercentage = discountPercentage;
		this.isRecommended = isRecommended;
	}

	public int getMenuId() { return menuId; }
	public void setMenuId(int menuId) { this.menuId = menuId; }

	public int getRestaurantId() { return restaurantId; }
	public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

	public String getItemName() { return itemName; }
	public void setItemName(String itemName) { this.itemName = itemName; }

	public String getDescription() { return description; }
	public void setDescription(String description) { this.description = description; }

	public double getPrice() { return price; }
	public void setPrice(double price) { this.price = price; }

	public String getCategory() { return category; }
	public void setCategory(String category) { this.category = category; }

	public String getImageUrl() { return imageUrl; }
	public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

	public boolean isAvailable() { return isAvailable; }
	public void setAvailable(boolean isAvailable) { this.isAvailable = isAvailable; }

	public boolean isVeg() { return isVeg; }
	public void setVeg(boolean isVeg) { this.isVeg = isVeg; }

	public double getRating() { return rating; }
	public void setRating(double rating) { this.rating = rating; }

	public boolean isBestSeller() { return isBestSeller; }
	public void setBestSeller(boolean isBestSeller) { this.isBestSeller = isBestSeller; }

	public String getSpiceLevel() { return spiceLevel; }
	public void setSpiceLevel(String spiceLevel) { this.spiceLevel = spiceLevel; }

	public String getPortionSize() { return portionSize; }
	public void setPortionSize(String portionSize) { this.portionSize = portionSize; }

	public double getDiscountPercentage() { return discountPercentage; }
	public void setDiscountPercentage(double discountPercentage) { this.discountPercentage = discountPercentage; }

	public boolean isRecommended() { return isRecommended; }
	public void setRecommended(boolean isRecommended) { this.isRecommended = isRecommended; }

	public Timestamp getCreatedAt() { return createdAt; }
	public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

	public Timestamp getUpdatedAt() { return updatedAt; }
	public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

	public Timestamp getDeletedAt() { return deletedAt; }
	public void setDeletedAt(Timestamp deletedAt) { this.deletedAt = deletedAt; }

	@Override
	public String toString() {
		return "Menu [menuId=" + menuId + ", restaurantId=" + restaurantId + ", itemName=" + itemName
				+ ", price=" + price + ", category=" + category + ", isAvailable=" + isAvailable
				+ ", isVeg=" + isVeg + ", rating=" + rating + ", isBestSeller=" + isBestSeller
				+ ", spiceLevel=" + spiceLevel + ", portionSize=" + portionSize
				+ ", discountPercentage=" + discountPercentage + ", isRecommended=" + isRecommended + "]";
	}
}