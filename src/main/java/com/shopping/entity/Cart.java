package edu.neu.csye6220.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

@Entity
@Table(name="Cart")
@IdClass(value=CartPK.class)
public class Cart {
	private int UserId;
    private int ItemId;
    private int Price;
    private int Amount;
    
    @Id
    @Column(name="User_Id")
	public int getUserId() {
		return UserId;
	}
	public void setUserId(int userId) {
		UserId = userId;
	}
	
	@Id
    @Column(name="Item_Id")
	public int getItemId() {
		return ItemId;
	}
	public void setItemId(int itemId) {
		ItemId = itemId;
	}
	
	@Column(name="Item_Price")
	public int getPrice() {
		return Price;
	}
	public void setPrice(int price) {
		Price = price;
	}
	
	@Column(name="Item_Amount")
	public int getAmount() {
		return Amount;
	}
	public void setAmount(int amount) {
		Amount = amount;
	}
    
    
	
}
