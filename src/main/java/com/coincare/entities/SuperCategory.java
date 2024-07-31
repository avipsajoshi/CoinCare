package com.coincare.entities;

import jakarta.persistence.*;


@Entity
@Table(name="superCategory")
public class SuperCategory {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int superCategoryId;
  @Column(name="superCategoryTitle")
  private String supercategoryTitle;
//  @OneToOne(mappedBy="supercategory")
//  private Category category;
  
  
}
