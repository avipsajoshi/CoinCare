package com.coincare.dao;

import com.coincare.entities.Admin;
import com.coincare.entities.BudgetPlan;
import com.coincare.entities.User;
import com.coincare.entities.UserFinancials;
import com.coincare.helper.HashPassword;
import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.HashMap;
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
      String query = "From User WHERE userEmail = :e";
      Session session = this.factory.openSession();
      List<User> results = session.createQuery(query, User.class)
              .setParameter("e", email)
              .getResultList();
      if (!results.isEmpty()) {
        user = results.get(0);//returns single user object(row)
        if (HashPassword.verifyPassword(pass, user.getUserPassword())) {
          return user;
        }
      }
      session.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return user;
  }

  //all users
  public List<User> getUserByType(String type) {
    List<User> list = new ArrayList<>();

    Session s = this.factory.openSession();
    Query q = s.createQuery("From User WHERE userType = :type", User.class);
    q.setParameter("type", type);
    list = q.list();
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

  public List<UserFinancials> getUserReportForToday(int userId, LocalDate now) {
    List<UserFinancials> list = new ArrayList();
    LocalDateTime startOfDay = LocalDateTime.of(now, LocalTime.MIDNIGHT);
    LocalDateTime endOfDay = now.atTime(LocalTime.MAX);
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("FROM UserFinancials WHERE user_userId =:id AND date BETWEEN :startofday AND :endofday ORDER BY date DESC", UserFinancials.class);
      pq.setParameter("id", userId);
      pq.setParameter("startofday", startOfDay);
      pq.setParameter("endofday", endOfDay);
      list = pq.list();
      System.out.println("Result size: " + list.size());
      for (UserFinancials uf : list) {
        System.out.println(uf.getTitle());
      }
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return list;
  }

  public List<UserFinancials> getUserReportForTheWeek(int userId, LocalDate now) {
    List<UserFinancials> list = new ArrayList();
    LocalDateTime startOfDay = LocalDateTime.of(now, LocalTime.MIDNIGHT);
    LocalDateTime endOfDay = now.atTime(LocalTime.MAX);
    DayOfWeek dayOfWeek = now.getDayOfWeek();
    LocalDate startOfWeek = now.minusDays(dayOfWeek.getValue() % 7);  // Adjust to get Sunday
    LocalDate endOfWeek = startOfWeek.plusDays(6);  // Saturday

    LocalDateTime startOfQueryTime = LocalDateTime.of(startOfWeek, LocalTime.MIDNIGHT);
    LocalDateTime endOfQueryTime = LocalDateTime.of(endOfWeek, LocalTime.MAX);
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("FROM UserFinancials WHERE user_userId =:id AND date BETWEEN :startofday AND :endofday ORDER BY date DESC", UserFinancials.class);
      pq.setParameter("id", userId);
      pq.setParameter("startofday", startOfQueryTime);
      pq.setParameter("endofday", endOfQueryTime);
      list = pq.list();
      System.out.println("Result size: " + list.size());
      for (UserFinancials uf : list) {
        System.out.println(uf.getTitle());
      }
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return list;
  }

  public List<UserFinancials> getUserReportForTheMonth(int userId, LocalDate now) {
    List<UserFinancials> list = new ArrayList();
    // Get first day of the current month
    LocalDate firstDayOfMonth = now.with(TemporalAdjusters.firstDayOfMonth());

    // Get last day of the current month
    LocalDate lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth());
    LocalDateTime startOfMonth = LocalDateTime.of(firstDayOfMonth, LocalTime.MIDNIGHT);
    LocalDateTime endOfMonth = LocalDateTime.of(lastDayOfMonth, LocalTime.MAX);
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("FROM UserFinancials WHERE user_userId =:id AND date BETWEEN :startOfMonth AND :endOfMonth ORDER BY date DESC", UserFinancials.class);
      pq.setParameter("id", userId);
      pq.setParameter("startOfMonth", startOfMonth);
      pq.setParameter("endOfMonth", endOfMonth);
      list = pq.list();
      System.out.println("Result size: " + list.size());
      for (UserFinancials uf : list) {
        System.out.println(uf.getTitle());
      }
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return list;
  }

  public List<UserFinancials> getUserReportForTheYear(int userId, LocalDate now) {
    List<UserFinancials> list = new ArrayList();

    // Get first day of the current year
    LocalDate firstDayOfYear = now.with(TemporalAdjusters.firstDayOfYear());

    // Get last day of the current year
    LocalDate lastDayOfYear = now.with(TemporalAdjusters.lastDayOfYear());
    LocalDateTime startOfYear = LocalDateTime.of(firstDayOfYear, LocalTime.MIDNIGHT);
    LocalDateTime endOfYear = LocalDateTime.of(lastDayOfYear, LocalTime.MAX);
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("FROM UserFinancials WHERE user_userId =:id AND date BETWEEN :startOfYear AND :endOfYear ORDER BY date DESC", UserFinancials.class);
      pq.setParameter("id", userId);
      pq.setParameter("startOfYear", startOfYear);
      pq.setParameter("endOfYear", endOfYear);
      list = pq.list();
      System.out.println("Result size: " + list.size());
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return list;
  }

  public List<UserFinancials> getUserReportForCustomTime(int userId, LocalDate start, LocalDate end) {
    List<UserFinancials> list = new ArrayList();

    LocalDateTime startOfTime = LocalDateTime.of(start, LocalTime.MIDNIGHT);
    LocalDateTime endOfTime = end.atTime(LocalTime.MAX);
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("FROM UserFinancials WHERE user_userId =:id AND date BETWEEN :startOfTime AND :endOfTime ORDER BY date DESC", UserFinancials.class);
      pq.setParameter("id", userId);
      pq.setParameter("startOfTime", startOfTime);
      pq.setParameter("endOfTime", endOfTime);
      list = pq.list();
      System.out.println("Result size: " + list.size());
      for (UserFinancials uf : list) {
        System.out.println(uf.getTitle());
      }
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return list;
  }

  public BudgetPlan getSubscribedBudgetPlan(int userId) {
    BudgetPlan bp = null;
    User u = null;
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("subscribedBudgetPlanId from User as u WHERE u.userId =:uid", User.class);
      pq.setParameter("uid", userId);
      List<User> list = pq.list();
      if (!list.isEmpty()) {
        u = list.get(0);//returns single user object(row)
      }

      BudgetPlanDao bpDao = new BudgetPlanDao(this.factory);
      bp = bpDao.getBudgetPlanById(u.getSubscribedBudgetPlan().getBudgetPlanId());
      session.close();
    } catch (Exception w) {
      w.printStackTrace();

    }
    return bp;
  }

  public User getAdminById(int parseInt) {
    User p = null;
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("from User as p WHERE p.userId =:pid", User.class);
      pq.setParameter("pid", parseInt);
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

  public boolean updateUserBudgetPlan(int userId, int budgetPlanId) {
    boolean status = false;

    BudgetPlanDao bDao = new BudgetPlanDao(this.factory);
    BudgetPlan bp = bDao.getBudgetPlanById(budgetPlanId);
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update User as u SET u.subscribedBudgetPlan=:type  WHERE u.userId=:id";
      rowCount = session.createMutationQuery(hql)
              .setParameter("type", bp)
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

}
