package com.coincare.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "article")
public class Article {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int articleId;

  @Column(length = 1500, name = "articleTitle")
  private String articleTitle;

  @Column(length = 5000, name = "articleBody")
  private String articleBody;

  @Column(length = 5000, name = "status")
  private String publishStatus;
  
  
  @ManyToOne
  private User admin;

  public Article() {
  }

  public Article(int articleId, String articleTitle, String articleBody, String publishStatus, User admin) {
    this.articleId = articleId;
    this.articleTitle = articleTitle;
    this.articleBody = articleBody;
    this.publishStatus = publishStatus;
    this.admin = admin;
  }

  public Article(String articleTitle, String articleBody, String publishStatus, User admin) {
    this.articleTitle = articleTitle;
    this.articleBody = articleBody;
    this.publishStatus = publishStatus;
    this.admin = admin;
  }

  public String getPublishStatus() {
    return publishStatus;
  }

  public void setPublishStatus(String publishStatus) {
    this.publishStatus = publishStatus;
  }

  

  // Getters and Setters
  public int getArticleId() {
    return articleId;
  }

  public void setArticleId(int articleId) {
    this.articleId = articleId;
  }

  public String getArticleTitle() {
    return articleTitle;
  }

  public void setArticleTitle(String articleTitle) {
    this.articleTitle = articleTitle;
  }

  public String getArticleBody() {
    return articleBody;
  }

  public void setArticleBody(String articleBody) {
    this.articleBody = articleBody;
  }

  public User getUser() {
    return admin;
  }

  public void setUser(User admin) {
    this.admin = admin;
  }
}
