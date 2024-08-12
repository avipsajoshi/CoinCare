package com.coincare.dao;

import com.coincare.entities.BudgetPlan;
import com.coincare.entities.User;
import com.coincare.helper.FactoryProvider;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class BudgetPlanDao {

  private SessionFactory factory;

  public BudgetPlanDao(SessionFactory factory) {
    this.factory = factory;
  }

  //save the budgetPlan to db
  public boolean addBudgetPlan(BudgetPlan cat) {
    boolean f = false;
    try {
      Session session = this.factory.openSession();
      Transaction tx = session.beginTransaction();
      session.persist(cat);
      tx.commit();
      session.close();
      f = true;
    } catch (Exception e) {
      e.printStackTrace();
      f = false;
    }
    return f;
  }

  public List<BudgetPlan> getAllBudgetPlan() {
    Session s = this.factory.openSession();
    List<BudgetPlan> listOfBudgetPlans = s.createQuery("From BudgetPlan", BudgetPlan.class).list();
    s.close();
    return listOfBudgetPlans;
  }

  //get budgetPlan with admin type and user id
  public BudgetPlan getBudgetPlanById(int budgetPlanId) {
    BudgetPlan cat = null;
    try {
      Session session = this.factory.openSession();
      //use get or load - get will return null value
      cat = session.get(BudgetPlan.class, budgetPlanId);
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return cat;
  }

  //get BudgetPlan by user and admin
  public List<BudgetPlan> getAllBudgetPlanByUserId(int userId, int adminId) {
    Session s = this.factory.openSession();
    Query q = s.createQuery("From BudgetPlan WHERE user.userId=:uid or user.userId=:aid", BudgetPlan.class);
    q.setParameter("uid", userId);
    q.setParameter("aid", adminId);
    List<BudgetPlan> listOfCategories = q.list();
    return listOfCategories;
  }

  //update BudgetPlan by userid
  public boolean updateExpense(String budgetPlanTitle, String budgetPlanDescription, String budgetPlanType, int budgetPlanId, int userId) {
    boolean status = false;
    UserDao uDao = new UserDao(FactoryProvider.getFactory());
    User categorUserUpdate = uDao.getUserById(userId);
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update BudgetPlan SET budgetPlanTitle=:title, budgetPlanDescription=:des, budgetPlanType=:type WHERE budgetPlanId=:id and user_userId=:uid";
      rowCount = session.createMutationQuery(hql)
              .setParameter("title", budgetPlanTitle)
              .setParameter("des", budgetPlanDescription)
              .setParameter("type", budgetPlanType)
              .setParameter("id", budgetPlanId)
              .setParameter("uid", userId)
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

  //delete BudgetPlan
  public boolean deleteBudgetPlanById(int budgetPlanId) {
    boolean status = false;

    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "DELETE from BudgetPlan WHERE budgetPlanId=:id";
      rowCount = session.createMutationQuery(hql)
              .setParameter("id", budgetPlanId)
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
  //delete multiple BudgetPlan
  //
}
