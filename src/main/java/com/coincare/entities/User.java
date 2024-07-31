package com.coincare.entities;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="User")
public class User {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int userId;
  
  @Column(length = 100, name = "userName")
  private String userName;
  
  @Column(length = 100, name = "userEmail", unique=true)
  private String userEmail;
  
  @Column(length = 1000, name = "userPassword")
  private String userPassword;
  
  @Column(length = 1500, name = "userPic")
  private String userPic;
  
  @Column(length = 1500, name = "userCountry")
  private String userCountry;
  
  @Column(length = 1500, name = "userType")
  private String userType;
  
  @Column(name="userDobYear")
  private int userDobYear;
  @Column(name="userDobMonth")
  private int userDobMonth;
  @Column(name="userDobDay")
  private int userDobDay;
  
  @Column(name="enableReportNotification")
  private String enableReportNotification;
  
  @Column(name="enableTipsNotification")
  private String enableTipsNotification;
  
  @Column(name="enableStreakNotification")
  private String enableStreakNotification;
  
//  @OneToMany(mappedBy="userCategories")
//  private List<Category> customCategories = new ArrayList<>();
  
//  @ManyToMany
//  @JoinTable(name = "userBudgetPlans",
//    joinColumns = @JoinColumn(name = "userId"),
//    inverseJoinColumns = @JoinColumn(name ="budgetPlanId"))
//  private BudgetPlan budgetPlan;

  public User(){
    
  }
  public User(String userName, String userEmail, String userPassword, String userPic, String userCountry, String userType, int userDobYear, int userDobMonth, int userDobDay, String enableReportNotification, String enableTipsNotification, String enableStreakNotification) {
    this.userName = userName;
    this.userEmail = userEmail;
    this.userPassword = userPassword;
    this.userPic = userPic;
    this.userCountry = userCountry;
    this.userType = userType;
    this.userDobYear = userDobYear;
    this.userDobMonth = userDobMonth;
    this.userDobDay = userDobDay;
    this.enableReportNotification = enableReportNotification;
    this.enableTipsNotification = enableTipsNotification;
    this.enableStreakNotification = enableStreakNotification;
  }

  public User(String userName, String userEmail, String userPassword, String userPic, String userType) {
    this.userName = userName;
    this.userEmail = userEmail;
    this.userPassword = userPassword;
    this.userPic = userPic;
    this.userType = userType;
  }

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  public String getUserName() {
    return userName;
  }

  public void setUserName(String userName) {
    this.userName = userName;
  }

  public String getUserEmail() {
    return userEmail;
  }

  public void setUserEmail(String userEmail) {
    this.userEmail = userEmail;
  }

  public String getUserPassword() {
    return userPassword;
  }

  public void setUserPassword(String userPassword) {
    this.userPassword = userPassword;
  }

  public String getUserPic() {
    return userPic;
  }

  public void setUserPic(String userPic) {
    this.userPic = userPic;
  }

  public String getUserCountry() {
    return userCountry;
  }

  public void setUserCountry(String userCountry) {
    this.userCountry = userCountry;
  }

  public String getUserType() {
    return userType;
  }

  public void setUserType(String userType) {
    this.userType = userType;
  }

  public int getUserDobYear() {
    return userDobYear;
  }

  public void setUserDobYear(int userDobYear) {
    this.userDobYear = userDobYear;
  }

  public int getUserDobMonth() {
    return userDobMonth;
  }

  public void setUserDobMonth(int userDobMonth) {
    this.userDobMonth = userDobMonth;
  }

  public int getUserDobDay() {
    return userDobDay;
  }

  public void setUserDobDay(int userDobDay) {
    this.userDobDay = userDobDay;
  }

  public String isEnableReportNotification() {
    return enableReportNotification;
  }

  public void setEnableReportNotification(String enableReportNotification) {
    this.enableReportNotification = enableReportNotification;
  }

  public String getEnableTipsNotification() {
    return enableTipsNotification;
  }

  public void setEnableTipsNotification(String enableTipsNotification) {
    this.enableTipsNotification = enableTipsNotification;
  }

  public String getEnableStreakNotification() {
    return enableStreakNotification;
  }

  public void setEnableStreakNotification(String enableStreakNotification) {
    this.enableStreakNotification = enableStreakNotification;
  }
  
  
  
}
