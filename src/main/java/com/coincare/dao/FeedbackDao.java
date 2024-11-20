package com.coincare.dao;

import com.coincare.entities.Feedback;
import com.coincare.entities.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class FeedbackDao {

  private SessionFactory factory;

  public FeedbackDao(SessionFactory factory) {
    this.factory = factory;
  }

  // Method to add feedback
  public boolean addFeedback(Feedback feedback) {
    boolean status = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      session.persist(feedback);
      tx.commit();
      status = true;
    } catch (Exception e) {
      e.printStackTrace();
      tx.rollback();
    } finally {
      session.close();
    }
    return status;
  }

  // Method to retrieve feedback by feedbackId
  public Feedback getFeedbackById(int feedbackId) {
    Feedback feedback = null;
    try {
      Session session = this.factory.openSession();
      feedback = session.get(Feedback.class, feedbackId);
      session.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return feedback;
  }

  // Method to retrieve feedbacks by userId
  public List<Feedback> getFeedbackByUserId(int userId) {
    List<Feedback> feedbackList = null;
    Session session = this.factory.openSession();
    try {
      Query<Feedback> query = session.createQuery("from Feedback as f WHERE f.user.userId=:uid", Feedback.class);
      query.setParameter("uid", userId);
      feedbackList = query.list();
      session.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return feedbackList;
  }
  
  // Method to retrieve feedbacks by userId
  public List<Feedback> getAllFeedback() {
    List<Feedback> feedbackList = null;
    Session session = this.factory.openSession();
    try {
      Query<Feedback> query = session.createQuery("from Feedback ORDER BY feedbackId desc", Feedback.class);
      feedbackList = query.list();
      session.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return feedbackList;
  }

  // Method to update feedback description
  public boolean updateFeedbackDescription(int feedbackId, String newDescription) {
    boolean status = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      Query query = session.createQuery("update Feedback set feedbackDescription=:desc where feedbackId=:fid", Feedback.class);
      query.setParameter("desc", newDescription);
      query.setParameter("fid", feedbackId);
      int rowCount = query.executeUpdate();
      if (rowCount >= 1) {
        status = true;
      }
      tx.commit();
    } catch (Exception e) {
      e.printStackTrace();
      tx.rollback();
    } finally {
      session.close();
    }
    return status;
  }

  // Method to delete feedback by feedbackId
  public boolean deleteFeedbackById(int feedbackId) {
    boolean status = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      Query query = session.createQuery("delete from Feedback where feedbackId=:fid", Feedback.class);
      query.setParameter("fid", feedbackId);
      int rowCount = query.executeUpdate();
      if (rowCount >= 1) {
        status = true;
      }
      tx.commit();
    } catch (Exception e) {
      e.printStackTrace();
      tx.rollback();
    } finally {
      session.close();
    }
    return status;
  }
}
