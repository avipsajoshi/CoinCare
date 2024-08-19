package com.coincare.dao;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import com.coincare.entities.Category;
import com.coincare.entities.User;
import com.coincare.helper.FactoryProvider;
import java.util.ArrayList;
import org.hibernate.query.Query;

public class CategoryDao {

  private SessionFactory factory;

  public CategoryDao(SessionFactory factory) {
    this.factory = factory;
  }

  //save the category to db
  public boolean addCategory(Category cat) {
    boolean f = false;
    try {
      Session session = this.factory.openSession();
      Transaction tx = session.beginTransaction();
      session.persist(cat);
      tx.commit();
      session.close();
      f = true;
    } catch (Exception e) {
      e.printStackTrace();
      f = false;
    }
    return f;
  }

  public List<Category> getAllCategory() {
    List<Category> listOfCategorys = new ArrayList<>();
    Session s = this.factory.openSession();
    listOfCategorys = s.createQuery("From Category", Category.class).list();
    s.close();
    return listOfCategorys;
  }

  //get category with admin type and user id
  public Category getCategoryById(int categoryId) {
    Category cat = null;
    try {
      Session session = this.factory.openSession();
      //use get or load - get will return null value
      cat = session.get(Category.class, categoryId);
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return cat;
  }

  //get category by user and admin for new expense
  public List<Category> getAllCategoryForNewExpense(int userId) {
    List<Category> listOfCategories = new ArrayList<>();
    int adminId = 3;
    Session s = this.factory.openSession();
    Query q = s.createQuery("From Category WHERE user.userId=:uid or user.userId=:aid ORDER BY categoryType desc", Category.class);
    q.setParameter("uid", userId);
    q.setParameter("aid", adminId);
    listOfCategories = q.list();
    return listOfCategories;
  }

  //get category by user and admin for new expense
  public List<Category> getAllCategoryByUserId(int userId) {
    List<Category> listOfCategories = new ArrayList<>();

    Session s = this.factory.openSession();
    Query q = s.createQuery("From Category WHERE user.userId=:uid", Category.class);
    q.setParameter("uid", userId);
    listOfCategories = q.list();
    return listOfCategories;
  }

  //update category by user
  public boolean updateCategory(String categoryTitle, String categoryDescription, String categoryType, int categoryId, int userId) {
    boolean status = false;
    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "update Category SET categoryTitle=:title, categoryDescription=:des, categoryType=:type WHERE categoryId=:id and user_userId=:uid";
      rowCount = session.createMutationQuery(hql)
              .setParameter("title", categoryTitle)
              .setParameter("des", categoryDescription)
              .setParameter("type", categoryType)
              .setParameter("id", categoryId)
              .setParameter("uid", userId)
              .executeUpdate();
      System.out.println("Rows affected: " + rowCount);
      if (rowCount >= 1) {
        status = true;
      }
      tx.commit();
    } catch (Exception e) {
      e.printStackTrace();
      tx.rollback();
      status = false;
    } finally {
      session.close();
    }
    return status;
  }

  //delete category
  public boolean deleteCategoryById(int categoryId) {
    boolean status = false;

    String hql = "";
    int rowCount = 0;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      hql = "DELETE from Category WHERE categoryId=:id";
      rowCount = session.createMutationQuery(hql)
              .setParameter("id", categoryId)
              .executeUpdate();
      System.out.println("Rows affected: " + rowCount);
      if (rowCount >= 1) {
        status = true;
      }
      tx.commit();
    } catch (Exception e) {
      e.printStackTrace();
      tx.rollback();
      status = false;
    } finally {
      session.close();
    }
    return status;
  }

  //delete multiple category
  //
}
