package com.coincare.dao;

import com.coincare.entities.Category;
import com.coincare.entities.Income;
import com.coincare.helper.FactoryProvider;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class IncomeDao {
  private SessionFactory factory;

  public IncomeDao(SessionFactory factory) {
    this.factory = factory;
  }

  public boolean addIncome(Income item) {
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

  public Income getIncomeById(int id) {
    Income inc = null;
    try {
      Session session = this.factory.openSession();
      //use get or load - get will return null value
      inc = session.get(Income.class, id);
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return inc;
  }

  public  List<Income> getIncomeByUserId(int uid) {
    List<Income> inc = null;
    Session session = this.factory.openSession();
    try {
      Query pq = session.createQuery("from Income as e WHERE user.userId=:uid", Income.class);
      pq.setParameter("uid", uid);
      inc = pq.list();
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return inc;
  }

  public boolean updateIncome(String incomeSource, String incomeDescriptions, double amount, String category,int incomeId) {
    boolean status = false;
    CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update Income SET incomeSource=:title, incomeDescription=:des, incomeAmount=:amt,incomeType=:cat WHERE incomeId=:id";
      rowCount = session.createMutationQuery(hql)
              .setParameter("title", incomeSource)
              .setParameter("des", incomeDescriptions)
              .setParameter("cat", category)
              .setParameter("amt", amount)
              .setParameter("id", incomeId)
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

  public boolean deleteById(int incomeIdToDelete) {
     boolean status = false;
    
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "DELETE from Income WHERE incomeId=:id";
      rowCount = session.createMutationQuery(hql)
              .setParameter("id", incomeIdToDelete)
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
