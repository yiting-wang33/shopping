package edu.neu.csye6220.entity;

import java.io.Serializable;


public class OrderPK implements Serializable{
	
	private int userId;
    private int ItemId;
    private String time;
    
	 public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getItemId() {
		return ItemId;
	}

	public void setItemId(int itemId) {
		ItemId = itemId;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	@Override
	    public boolean equals(Object o) {
	        if (this == o) return true;
	        if (!(o instanceof OrderPK)) return false;

	        OrderPK that = (OrderPK) o;

	        if (getUserId() != that.getUserId()) return false;
	        if (getItemId() != that.getItemId()) return false;
	        return getTime().equals(that.getTime());

	    }

	    @Override
	    public int hashCode() {
	        int result = getUserId();
	        result = 31 * result + getItemId();
	        result = 31 * result + getTime().hashCode();
	        return result;
	    }
    
    

}
