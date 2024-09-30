package com.coincare.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "budgetPlan")
public class BudgetPlan {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int budgetPlanId;
  @Column(length = 1500, name = "budgetPlanTitle")
  private String budgetPlanTitle;
  @Column(length = 2500, name = "budgetPlanDescription")
  private String budgetPlanDescription;
  @Column(name = "budgetPlanExpense")
  private int budgetPlanExpense;
  @Column(name = "budgetPlanSavings")
  private int budgetPlanSavings;
  @Column(name = "budgetPlanWants")
  private int budgetPlanWants;
  @ManyToOne
  @JoinColumn(name = "user_userId", nullable = false)
  private User user;

  public BudgetPlan() {
  }

  public BudgetPlan(String budgetPlanTitle, String budgetPlanDescription, int budgetPlanExpense, int budgetPlanSavings, int budgetPlanWants, User user) {
    this.budgetPlanTitle = budgetPlanTitle;
    this.budgetPlanDescription = budgetPlanDescription;
    this.budgetPlanExpense = budgetPlanExpense;
    this.budgetPlanSavings = budgetPlanSavings;
    this.budgetPlanWants = budgetPlanWants;
    this.user = user;
  }

  public int getBudgetPlanId() {
    return budgetPlanId;
  }

  public void setBudgetPlanId(int budgetPlanId) {
    this.budgetPlanId = budgetPlanId;
  }

  public String getBudgetPlanTitle() {
    return budgetPlanTitle;
  }

  public void setBudgetPlanTitle(String budgetPlanTitle) {
    this.budgetPlanTitle = budgetPlanTitle;
  }

  public String getBudgetPlanDescription() {
    return budgetPlanDescription;
  }

  public void setBudgetPlanDescription(String budgetPlanDescription) {
    this.budgetPlanDescription = budgetPlanDescription;
  }

  public int getBudgetPlanExpense() {
    return budgetPlanExpense;
  }

  public void setBudgetPlanExpense(int budgetPlanExpense) {
    this.budgetPlanExpense = budgetPlanExpense;
  }

  public int getBudgetPlanSavings() {
    return budgetPlanSavings;
  }

  public void setBudgetPlanSavings(int budgetPlanSavings) {
    this.budgetPlanSavings = budgetPlanSavings;
  }

  public int getBudgetPlanWants() {
    return budgetPlanWants;
  }

  public void setBudgetPlanWants(int budgetPlanWants) {
    this.budgetPlanWants = budgetPlanWants;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

}
