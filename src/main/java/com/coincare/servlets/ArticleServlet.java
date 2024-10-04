package com.coincare.servlets;

import com.coincare.dao.ArticleDao;
import com.coincare.dao.UserDao;
import com.coincare.entities.Article;
import com.coincare.entities.User;
import com.coincare.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Dell
 */
public class ArticleServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      String operation = request.getParameter("operationType");
      String adminId = request.getParameter("adminId");
      HttpSession session = request.getSession();
      ArticleDao articleDao = new ArticleDao(FactoryProvider.getFactory());
      UserDao adminDao = new UserDao(FactoryProvider.getFactory());
      Article article = null;
      boolean status = false;

      if (operation.equals("add")) {
        // Add article
        User admin = adminDao.getAdminById(Integer.parseInt(adminId));
        String articleTitle = request.getParameter("articleTitle");
        String articleBody = request.getParameter("articleBody");
        String publish = request.getParameter("publishStatus");

        article = new Article(articleTitle, articleBody, publish, admin);
        status = articleDao.addArticle(article);

        if (status) {
          session.setAttribute("message", "Article added successfully");
        } else {
          session.setAttribute("message", "Error adding article");
        }
        response.sendRedirect("./articles.jsp");
        return;

      } else if (operation.equals("update")) {
        // Update article
        int articleIdToUpdate = Integer.parseInt(request.getParameter("articleId"));
        String articleTitle = request.getParameter("up-articleTitle");
        String articleBody = request.getParameter("up-articleBody");
        String publish = request.getParameter("up-publishStatus");

        status = articleDao.updateArticle(articleTitle, articleBody, publish, articleIdToUpdate);

        if (status) {
          session.setAttribute("message", "Article updated successfully");
        } else {
          session.setAttribute("message", "Error updating article");
        }
        response.sendRedirect("./articles.jsp");
        return;

      } else if (operation.equals("delete")) {
        // Delete article
        int articleIdToDelete = Integer.parseInt(request.getParameter("articleId"));
        status = articleDao.deleteById(articleIdToDelete);
        if (status) {
          session.setAttribute("message", "Article deleted successfully");
        } else {
          session.setAttribute("message", "Error deleting article");
        }
        response.sendRedirect("./articles.jsp");
        return;
      }
    }
  }

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    processRequest(request, response);
  }

  /**
   * Handles the HTTP <code>POST</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    processRequest(request, response);
  }

  /**
   * Returns a short description of the servlet.
   *
   * @return a String containing servlet description
   */
  @Override
  public String getServletInfo() {
    return "Short description";
  }// </editor-fold>

}
