package edu.neu.csye6220.entity;

import java.io.Serializable;


public class CartPK  implements Serializable{
	private int UserId;
	private int ItemId;
	public int getUserId() {
		return UserId;
	}
	public void setUserId(int userId) {
		UserId = userId;
	}
	public int getItemId() {
		return ItemId;
	}
	public void setItemId(int itemId) {
		ItemId = itemId;
	}
	
	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (!(o instanceof CartPK)) return false;

		CartPK that = (CartPK) o;

	    if (UserId != that.UserId) return false;
	    return ItemId == that.ItemId;

	}

	@Override
	public int hashCode() {
	    int result = UserId;
	    result = 31 * result + ItemId;
	    return result;
	}

}
