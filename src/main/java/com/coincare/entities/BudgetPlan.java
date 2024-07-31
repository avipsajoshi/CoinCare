package com.coincare.entities;

import jakarta.persistence.*;

@Entity
@Table(name="budgetPlan")
class BudgetPlan {
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
//  @Column(name = "budgetPlanCreator")
//  private User budgetPlanCreator;
//  @ManyToMany(mappedBy = "userBudgetPlans")
//  private User user;
}
