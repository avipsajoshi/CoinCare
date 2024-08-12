package com.coincare.dao;

import com.coincare.entities.Category;
import com.coincare.entities.Expense;
import com.coincare.entities.User;
import com.coincare.helper.FactoryProvider;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ExpenseDao {

  private SessionFactory factory;

  public ExpenseDao(SessionFactory factory) {
    this.factory = factory;
  }

  public boolean addExpense(Expense item) {
    boolean f = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      session.persist(item);
      tx.commit();
      session.close();
      f = true;
    } catch (Exception e) {
      tx.rollback();
      e.printStackTrace();
      f = false;
    }
    return f;
  }

  public Expense getExpenseById(int id) {
    Expense exp = null;
    try {
      Session session = this.factory.openSession();
      //use get or load - get will return null value
      exp = session.get(Expense.class, id);
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return exp;
  }

  public  List<Expense> getExpenseByUserId(int uid) {
    List<Expense> exp = null;
    Session session = this.factory.openSession();
    try {
      Query pq = session.createQuery("from Expense as e WHERE user.userId=:uid", Expense.class);
      pq.setParameter("uid", uid);
      exp = pq.list();
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return exp;
  }
  
  
  public  List<Expense> getExpenseByUserIdToday(int uid, LocalDate now) {
    List<Expense> exp = null;
    LocalDateTime startOfDay = LocalDateTime.of(now, LocalTime.MIDNIGHT);
    LocalDateTime endOfDay = now.atTime(LocalTime.MAX);
    Session session = this.factory.openSession();
    try {
      Query pq = session.createQuery("from Expense as e WHERE user.userId=:uid and expenseDate<=:endofday and expenseDate>=:startofday", Expense.class);
      pq.setParameter("uid", uid);
      pq.setParameter("startofday", startOfDay);
      pq.setParameter("endofday", endOfDay);
      exp = pq.list();
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return exp;
  }

  public boolean updateExpense(String expenseTitle, String expenseRemarks, double amount, int categoryId,int expenseId) {
    boolean status = false;
    CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
    Category categoryUpdate = catDao.getCategoryById(categoryId);
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update Expense SET expenseTitle=:title, expenseRemark=:des, expenseAmount=:amt,category_categoryId=:cat WHERE expenseId=:id";
      rowCount = session.createMutationQuery(hql)
              .setParameter("title", expenseTitle)
              .setParameter("des", expenseRemarks)
              .setParameter("cat", categoryId)
              .setParameter("amt", amount)
              .setParameter("id", expenseId)
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

  public boolean deleteById(int expenseIdToDelete) {
     boolean status = false;
    
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "DELETE from Expense WHERE expenseId=:id";
      rowCount = session.createMutationQuery(hql)
              .setParameter("id", expenseIdToDelete)
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
