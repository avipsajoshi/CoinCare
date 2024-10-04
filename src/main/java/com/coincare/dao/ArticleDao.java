package com.coincare.dao;


import com.coincare.entities.Article;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ArticleDao {

  private SessionFactory factory;

  public ArticleDao(SessionFactory factory) {
    this.factory = factory;
  }

  // Method to add a new article
  public boolean addArticle(Article article) {
    boolean status = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      session.persist(article);
      tx.commit();
      status = true;
    } catch (Exception e) {
      tx.rollback();
      e.printStackTrace();
    } finally {
      session.close();
    }
    return status;
  }

  // Method to get an article by its ID
  public Article getArticleById(int id) {
    Article article = null;
    try {
      Session session = this.factory.openSession();
      article = session.get(Article.class, id);
      session.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return article;
  }

  // Method to get all articles
  public List<Article> getAllArticles() {
    List<Article> articles = null;
    try {
      Session session = this.factory.openSession();
      Query<Article> query = session.createQuery("from Article", Article.class);
      articles = query.list();
      session.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return articles;
  }

  // Method to update an article
  public boolean updateArticle(String title, String body, String status, int articleId) {
    boolean updated = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      String hql = "update Article SET articleTitle = :title, articleBody = :body, publishStatus = :status WHERE articleId = :id";
      int rowCount = session.createMutationQuery(hql)
              .setParameter("title", title)
              .setParameter("body", body)
              .setParameter("status", status)
              .setParameter("id", articleId)
              .executeUpdate();
      if (rowCount > 0) {
        updated = true;
      }
      tx.commit();
    } catch (Exception e) {
      tx.rollback();
      e.printStackTrace();
    } finally {
      session.close();
    }
    return updated;
  }

  // Method to delete an article by its ID
  public boolean deleteById(int articleId) {
    boolean deleted = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      String hql = "DELETE from Article WHERE articleId = :id";
      int rowCount = session.createMutationQuery(hql)
              .setParameter("id", articleId)
              .executeUpdate();
      if (rowCount > 0) {
        deleted = true;
      }
      tx.commit();
    } catch (Exception e) {
      tx.rollback();
      e.printStackTrace();
    } finally {
      session.close();
    }
    return deleted;
  }

  // Method to get articles by an admin ID
  public List<Article> getArticlesByAdminId(int adminId) {
    List<Article> articles = null;
    try {
      Session session = this.factory.openSession();
      Query<Article> query = session.createQuery("from Article as a WHERE a.admin.adminId = :adminId", Article.class);
      query.setParameter("adminId", adminId);
      articles = query.list();
      session.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return articles;
  }
  
  public List<Article> getArticlesPublished() {
    List<Article> articles = null;
    try {
      Session session = this.factory.openSession();
      Query<Article> query = session.createQuery("from Article as a WHERE  publishStatus= :adminId", Article.class);
      query.setParameter("adminId", "Published");
      articles = query.list();
      session.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return articles;
  }
}
