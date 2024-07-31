package com.coincare.entities;

import jakarta.persistence.*;
import java.sql.Date;
@Entity
@Table(name="expense")
public class Expense {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int expenseId;
  //one to many
  private int userId;
  @Column(length = 1500, name = "expenseTitle")
  private String expenseTitle;
  @Column(length = 1500, name = "expenseDescription")
  private String expenseRemarks;
  private Date expenseDate;
  //one to one
  private int expenseCategory;
  
}
