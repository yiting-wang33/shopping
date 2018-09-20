package edu.neu.csye6220.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.neu.csye6220.dao.*;
import edu.neu.csye6220.entity.Cart;

@Service
public class CartService {
	
	 @Autowired
	 private CartDao CartDao;
	 
	    public Cart getCart(int UserId, int ItemId) {
	        return CartDao.getCart(UserId,ItemId);
	    }

	    public void addShoppingCar(Cart Cart) {
	    	CartDao.addCart(Cart);
	    }

	    public boolean deleteCart(int userId, int productId) {
	        return CartDao.deleteCart(userId,productId);
	    }

	    public boolean updateCart(Cart Cart) {
	        return CartDao.updateCart(Cart);
	    }

	    public List<Cart> getCarts(int UserId) {
	        return CartDao.getCarts(UserId);
	    }

}
