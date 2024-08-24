package com.coincare.servlets;

import com.coincare.dao.ExpenseDao;
import com.coincare.dao.UserDao;
import com.coincare.dao.CategoryDao;
import com.coincare.entities.Category;
import com.coincare.entities.Expense;
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

public class ExpenseServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      String operation = request.getParameter("operationType");
      String user = request.getParameter("userId");
      HttpSession session = request.getSession();
      ExpenseDao expDao = new ExpenseDao(FactoryProvider.getFactory());

      UserDao userDao = new UserDao(FactoryProvider.getFactory());
      CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
      Expense exp = null;
      boolean status = false;
      if (operation.equals("add")) {
        //add expense
        User userAdd = userDao.getUserById(Integer.parseInt(user));
        String expTitle = request.getParameter("exp-name");
        String expRemark = request.getParameter("exp-description");
        double expAmount = Double.parseDouble(request.getParameter("exp-price"));
        String mode = request.getParameter("mode");
        String expCategory = request.getParameter("catId");
        Category cat = catDao.getCategoryById(Integer.parseInt(expCategory));
        Timestamp currentTime;
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
        var now = LocalDateTime.now();
        currentTime = Timestamp.valueOf(now);
        exp = new Expense(expTitle, expRemark, expAmount, currentTime, mode, cat, userAdd);
        status = expDao.addExpense(exp);
        if (status) {
          session.setAttribute("message", "Expense added");
        } else {
          session.setAttribute("message", "Error adding expense");
        }
        response.sendRedirect("./dashboard.jsp");
        return;

      } else if (operation.equals("update")) {
        //update expense
        int expenseIdToUpdate = Integer.parseInt(request.getParameter("expId"));
        User userAdd = userDao.getUserById(Integer.parseInt(user));
        String expTitle = request.getParameter("up-exp-name");
        String expRemark = request.getParameter("up-exp-description");
        double expAmount = Double.parseDouble(request.getParameter("up-exp-price"));
        String mode = request.getParameter("mode");
        String expCategory = request.getParameter("catId");
        int cat = Integer.parseInt(expCategory);
        status = expDao.updateExpense(expTitle, expRemark, expAmount,mode, cat, expenseIdToUpdate);
        if (status) {
          session.setAttribute("message", "Expense record updated");
        } else {
          session.setAttribute("message", "Error updating expense");
        }
        response.sendRedirect("./dashboard.jsp");
        return;

      } else if (operation.equals("delete")) {
        //delete expense with id
        System.out.println("Deleteing");
        int expenseIdToDelete = Integer.parseInt(request.getParameter("expId"));
        status = expDao.deleteById(expenseIdToDelete);
        if (status) {
          System.out.println("Deleted");
          session.setAttribute("message", "Expense deleted");
        } else {
          System.out.println("Not Deleted");

          session.setAttribute("message", "Error deleting expense");
        }
        response.sendRedirect("./dashboard.jsp");
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
