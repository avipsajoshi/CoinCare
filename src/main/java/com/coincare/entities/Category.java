package com.coincare.entities;

import jakarta.persistence.*;

@Entity
@Table(name="category")
class Category {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int categoriId;
  @Column(length = 1500, name = "categoryTitle")
  private String categoryTitle;
  @Column(length = 1500, name = "categoryDescription")
  private String categoryDescription;
//  private User categoryCreator;
  //many to one
//  @OneToOne
//  private SuperCategory supercategoryType;
//  @ManyToOne(fetch = FetchType.LAZY)
//  private User user;
}
