package edu.neu.csye6220.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;


@Entity
@Table(name="Review")
@IdClass(value=OrderPK.class)
public class Review {
	
	 private int userId;
	 private int ItemId;
	 private String Time;
	 private String Content;
	 
	@Id
    @Column(name="UserId")
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	@Id
    @Column(name="ItemId")
	public int getItemId() {
		return ItemId;
	}
	public void setItemId(int itemId) {
		ItemId = itemId;
	}
	
	@Id
    @Column(name="Time")
	public String getTime() {
		return Time;
	}
	public void setTime(String time) {
		Time = time;
	}
	
	@Column(name="Content")
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	 
	 
	 

}
