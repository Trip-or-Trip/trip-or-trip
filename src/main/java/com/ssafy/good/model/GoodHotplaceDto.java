package com.ssafy.good.model;

public class GoodHotplaceDto {
	private int id;
	private int hotplaceId;
	private String userId;
	private String createdAt;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getHotplaceId() {
		return hotplaceId;
	}
	public void setHotplaceId(int hotplaceId) {
		this.hotplaceId = hotplaceId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	
	@Override
	public String toString() {
		return "GoodHotplaceDto [id=" + id + ", hotplaceId=" + hotplaceId + ", userId=" + userId + ", createdAt="
				+ createdAt + "]";
	}
}
