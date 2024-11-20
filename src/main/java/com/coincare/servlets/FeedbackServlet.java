package com.coincare.servlets;

import com.coincare.dao.FeedbackDao;
import com.coincare.dao.UserDao;
import com.coincare.entities.Feedback;
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
public class FeedbackServlet extends HttpServlet {

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
   * methods.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      HttpSession session = request.getSession();
      int userId = Integer.parseInt(request.getParameter("userId"));
      String feedbackDescription = request.getParameter("feedback");

      // Input validation
      if (feedbackDescription == null || feedbackDescription.trim().isEmpty()) {
        response.sendRedirect("errorPage.jsp"); // Handle error if feedback is empty
        return;
      }
      FeedbackDao feedbackDao = new FeedbackDao(FactoryProvider.getFactory());
      UserDao userDao = new UserDao(FactoryProvider.getFactory());

      // Create User and Feedback objects
      User user = userDao.getUserById(userId); // Fetch the user from the DB
      Feedback feedback = new Feedback(feedbackDescription, user);

      // Add feedback to the database
      boolean isSuccess = feedbackDao.addFeedback(feedback);

      if (isSuccess) {
        session.setAttribute("message", "Feedback sent! Thank you!!");
      } else {
        session.setAttribute("message", "Error sending feedback. Please try again");
      }
        response.sendRedirect("./feedback.jsp"); // Redirect to error page in case of failure
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
