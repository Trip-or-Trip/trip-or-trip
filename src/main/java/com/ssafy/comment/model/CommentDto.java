package com.ssafy.comment.model;

public class CommentDto {
	private int id;
	private String content;
	private String createdAt;
	private int planId;
	private String userId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
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
	@Override
	public String toString() {
		return "CommentDto [id=" + id + ", content=" + content + ", createdAt=" + createdAt + ", planId=" + planId
				+ ", userId=" + userId + "]";
	}
}
