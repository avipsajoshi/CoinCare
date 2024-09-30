package com.coincare.entities;

import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "user_financials")
public class UserFinancials {
  @Id
  private int transactionId;
  
  @Column(name = "user_userId")
  private int user_userId;
  @Column(length = 100, name = "type")
  private String type;
  @Column(length = 100, name = "title")
  private String title;
  @Column(length = 100, name = "description")
  private String description;
  @Column(length = 100, name = "modeOfTransaction")
  private String mode;
  @Column(length = 100, name = "category")
  private String category;
  @Column(length = 100, name = "amount")
  private Double amount;
  @Column(length = 100, name = "date")
  private Timestamp date;

  public UserFinancials() {
  }

  public UserFinancials(int transactionId, int user_userId, String type, String title, String description, String mode, String category, Double amount, Timestamp date) {
    this.transactionId = transactionId;
    this.user_userId = user_userId;
    this.type = type;
    this.title = title;
    this.description = description;
    this.mode = mode;
    this.category = category;
    this.amount = amount;
    this.date = date;
  }

  public UserFinancials(int user_userId, String type, String title, String description, String mode, String category, Double amount, Timestamp date) {
    this.user_userId = user_userId;
    this.type = type;
    this.title = title;
    this.description = description;
    this.mode = mode;
    this.category = category;
    this.amount = amount;
    this.date = date;
  }

  public int getTransactionId() {
    return transactionId;
  }

  public void setTransactionId(int transactionId) {
    this.transactionId = transactionId;
  }
  
  public String getCategory() {
    return category;
  }

  public void setCategory(String category) {
    this.category = category;
  }
  
  
  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }
  

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public Double getAmount() {
    return amount;
  }

  public void setAmount(Double amount) {
    this.amount = amount;
  }

  public Timestamp getDate() {
    return date;
  }

  public void setDate(Timestamp date) {
    this.date = date;
  }

  public int getUser_userId() {
    return user_userId;
  }

  public void setUser_userId(int user_userId) {
    this.user_userId = user_userId;
  }

  public String getMode() {
    return mode;
  }

  public void setMode(String mode) {
    this.mode = mode;
  }
  
}
