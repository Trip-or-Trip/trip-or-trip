package com.ssafy.good.model;

public class GoodPlanDto {
	private int id;
	private int planId;
	private String userId;
	private String createdAt;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPlanId() {
		return planId;
	}
	public void setPlanId(int planId) {
		this.planId = planId;
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
		return "GoodPlanDto [id=" + id + ", planId=" + planId + ", userId=" + userId + ", createdAt=" + createdAt + "]";
	}
}
