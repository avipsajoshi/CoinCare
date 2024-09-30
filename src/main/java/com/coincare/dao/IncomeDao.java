package com.coincare.dao;

import com.coincare.entities.Category;
import com.coincare.entities.Income;
import com.coincare.helper.FactoryProvider;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
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
      Query pq = session.createQuery("from Income as e WHERE user.userId=:uid ORDER BY incomeDate desc", Income.class);
      pq.setParameter("uid", uid);
      inc = pq.list();
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return inc;
  }

  public List<Income> getUserIncomeForTheMonth(int userId) {
    LocalDate now = LocalDate.now();
    List<Income> list = new ArrayList();
    // Get first day of the current month
    LocalDate firstDayOfMonth = now.with(TemporalAdjusters.firstDayOfMonth());
    // Get last day of the current month
    LocalDate lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth());
    LocalDateTime startOfMonth = LocalDateTime.of(firstDayOfMonth, LocalTime.MIDNIGHT);
    LocalDateTime endOfMonth = LocalDateTime.of(lastDayOfMonth, LocalTime.MAX);
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("FROM Income WHERE user.userId =:id AND incomeDate BETWEEN :startOfMonth AND :endOfMonth ORDER BY incomeDate DESC", Income.class);
      pq.setParameter("id", userId);
      pq.setParameter("startOfMonth", startOfMonth);
      pq.setParameter("endOfMonth", endOfMonth);
      list = pq.list();
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return list;
  }

  
  public boolean updateIncome(String incomeSource, String incomeDescriptions, double amount, String mode, String type,int incomeId) {
    boolean status = false;
//    Income currentIncome = this.getIncomeById(incomeId);
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update Income SET incomeSource=:title, incomeDescription=:des, incomeAmount=:amt, mode=:mode, incomeType=:cat WHERE incomeId=:id";
      rowCount = session.createMutationQuery(hql)
              .setParameter("title", incomeSource)
              .setParameter("des", incomeDescriptions)
              .setParameter("amt", amount)
              .setParameter("mode", mode)
              .setParameter("cat", type)
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

  public boolean deleteIncome(int incomeIdToDelete) {
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

  public double getTotalMontlyIncome(int userId){
    double totalIncome = 0.0;
    List<Income> userIncomeForTheMonth = this.getUserIncomeForTheMonth(userId);
    for(Income ic : userIncomeForTheMonth){
      totalIncome += ic.getIncomeAmount();
    }
    return totalIncome;
  }

}
