package com.coincare.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "feedback")
public class Feedback {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int feedbackId;

  @Column(length = 1500, name = "feedbackDescription")
  private String feedbackDescription;

  @ManyToOne
  private User user;

  public Feedback() {
  }

  public Feedback(int feedbackId, String feedbackDescription, User user) {
    this.feedbackId = feedbackId;
    this.feedbackDescription = feedbackDescription;
    this.user = user;
  }

  public Feedback(String feedbackDescription, User user) {
    this.feedbackDescription = feedbackDescription;
    this.user = user;
  }

  // Getters and Setters
  public int getFeedbackId() {
    return feedbackId;
  }

  public void setFeedbackId(int feedbackId) {
    this.feedbackId = feedbackId;
  }

  public String getFeedbackDescription() {
    return feedbackDescription;
  }

  public void setFeedbackDescription(String feedbackDescription) {
    this.feedbackDescription = feedbackDescription;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

}
