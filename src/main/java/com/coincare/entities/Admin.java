package com.coincare.entities;

import jakarta.persistence.*;


@Entity
@Table(name="Admin")
public class Admin {
  @Id
  private int userId;
  @Column(length = 100, name = "adminName")
  private String adminName;
  @Column(length = 100, name = "adminEmail")
  private String adminEmail;
  @Column(length = 100, name = "adminPassword")
  private String adminPassword;
  @Column(length = 100, name = "adminType")
  private String adminType;
  
  
  
}
