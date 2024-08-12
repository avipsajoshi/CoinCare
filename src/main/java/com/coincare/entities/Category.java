package com.coincare.entities;

import jakarta.persistence.*;

@Entity
@Table(name="category")
public class Category {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int categoryId;
  @Column(length = 1500, name = "categoryTitle")
  private String categoryTitle;
  @Column(length = 1500, name = "categoryDescription")
  private String categoryDescription;
  @ManyToOne
  private User user;
  @Column(length = 1500, name = "categoryType")
  private String categoryType;
  
  

  public Category() {
  }

  public Category(int categoryId, String categoryTitle, String categoryDescription, User user, String categoryType) {
    this.categoryId = categoryId;
    this.categoryTitle = categoryTitle;
    this.categoryDescription = categoryDescription;
    this.user = user;
    this.categoryType = categoryType;
  }

  public Category(String categoryTitle, String categoryDescription, User user, String categoryType) {
    this.categoryTitle = categoryTitle;
    this.categoryDescription = categoryDescription;
    this.user = user;
    this.categoryType = categoryType;
  }

  

  public int getCategoryId() {
    return categoryId;
  }

  public void setCategoryId(int categoryId) {
    this.categoryId = categoryId;
  }

  public String getCategoryTitle() {
    return categoryTitle;
  }

  public void setCategoryTitle(String categoryTitle) {
    this.categoryTitle = categoryTitle;
  }

  public String getCategoryDescription() {
    return categoryDescription;
  }

  public void setCategoryDescription(String categoryDescription) {
    this.categoryDescription = categoryDescription;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public String getCategoryType() {
    return categoryType;
  }

  public void setCategoryType(String categoryType) {
    this.categoryType = categoryType;
  }

 
  
  
}
