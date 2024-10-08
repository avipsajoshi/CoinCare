package com.coincare.servlets;

import com.coincare.dao.IncomeDao;
import com.coincare.dao.UserDao;
import com.coincare.entities.Income;
import com.coincare.entities.User;
import com.coincare.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class IncomeServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      String operation = request.getParameter("operationType");
      String user = request.getParameter("userId");
      HttpSession session = request.getSession();
      IncomeDao incDao = new IncomeDao(FactoryProvider.getFactory());
      UserDao userDao = new UserDao(FactoryProvider.getFactory());
      Income inc = null;
      boolean status = false;
      if (operation != null && operation.trim().equals("add")) {
        //add income
        User userAdd = userDao.getUserById(Integer.parseInt(user));
        String incSource = request.getParameter("inc-name");
        String incDescription = request.getParameter("inc-des");
        double incAmount = Double.parseDouble(request.getParameter("inc-price"));
        String mode = request.getParameter("mode");
        String incCategory = request.getParameter("catId");
        Timestamp currentTime;
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
        var now = LocalDateTime.now();
        currentTime = Timestamp.valueOf(now);
        inc = new Income(incSource, incDescription, incAmount, incCategory, currentTime, mode, userAdd);
        status = incDao.addIncome(inc);
        if (status) {
          session.setAttribute("message", "Income added");
          response.sendRedirect("./dashboard.jsp");
        } else {
          session.setAttribute("message", "Error adding income");
          response.sendRedirect("./income.jsp");
        }
        return;

      } else if (operation != null && operation.trim().equals("update")) {
        //update income
        int incomeIdToUpdate = Integer.parseInt(request.getParameter("incId"));
//        User userAdd = userDao.getUserById(Integer.parseInt(user));
        String incSource = request.getParameter("up-inc-name");
        String incDescription = request.getParameter("up-inc-des");
        double incAmount = Double.parseDouble(request.getParameter("up-inc-price"));
        String mode = request.getParameter("mode");
        String incCategory = request.getParameter("up-catId");
        status = incDao.updateIncome(incSource, incDescription, incAmount, mode, incCategory, incomeIdToUpdate);
        if (status) {
          session.setAttribute("message", "Income record updated");
        response.sendRedirect("./dashboard.jsp");
        } else {
          session.setAttribute("message", "Error updating income");
        response.sendRedirect("./income.jsp");
        }
        return;

      } else if (operation != null && operation.trim().equals("delete")) {
        //delete income with id
        System.out.println("Deleteing");
        int incomeIdToDelete = Integer.parseInt(request.getParameter("incId"));
        status = incDao.deleteIncome(incomeIdToDelete);
        if (status) {
          System.out.println("Deleted");
          session.setAttribute("message", "Income deleted");
        } else {
          System.out.println("Not Deleted");

          session.setAttribute("message", "Error deleting income");
        }
        response.sendRedirect("./income.jsp");
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
