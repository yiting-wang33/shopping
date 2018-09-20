package edu.neu.csye6220.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="Order")
public class Order {
	
	private int UserId;
    private int ItemId;
    private String time;
    private int Status;
    private int Price;
    private int Amount;
    
    @Id
    @Column(name="UserId")
	public int getUserId() {
		return UserId;
	}
	public void setUserId(int userId) {
		UserId = userId;
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
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
	@Id
	@Column(name="Status")
	public int getStatus() {
		return Status;
	}
	public void setStatus(int status) {
		Status = status;
	}
	
	@Id
	@Column(name="Price")
	public int getPrice() {
		return Price;
	}
	public void setPrice(int price) {
		Price = price;
	}
	
	@Id
	@Column(name="Amount")
	public int getAmount() {
		return Amount;
	}
	public void setAmount(int amount) {
		Amount = amount;
	}

}
