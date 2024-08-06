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
  @ManyToOne
  private SuperCategory superCategory;
  
  

  public Category() {
  }

  public Category(int categoryId, String categoryTitle, String categoryDescription, User user, SuperCategory superCategory) {
    this.categoryId = categoryId;
    this.categoryTitle = categoryTitle;
    this.categoryDescription = categoryDescription;
    this.user = user;
    this.superCategory = superCategory;
  }

  public Category(String categoryTitle, String categoryDescription, User user, SuperCategory superCategory) {
    this.categoryTitle = categoryTitle;
    this.categoryDescription = categoryDescription;
    this.user = user;
    this.superCategory = superCategory;
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

  public SuperCategory getSuperCategory() {
    return superCategory;
  }

  public void setSuperCategory(SuperCategory superCategory) {
    this.superCategory = superCategory;
  }

  
  
  
  
}
