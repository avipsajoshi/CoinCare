package com.coincare.entities;

import jakarta.persistence.*;

@Entity
@Table(name="income")
public class Income {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int incomeId;
  @Column(length = 1500, name = "incomeSource")
  private String incomeSource;
  @Column(name = "incomeAmount")
  private double incomeAmount;
  //one to many
  private int userId;
}