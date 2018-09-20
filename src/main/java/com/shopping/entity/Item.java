package edu.neu.csye6220.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "Items")
public class Item {
	 private int ItemId;
	 private String Name;
	 private String Description;
	 private String Keyword;
	 private int Price;
	 private int Amount;
	 private int Type;
	 
	 @Id
	 @GenericGenerator(name = "", strategy = "")
	 @GeneratedValue(generator = "")
	 
	 @Column(name = "ItemId")
	public int getItemId() {
		return ItemId;
	}
	public void setItemId(int itemId) {
		ItemId = itemId;
	}
	
	@Column(name = "Name")
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	
	@Column(name = "Description")
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	
	@Column(name = "KeyWord")
	public String getKeyWord() {
		return Keyword;
	}
	public void setKeyWord(String keyWord) {
		this.Keyword = keyWord;
	}
	
	@Column(name = "Price")
	public int getPrice() {
		return Price;
	}
	public void setPrice(int price) {
		Price = price;
	}
	
	@Column(name = "Amount")
	public int getAmount() {
		return Amount;
	}
	public void setAmount(int amount) {
		Amount = amount;
	}
	
	@Column(name = "Type")
	public int getType() {
		return Type;
	}
	public void setType(int type) {
		Type = type;
	}
	 
	 
}
