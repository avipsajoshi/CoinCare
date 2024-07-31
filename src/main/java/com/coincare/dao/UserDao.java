package com.coincare.dao;

import com.coincare.entities.User;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;


public class UserDao {
  private SessionFactory factory;

  public UserDao(SessionFactory factory) {
    this.factory = factory;
  }

  //get user by email and password 
  public User getUserByEmailandPass(String email, String pass) {
    User user = null;
    try {
      //using Hibernate Query HQL
      String query = "From User WHERE userEmail = :e AND userPassword = :p";
      Session session = this.factory.openSession();
      List<User> results = session.createQuery(query, User.class)
              .setParameter("e", email)
              .setParameter("p", pass)
              .getResultList();
      if (!results.isEmpty()) {
        user = results.get(0);//returns single user object(row)
      }
      session.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return user;
  }
  
  public List<User> getUserByType(String type) {
    Session s = this.factory.openSession();
    Query q = s.createQuery("From User WHERE userType = :type", User.class);
    q.setParameter("type", type);
    List<User> list = q.list();
    return list;
  }
  public User getUserById(int uid) {
    User p = null;
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("from User as p WHERE p.userId =:pid", User.class);
      pq.setParameter("pid", uid);
      List<User> list = pq.list();
      if (!list.isEmpty()) {
        p = list.get(0);//returns single user object(row)
      }
      session.close();
    } catch (Exception w) {
      w.printStackTrace();

    }
    return p;
  }
  
  public boolean resetUserPassword(String userEmail, String userPassword){
    boolean success = false;
    Session session = this.factory.openSession();
    Transaction tx= session.beginTransaction();
    try{
      String hql = "update User as u SET u.userPassword=:pass WHERE u.userEmail=:mail";
      int rowCount = session.createMutationQuery(hql)
              .setParameter("pass", userPassword)
              .setParameter("mail", userEmail)
              .executeUpdate();
      System.out.println("Rows affected: " + rowCount);
      if (rowCount >= 1) {
        success = true;
      }
//      session.getTransaction().commit();
      tx.commit();
    }catch(Exception e){
      e.printStackTrace();
      tx.rollback();
      success=false;
    }finally{
      session.close();
    }
    return success;
  }
  
  public boolean updateUserProfile(){
    boolean success=false;
    return success;
  }
}
