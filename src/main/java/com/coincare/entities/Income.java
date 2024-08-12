package com.coincare.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "income")
public class Income {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int incomeId;
  @Column(length = 1500, name = "incomeSource")
  private String incomeSource;
  @Column(length = 1500, name = "incomeDescription")
  private String incomeDescription;
  @Column(name = "incomeAmount")
  private double incomeAmount;
  @Column(name = "incomeType")
  private String incomeType;
  @ManyToOne
  private User user;

  public Income() {
  }

  public Income(int incomeId, String incomeSource, String incomeDescription, double incomeAmount, String incomeType, User user) {
    this.incomeId = incomeId;
    this.incomeSource = incomeSource;
    this.incomeDescription = incomeDescription;
    this.incomeAmount = incomeAmount;
    this.incomeType = incomeType;
    this.user = user;
  }

  public Income(String incomeSource, String incomeDescription, double incomeAmount, String incomeType, User user) {
    this.incomeSource = incomeSource;
    this.incomeDescription = incomeDescription;
    this.incomeAmount = incomeAmount;
    this.incomeType = incomeType;
    this.user = user;
  }

  public int getIncomeId() {
    return incomeId;
  }

  public void setIncomeId(int incomeId) {
    this.incomeId = incomeId;
  }

  public String getIncomeSource() {
    return incomeSource;
  }

  public void setIncomeSource(String incomeSource) {
    this.incomeSource = incomeSource;
  }

  public String getIncomeDescription() {
    return incomeDescription;
  }

  public void setIncomeDescription(String incomeDescription) {
    this.incomeDescription = incomeDescription;
  }
  
  

  public double getIncomeAmount() {
    return incomeAmount;
  }

  public void setIncomeAmount(double incomeAmount) {
    this.incomeAmount = incomeAmount;
  }

  public String getIncomeType() {
    return incomeType;
  }

  public void setIncomeType(String incomeType) {
    this.incomeType = incomeType;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

}
