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

  //all users
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

  public boolean resetUserPassword(String userEmail, String userPassword) {
    boolean success = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
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
    } catch (Exception e) {
      e.printStackTrace();
      tx.rollback();
      success = false;
    } finally {
      session.close();
    }
    return success;
  }

  public User getUserByUser(User user) {
    User user1 = null;
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("from User as u WHERE u.userEmail=:email", User.class);
      pq.setParameter("email", user.getUserEmail());
      List<User> list = pq.list();
      if (!list.isEmpty()) {
        user1 = list.get(0);//returns single user object(row)
      }
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return user1;
  }

  public User getUseByEmail(String email) {
    User user = null;
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("from User as u WHERE u.userEmail=:email", User.class);
      pq.setParameter("email", email);
      List<User> list = pq.list();
      if (!list.isEmpty()) {
        user = list.get(0);//returns single user object(row)
      }
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return user;
  }

  public boolean updateUserProfile(String email, String name, int year, int month, int day, String country) {
    boolean status = false;
    User user = this.getUseByEmail(email);
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update User as u SET u.userName=:name, u.userDobYear=:year, u.userDobMonth=:month, u.userDobDay=:day, u.userCountry=:country  WHERE u.userEmail=:mail";
      rowCount = session.createMutationQuery(hql)
              .setParameter("mail", email)
              .setParameter("name", name)
              .setParameter("year", year)
              .setParameter("month", month)
              .setParameter("day", day)
              .setParameter("country", country)
              .executeUpdate();
      System.out.println("Rows affected: " + rowCount);
      if (rowCount >= 1) {
        status = true;
      }
      tx.commit();
    } catch (Exception e) {
      e.printStackTrace();
      tx.rollback();
      status = false;
    } finally {
      session.close();
    }
    return status;
  }

  public boolean updateUserPicture(String email, String filepath) {
    boolean status = false;
    User user = this.getUseByEmail(email);
    int userId = user.getUserId();
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update User as u SET u.userPic=:file  WHERE u.userId=:id";
      rowCount = session.createMutationQuery(hql)
              .setParameter("id", userId)
              .setParameter("file", filepath)
              .executeUpdate();
      System.out.println("Rows affected: " + rowCount);
      if (rowCount >= 1) {
        status = true;
      }
      tx.commit();
    } catch (Exception e) {
      e.printStackTrace();
      tx.rollback();
      status = false;
    } finally {
      session.close();
    }
    return status;
  }
  
  
  public boolean updateUserType(String type, int userId) {
    boolean status = false;
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update User as u SET u.userType=:type  WHERE u.userId=:id";
      rowCount = session.createMutationQuery(hql)
              .setParameter("type", type)
              .setParameter("id", userId)
              .executeUpdate();
      System.out.println("Rows affected: " + rowCount);
      if (rowCount >= 1) {
        status = true;
      }
      tx.commit();
    } catch (Exception e) {
      e.printStackTrace();
      tx.rollback();
      status = false;
    } finally {
      session.close();
    }
    return status;
  }
  

  //will get a field through which status of the field will be toggled but not for email verification
  public boolean toggleUserNotificationSettings(String email, String field) {
    boolean status = false;
    User user = this.getUseByEmail(email);
    String hql, prev, changed = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      if (field.equals("statement")) {
        prev = user.isEnableReportNotification();
        if (prev.equals("on")) {
          changed = "off";
        } else if (prev.equals("off")) {
          changed = "on";
        }
        hql = "update User as u SET u.enableReportNotification=:change WHERE u.userEmail=:mail";
        rowCount = session.createMutationQuery(hql)
                .setParameter("mail", email)
                .setParameter("change", changed)
                .executeUpdate();
      } else if (field.equals("tips")) {
        prev = user.getEnableTipsNotification();
        if (prev.equals("on")) {
          changed = "off";
        } else if (prev.equals("off")) {
          changed = "on";
        }
        hql = "update User as u SET u.enableTipsNotification=:change WHERE u.userEmail=:mail";
        rowCount = session.createMutationQuery(hql)
                .setParameter("mail", email).setParameter("change", changed)
                .executeUpdate();
      } else if (field.equals("verify")) {
        prev = user.getUserVerify();
        if (prev.equals("Verify")) {
          changed = "Verified";
        }
        hql = "update User as u SET u.userVerify=:change WHERE u.userEmail=:mail";
        rowCount = session.createMutationQuery(hql)
                .setParameter("mail", email).setParameter("change", changed)
                .executeUpdate();
      }
      System.out.println("Rows affected: " + rowCount);
      if (rowCount >= 1) {
        status = true;
      }
      tx.commit();
    } catch (Exception e) {
      e.printStackTrace();
      tx.rollback();
      status = false;
    } finally {
      session.close();
    }
    return status;
  }
}
