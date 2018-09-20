package edu.neu.csye6220.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.neu.csye6220.dao.*;
import edu.neu.csye6220.entity.Review;
@Service
public class ReviewService {
	  @Autowired
	  private ReviewDao ReviewDao;
	  
	  public Review getReview(int UserId, int ItemId, String time) {
	        return ReviewDao.getReview(UserId,ItemId,time);
	  }

	    public void addReviewn(Review Review) {
	    	ReviewDao.addReview(Review);
	    }

	    public boolean deleteReview(int userId, int ItemId, String time) {
	        return ReviewDao.deleteReview(userId,ItemId,time);
	    }

	    public boolean updateReview(Review Review) {
	        return ReviewDao.updateReview(Review);
	    }

	    public List<Review> getItemReview(int ItemId) {
	        return ReviewDao.getItemReview(ItemId);
	    }

}
