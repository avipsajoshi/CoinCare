package com.coincare.entities;

import jakarta.persistence.*;
import java.util.List;
import org.hibernate.annotations.ColumnDefault;

@Entity
@Table(name = "User")
public class User {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int userId;

  @Column(length = 100, name = "userName")
  private String userName;

  @Column(length = 100, name = "userEmail", unique = true)
  private String userEmail;

  @Column(length = 1000, name = "userPassword")
  private String userPassword;

  @Column(length = 1500, name = "userPic")
  private String userPic;

  @Column(length = 1500, name = "userCountry")
  private String userCountry;

  @Column(length = 1500, name = "userType")
  private String userType;
  @Column(name = "userDobYear")
  private int userDobYear;
  @Column(name = "userDobMonth")
  @ColumnDefault("'1'")
  private int userDobMonth;
  @Column(name = "userDobDay")
  @ColumnDefault("'1'")
  private int userDobDay;

  @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
  private List<BudgetPlan> budgetPlans;

  @ManyToOne
  @JoinColumn(name = "subscribedBudgetPlanId")
  private BudgetPlan subscribedBudgetPlan;

//  @NotNull
  @Column(name = "enableReportNotification")
  @ColumnDefault("'on'")
  private String enableReportNotification;

//  @NotNull
  @Column(name = "enableTipsNotification")
  @ColumnDefault("'on'")
  private String enableTipsNotification;

//  @NotNull
  @Column(name = "userVerify")
  @ColumnDefault("'Verify'")
  private String userVerify;

  public User() {

  }

  public User(int userId, String userName, String userEmail, String userPassword, String userPic, String userCountry, String userType, int userDobYear, int userDobMonth, int userDobDay, String enableReportNotification, String enableTipsNotification, String userVerify) {
    this.userId = userId;
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
    this.userVerify = userVerify;
  }

  public User(String userName, String userEmail, String userPassword, String userPic, String userCountry, String userType, int userDobYear, int userDobMonth, int userDobDay, String enableReportNotification, String enableTipsNotification, String userVerify) {
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
    this.userVerify = userVerify;
  }

  public User(String userName, String userEmail, String userPassword, String userPic, String userCountry, String userType, int userDobYear, int userDobMonth, int userDobDay, List<BudgetPlan> budgetPlans, BudgetPlan subscribedBudgetPlan, String enableReportNotification, String enableTipsNotification, String userVerify) {
    this.userName = userName;
    this.userEmail = userEmail;
    this.userPassword = userPassword;
    this.userPic = userPic;
    this.userCountry = userCountry;
    this.userType = userType;
    this.userDobYear = userDobYear;
    this.userDobMonth = userDobMonth;
    this.userDobDay = userDobDay;
    this.budgetPlans = budgetPlans;
    this.subscribedBudgetPlan = subscribedBudgetPlan;
    this.enableReportNotification = enableReportNotification;
    this.enableTipsNotification = enableTipsNotification;
    this.userVerify = userVerify;
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

  public String getUserVerify() {
    return userVerify;
  }

  public void setUserVerify(String userVerify) {
    this.userVerify = userVerify;
  }

  public List<BudgetPlan> getBudgetPlans() {
    return budgetPlans;
  }

  public void setBudgetPlans(List<BudgetPlan> budgetPlans) {
    this.budgetPlans = budgetPlans;
  }

  public BudgetPlan getSubscribedBudgetPlan() {
    return subscribedBudgetPlan;
  }

  public void setSubscribedBudgetPlan(BudgetPlan subscribedBudgetPlan) {
    this.subscribedBudgetPlan = subscribedBudgetPlan;
  }
  
  @PrePersist
  protected void onCreate() {
    if (this.enableReportNotification == null) {
      this.enableReportNotification = "on";
    }
    if (this.enableTipsNotification == null) {
      this.enableTipsNotification = "on";
    }
  }

}
