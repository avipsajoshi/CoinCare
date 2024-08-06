package com.coincare.entities;

import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "expense")
public class Expense {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int expenseId;
  @Column(length = 1500, name = "expenseTitle")
  private String expenseTitle;
  @Column(length = 1500, name = "expenseRemark")
  private String expenseRemarks;
  @Column(length = 1500, name = "expenseAmount")
  private double expenseAmount;
  @Column(length = 1500, name = "expenseDate")
  private Timestamp expenseDate;
  //one to one
  @ManyToOne
  private Category category;
  @ManyToOne
  private User user;

  public Expense() {
  }

  public Expense(int expenseId, String expenseTitle, String expenseRemarks, double expenseAmount, Timestamp expenseDate, Category category, User user) {
    this.expenseId = expenseId;
    this.expenseTitle = expenseTitle;
    this.expenseRemarks = expenseRemarks;
    this.expenseAmount = expenseAmount;
    this.expenseDate = expenseDate;
    this.category = category;
    this.user = user;
  }

  public Expense(String expenseTitle, String expenseRemarks, double expenseAmount, Timestamp expenseDate, Category category, User user) {
    this.expenseTitle = expenseTitle;
    this.expenseRemarks = expenseRemarks;
    this.expenseAmount = expenseAmount;
    this.expenseDate = expenseDate;
    this.category = category;
    this.user = user;
  }
  
  
  //getter setter methods
  public int getExpenseId() {
    return expenseId;
  }

  public void setExpenseId(int expenseId) {
    this.expenseId = expenseId;
  }

  public String getExpenseTitle() {
    return expenseTitle;
  }

  public void setExpenseTitle(String expenseTitle) {
    this.expenseTitle = expenseTitle;
  }

  public String getExpenseRemarks() {
    return expenseRemarks;
  }

  public void setExpenseRemarks(String expenseRemarks) {
    this.expenseRemarks = expenseRemarks;
  }

  public double getExpenseAmount() {
    return expenseAmount;
  }

  public void setExpenseAmount(double expenseAmount) {
    this.expenseAmount = expenseAmount;
  }
  

  public Timestamp getExpenseDate() {
    return expenseDate;
  }

  public void setExpenseDate(Timestamp expenseDate) {
    this.expenseDate = expenseDate;
  }

  public Category getCategory() {
    return category;
  }

  public void setCategory(Category category) {
    this.category = category;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }
  
  
  

}
