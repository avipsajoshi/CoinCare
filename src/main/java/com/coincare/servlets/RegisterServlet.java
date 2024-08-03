package com.coincare.servlets;

import com.coincare.dao.UserDao;
import com.coincare.entities.User;
import com.coincare.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.Year;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class RegisterServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      String userName = request.getParameter("user_name");
      String userEmail = request.getParameter("user_email");
      String userPassword = request.getParameter("user_password");
      UserDao userDao = new UserDao(FactoryProvider.getFactory());
      HttpSession httpSession = request.getSession();
      if (userName.isEmpty()) {
        httpSession.setAttribute("message", "Name Cannot be empty");
        response.sendRedirect("./register.jsp");
        return;// exit early
      }
      int year = Year.now().getValue();
      User existUser = userDao.getUseByEmail(userEmail);
      if (existUser == null) {
        User user = new User(userName, userEmail, userPassword, "./user-images/user-image.png","Enter Country","user",  year, 1, 1, "on","on","Verify");
        Session hibernateSession = FactoryProvider.getFactory().openSession();
        Transaction tx = hibernateSession.beginTransaction();
        try {
          hibernateSession.persist(user);
          tx.commit();

          httpSession.setAttribute("logged_user", user);
          response.sendRedirect("./LoginServlet");
        } catch (Exception e) {
          if (tx != null) {

            tx.rollback();
          }
          httpSession.setAttribute("message", "Unsuccessful. Please Try Again");
          response.sendRedirect("./register.jsp");
        } finally {
          hibernateSession.close();
        }
      }
      else{
        if (userEmail.equals(existUser.getUserEmail())) {
        httpSession.setAttribute("message", "Email already exists");
        response.sendRedirect("./register.jsp");
        return;//exit early
      }
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
