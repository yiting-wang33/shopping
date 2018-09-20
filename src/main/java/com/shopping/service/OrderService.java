package edu.neu.csye6220.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.neu.csye6220.dao.OrderDao;
import edu.neu.csye6220.entity.Order;

@Service
public class OrderService {
	@Autowired
    private OrderDao OrderDao;
    public Order getOrder(int userId, int ItemId,String time) {
        return OrderDao.getOrder(userId,ItemId,time);
    }

    public void addOrder(Order shoppingRecord) {
    	OrderDao.addOrder(shoppingRecord);
    }

    public boolean deleteOrder(int userId, int productId) {
        return OrderDao.deleteOrder(userId,productId);
    }

    public boolean updateOrder(Order Order) {
        return OrderDao.updateOrder(Order);
    }


    public List<Order> getOrdersByUser(int UserId) {
        return OrderDao.getOrdersByUser(UserId);
    }


}
