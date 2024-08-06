package com.coincare.dao;

import com.coincare.entities.Category;
import com.coincare.entities.Expense;
import com.coincare.entities.User;
import com.coincare.helper.FactoryProvider;
import java.time.LocalDateTime;
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

  public boolean updateExpense(String expenseTitle, String expenseRemarks, float amount, int category, String user, int expenseId) {
    boolean status = false;
    CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
    Category categoryUpdate = catDao.getCategoryById(category);
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update Expense SET expenseTitle=:title, expenseRemark=:des, expenseAmount=:amt,category_categoryId=:cat WHERE expenseId=:id";
      rowCount = session.createMutationQuery(hql)
              .setParameter("title", expenseTitle)
              .setParameter("des", expenseRemarks)
              .setParameter("cat", categoryUpdate)
              .setParameter("amt", amount)
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
