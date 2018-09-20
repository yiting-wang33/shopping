package edu.neu.csye6220.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.neu.csye6220.dao.CartDao;
import edu.neu.csye6220.dao.OrderDao;
import edu.neu.csye6220.dao.ReviewDao;
import edu.neu.csye6220.dao.UserDao;
import edu.neu.csye6220.entity.User;

@Service
public class UserService {
	@Autowired
    private UserDao userDao;
    @Autowired
    private OrderDao shoppingRecordDao;
    @Autowired
    private CartDao cartDao;
    @Autowired
    private ReviewDao reviewDao;
    
    public User getUser(int UserId) {
        return userDao.getUser(UserId);
    }

    public User getUser(String Email) {
        return userDao.getUser(Email);
    }

    public void addUser(User user) {
        userDao.addUser(user);
    }
    
    public boolean updateUser(User user) {
        return userDao.updateUser(user);
    }

    public List<User> getAllUser() {
        return userDao.getAllUser();
    }
    
    

}
