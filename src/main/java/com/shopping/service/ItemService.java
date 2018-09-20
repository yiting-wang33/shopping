package edu.neu.csye6220.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import edu.neu.csye6220.dao.*;
import edu.neu.csye6220.entity.Item;
import edu.neu.csye6220.util.Response;

public class ItemService {
	
	@Autowired
    private ItemDao ItemDao;
    @Autowired
    private OrderDao OrderDao;
    @Autowired
    private CartDao CartDao;
    @Autowired
    private ReviewDao ReviewDao;
    
    public Item getItem(int ItemId) {
        return ItemDao.getItem(ItemId);
    }

    public Item getItem(String Name) {
        return ItemDao.getItem(Name);
    }

    public void addItem(Item Item) {
    	ItemDao.addItem(Item);
    }
    
    public boolean updateItem(Item Item) {
        return ItemDao.updateItem(Item);
    }

    public List<Item> getItemByKeyWord(String searchKeyWord) {
        return ItemDao.getItemByKeyWord(searchKeyWord);
    }

    public List<Item> getItemByType(int type) {
        return ItemDao.getItemByType(type);
    }

    public List<Item> getAllItems() {
        return ItemDao.getAllItems();
    }
    
    @Transactional
    public Response deleteProduct(int ItemId) {
        try {
            ReviewDao.deleteReviewByItem(ItemId);
            CartDao.deleteCartByItem(ItemId);
            OrderDao.deleteOrderByItem(ItemId);
            ItemDao.deleteItem(ItemId);
            return new Response(1, "Delete Item Successfully!", null);
        }catch (Exception e){
            return new Response(0,"Delete Item Successfully!",null);
        }
    }
    
    
}
