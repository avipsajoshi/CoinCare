package com.coincare.dao;

import com.coincare.entities.BudgetPlan;
import com.coincare.entities.Expense;
import com.coincare.entities.User;
import com.coincare.entities.UserFinancials;
import com.coincare.helper.FactoryProvider;
import com.coincare.helper.SendMail;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.HashSet;
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

  //get budgetPlan with id
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
  public boolean updateBudgetPlanByUserId(String budgetPlanTitle, String budgetPlanDescription, int budgetPlanId, int userId) {
    boolean status = false;
    UserDao uDao = new UserDao(FactoryProvider.getFactory());
    User categorUserUpdate = uDao.getUserById(userId);
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update BudgetPlan SET budgetPlanTitle=:title, budgetPlanDescription=:des, WHERE budgetPlanId=:id and user_userId=:uid";
      rowCount = session.createMutationQuery(hql)
              .setParameter("title", budgetPlanTitle)
              .setParameter("des", budgetPlanDescription)
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

  //update BudgetPlan by userid
  public boolean updateBudgetPlanByUserId(String budgetPlanTitle, String budgetPlanDescription, int budgetPlanExpense, int budgetPlanWants, int budgetPlanSavings, int budgetPlanId, int userId) {
    boolean status = false;
    UserDao uDao = new UserDao(FactoryProvider.getFactory());
    User categorUserUpdate = uDao.getUserById(userId);
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update BudgetPlan SET budgetPlanTitle=:title, budgetPlanDescription=:des, 	budgetPlanExpense=:exp, budgetPlanWants=:wants, budgetPlanSavings=:save WHERE budgetPlanId=:id and user_userId=:uid";
      rowCount = session.createMutationQuery(hql)
              .setParameter("title", budgetPlanTitle)
              .setParameter("des", budgetPlanDescription)
              .setParameter("exp", budgetPlanExpense)
              .setParameter("wants", budgetPlanWants)
              .setParameter("sav", budgetPlanSavings)
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

  //hash map HashSet
  public HashMap<String, String> getDividedBudget(int budgetPlanId, double income) {
    HashMap<String, String> dividedBudget = new HashMap<>();
    HashSet<String> set = new HashSet<>();
    BudgetPlan bp = this.getBudgetPlanById(budgetPlanId);
    int expensePercent = bp.getBudgetPlanExpense();
    int wantPercent = bp.getBudgetPlanWants();
    int savingPercent = bp.getBudgetPlanSavings();

    double expense = income * expensePercent / 100;
    double wants = income * wantPercent / 100;
    double savings = income * savingPercent / 100;

    double expenseW = expense / 4;
    double wantsW = wants / 4;
    double savingsW = savings / 4;

    double expenseD = expenseW / 7;
    double wantsD = wantsW / 7;
    double savingsD = savingsW / 7;

    dividedBudget.put("Monthly Expense", String.valueOf(String.format("%.2f", expense)));
    dividedBudget.put("Monthly Wants", String.valueOf(String.format("%.2f", wants)));
    dividedBudget.put("Monthly Savings", String.valueOf(String.format("%.2f", savings)));
    dividedBudget.put("Weekly Expense", String.valueOf(String.format("%.2f", expenseW)));
    dividedBudget.put("Weekly Wants", String.valueOf(String.format("%.2f", wantsW)));
    dividedBudget.put("Weekly Savings", String.valueOf(String.format("%.2f", savingsW)));

    dividedBudget.put("Daily Expense", String.valueOf(String.format("%.2f", expenseD)));
    dividedBudget.put("Daily Wants", String.valueOf(String.format("%.2f", wantsD)));
    dividedBudget.put("Daily Savings", String.valueOf(String.format("%.2f", savingsD)));

    return dividedBudget;
  }

  public HashMap<String, String> getSpent(int budgetPlanId, double income, int userId) {
    HashMap<String, String> spentBudget = new HashMap<>();
//    HttpSession session = ;
    BudgetPlan bp = this.getBudgetPlanById(budgetPlanId);
    ExpenseDao eDao = new ExpenseDao(this.factory);
    UserDao uDao = new UserDao(this.factory);
    User user = uDao.getUserById(userId);
    LocalDate currentDate = LocalDate.now();
    List<Expense> allMonthlyTransactions = eDao.getUserExpenseForTheMonth(userId, currentDate);
    List<Expense> allWeeklyTransactions = eDao.getUserExpenseForTheWeek(userId, currentDate);
    List<Expense> allDailyTransactions = eDao.getUserExpenseForToday(userId, currentDate);

    int expensePercent = bp.getBudgetPlanExpense();
    int wantPercent = bp.getBudgetPlanWants();
    int savingPercent = bp.getBudgetPlanSavings();

    double totalExpenseM = 0.0, totalExpenseW = 0.0, totalExpenseD = 0.0;
    double totalWantM = 0.0, totalWantW = 0.0, totalWantD = 0.0;
    double totalSavingM = income * savingPercent / 100, totalSavingW = totalSavingM / 4, totalSavingD = totalSavingW / 7;

    for (Expense ufM : allMonthlyTransactions) {
      if (ufM.getCategory().getCategoryType().equals("Fixed Expenses") || ufM.getCategory().getCategoryType().equals("Non-fixed Expenses") || ufM.getCategory().getCategoryType().equals("Emergency Expenses") || ufM.getCategory().getCategoryType().equals("Education Expenses")) {
        totalExpenseM += ufM.getExpenseAmount();
      } else if (ufM.getCategory().getCategoryType().equals("Discretionary Expenses") || ufM.getCategory().getCategoryType().equals("Other Expenses")) {
        totalWantM += ufM.getExpenseAmount();
      }
    }

    for (Expense ufW : allWeeklyTransactions) {
      if (ufW.getCategory().getCategoryType().equals("Fixed Expenses") || ufW.getCategory().getCategoryType().equals("Non-fixed Expenses") || ufW.getCategory().getCategoryType().equals("Emergency Expenses") || ufW.getCategory().getCategoryType().equals("Education Expenses")) {
        totalExpenseW += ufW.getExpenseAmount();
      } else if (ufW.getCategory().getCategoryType().equals("Discretionary Expenses") || ufW.getCategory().getCategoryType().equals("Other Expenses")) {
        totalWantW += ufW.getExpenseAmount();
      }

    }

    for (Expense ufD : allDailyTransactions) {
      if (ufD.getCategory().getCategoryType().equals("Fixed Expenses") || ufD.getCategory().getCategoryType().equals("Non-fixed Expenses") || ufD.getCategory().getCategoryType().equals("Emergency Expenses") || ufD.getCategory().getCategoryType().equals("Education Expenses")) {
        totalExpenseD += ufD.getExpenseAmount();
      } else if (ufD.getCategory().getCategoryType().equals("Discretionary Expenses") || ufD.getCategory().getCategoryType().equals("Other Expenses")) {
        totalWantD += ufD.getExpenseAmount();
      }

    }

    double expense = (totalExpenseM / (income * expensePercent / 100)) * 100;
    double wants = (totalWantM / (income * wantPercent / 100)) * 100;
    double savings = 100;
    if (expense > 100 || wants > 100) {
      totalSavingM = (income * (expensePercent + wantPercent) / 100) - (totalExpenseM + totalWantM);
      savings = (income * savingPercent / 100) * 100 - expense - wants;
    }

    double expenseW = (totalExpenseW / ((income * expensePercent / 100) / 4)) * 100;
    double wantsW = (totalWantW / ((income * wantPercent / 100) / 4)) * 100;
    double savingsW = 100;
    if (expenseW > 100 || wantsW > 100) {
      savingsW = ((income * savingPercent / 100) / 4) * 100 - expenseW - wantsW;
      totalSavingW = (income * ((expensePercent + wantPercent) / 100) / 4) - (totalExpenseW + totalWantW);
    }

    //total expense budget spent daily
    double expenseD = (totalExpenseD / (((income * expensePercent / 100) / 4) / 7)) * 100;
    double wantsD = (totalWantD / (((income * wantPercent / 100) / 4) / 7)) * 100;
    double savingsD = 100;
    if (expenseD > 100 || wantsD > 100) {
      totalSavingD = (income * (((expensePercent + wantPercent) / 100) / 4) / 7) - (totalExpenseD + totalWantD);
      savingsD = (((income * savingPercent / 100) / 4) / 7) * 100 - expenseD - wantsD;
    }

    spentBudget.put("Monthly Expense", String.valueOf(String.format("%.2f", expense)));
    spentBudget.put("Monthly Wants", String.valueOf(String.format("%.2f", wants)));
    spentBudget.put("Monthly Savings", String.valueOf(String.format("%.2f", savings)));

    spentBudget.put("Weekly Expense", String.valueOf(String.format("%.2f", expenseW)));
    spentBudget.put("Weekly Wants", String.valueOf(String.format("%.2f", wantsW)));
    spentBudget.put("Weekly Savings", String.valueOf(String.format("%.2f", savingsW)));

    spentBudget.put("Daily Expense", String.valueOf(String.format("%.2f", expenseD)));
    spentBudget.put("Daily Wants", String.valueOf(String.format("%.2f", wantsD)));
    spentBudget.put("Daily Savings", String.valueOf(String.format("%.2f", savingsD)));

    spentBudget.put("Monthly Expense Amount", String.valueOf(String.format("%.2f", totalExpenseM)));
    spentBudget.put("Monthly Wants Amount", String.valueOf(String.format("%.2f", totalWantM)));
    spentBudget.put("Monthly Savings Amount", String.valueOf(String.format("%.2f", totalSavingM)));

    spentBudget.put("Weekly Expense Amount", String.valueOf(String.format("%.2f", totalExpenseW)));
    spentBudget.put("Weekly Wants Amount", String.valueOf(String.format("%.2f", totalWantW)));
    spentBudget.put("Weekly Savings Amount", String.valueOf(String.format("%.2f", totalSavingW)));

    spentBudget.put("Daily Expense Amount", String.valueOf(String.format("%.2f", totalExpenseD)));
    spentBudget.put("Daily Wants Amount", String.valueOf(String.format("%.2f", totalWantD)));
    spentBudget.put("Daily Savings Amount", String.valueOf(String.format("%.2f", totalSavingD)));

    if (totalExpenseM + totalWantM >= income || totalExpenseW + totalWantW >= (income / 4) || totalExpenseD + totalWantD >= (income / 4 / 7)) {
      String message = "";
      if (totalExpenseD >= expenseD) {
        message = "Dear "+ user.getUserName()+ ",\n"
                + "\n"
                + "We would like to inform you that your recent expenses have exceeded the budget you set for  the day. This is a critical reminder to review your spending and make necessary adjustments to avoid financial strain.\n"
                + "\n"
                + "Current Expenses:"+totalExpenseD+"\n"
                + "Budget Limit: "+expenseD+"\n"
                + "\n"
                + "We recommend revisiting your expense categories and planning your future expenditures carefully.";
      }
      if (totalExpenseW >= expenseW) {
        message = "Dear "+ user.getUserName()+ ",\n"
                + "\n"
                + "We would like to inform you that your recent expenses have exceeded the budget you set for  the week. This is a critical reminder to review your spending and make necessary adjustments to avoid financial strain.\n"
                + "\n"
                + "Current Expenses:"+totalExpenseW+"\n"
                + "Budget Limit: "+expenseW+"\n"
                + "\n"
                + "We recommend revisiting your expense categories and planning your future expenditures carefully.";
      }
      if (totalExpenseM >= expense) {
        message = "Dear "+ user.getUserName()+ ",\n"
                + "\n"
                + "We would like to inform you that your recent expenses have exceeded the budget you set for  the month. This is a critical reminder to review your spending and make necessary adjustments to avoid financial strain.\n"
                + "\n"
                + "Current Expenses:"+totalExpenseM+"\n"
                + "Budget Limit: "+expense+"\n"
                + "\n"
                + "We recommend revisiting your expense categories and planning your future expenditures carefully.";
      }
      if (totalWantD >= wantsD) {
        message = "Dear "+ user.getUserName()+ ",\n"
                + "\n"
                + "We would like to inform you that your recent expenses have exceeded the budget you set for  the day. This is a critical reminder to review your spending and make necessary adjustments to avoid financial strain.\n"
                + "\n"
                + "Current Expenses:"+totalExpenseD+"\n"
                + "Budget Limit: "+wantsD+"\n"
                + "\n"
                + "We recommend revisiting your expense categories and planning your future expenditures carefully.";
      }
      if (totalWantW >= wantsW) {
        message = "Dear "+ user.getUserName()+ ",\n"
                + "\n"
                + "We would like to inform you that your recent expenses have exceeded the budget you set for  the week. This is a critical reminder to review your spending and make necessary adjustments to avoid financial strain.\n"
                + "\n"
                + "Current Expenses:"+totalWantW+"\n"
                + "Budget Limit: "+wantsW+"\n"
                + "\n"
                + "We recommend revisiting your expense categories and planning your future expenditures carefully.";
      }
      if (totalWantM >= wants) {
        message = "Dear "+ user.getUserName()+ ",\n"
                + "\n"
                + "We would like to inform you that your recent expenses have exceeded the budget you set for  the day. This is a critical reminder to review your spending and make necessary adjustments to avoid financial strain.\n"
                + "\n"
                + "Current Expenses:"+totalWantM+"\n"
                + "Budget Limit: "+wants+"\n"
                + "\n"
                + "We recommend revisiting your expense categories and planning your future expenditures carefully.";
      }
      if (totalSavingD >= savingsD) {
        message = "Dear "+ user.getUserName()+ ",\n"
                + "\n"
                + "We would like to inform you that your recent expenses have exceeded the budget you set for  the day. This is a critical reminder to review your spending and make necessary adjustments to avoid financial strain.\n"
                + "\n"
                + "Current Expenses:"+totalSavingD+"\n"
                + "Budget Limit: "+savingsD+"\n"
                + "\n"
                + "We recommend revisiting your expense categories and planning your future expenditures carefully.";
      }
      if (totalSavingW >= savingsW) {
        message = "Dear "+ user.getUserName()+ ",\n"
                + "\n"
                + "We would like to inform you that your recent expenses have exceeded the budget you set for  the week. This is a critical reminder to review your spending and make necessary adjustments to avoid financial strain.\n"
                + "\n"
                + "Current Expenses:"+totalSavingW+"\n"
                + "Budget Limit: "+savingsW+"\n"
                + "\n"
                + "We recommend revisiting your expense categories and planning your future expenditures carefully.";
      }
      if (totalSavingM >= savings) {
        message = "Dear "+ user.getUserName()+ ",\n"
                + "\n"
                + "We would like to inform you that your recent expenses have exceeded the budget you set for  the day. This is a critical reminder to review your spending and make necessary adjustments to avoid financial strain.\n"
                + "\n"
                + "Current Expenses:"+totalSavingM+"\n"
                + "Budget Limit: "+savings+"\n"
                + "\n"
                + "We recommend revisiting your expense categories and planning your future expenditures carefully.";
      }
      try {
        SendMail mail = new SendMail(message, "Urgent: You've Exceeded Your Budget", user.getUserEmail());
        mail.sendEmail();

      } catch (Exception e) {
//        session.setAttribute("message", "An error occured, please try again");
      }
    }

    return spentBudget;
  }
}
