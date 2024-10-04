package com.coincare.servlets;

import com.coincare.dao.CategoryDao;
import com.coincare.entities.Expense;
import com.coincare.dao.ExpenseDao;
import com.coincare.dao.UserDao;
import com.coincare.entities.Category;
import com.coincare.entities.User;
import com.coincare.helper.FactoryProvider;
import com.coincare.service.ExpensePredictionService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;

public class ExpensePredictionServlet extends HttpServlet {

  private ExpensePredictionService expensePredictionService = new ExpensePredictionService();

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {

    // Get user ID (assuming it's available in session or passed in request)
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      HttpSession httpSession = request.getSession();
      User alreadyLogged = (User) httpSession.getAttribute("logged_user");
      
      int userId = alreadyLogged.getUserId();
      String selectedCategory = request.getParameter("category");
      int catId = Integer.parseInt(selectedCategory);
      System.out.println("Received category: " + selectedCategory);
      System.out.println("Received userId: " + userId);

      if (!selectedCategory.isEmpty()) {
        ExpenseDao eDao = new ExpenseDao(FactoryProvider.getFactory());
        // Get user's expenses from the database
        List<Expense> expenses = eDao.getExpenseByUserId(userId);
//        List<Expense> expenses = eDao.getExpenseByUserIdandCategory(userId,catId);
        LocalDate now = LocalDate.now();
//        List<Expense> expenses = eDao.getUserExpenseForTheMonth(userId, now);
        CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
        Category cat = cDao.getCategoryById(catId);
        String category = cat.getCategoryTitle();
        // Predict expense for the selected category
        double predictedExpense = expensePredictionService.predictExpense(expenses, category, now);

        // Send the predicted expense back as the response
        response.setContentType("text/plain");
        System.out.println("Expense predicted: "+String.valueOf(predictedExpense));
        out.write(String.valueOf(predictedExpense));
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
