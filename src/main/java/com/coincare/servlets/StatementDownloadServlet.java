package com.coincare.servlets;

import com.coincare.dao.UserDao;
import com.coincare.entities.UserFinancials;
import com.coincare.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.List;

public class StatementDownloadServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    try (PrintWriter out = response.getWriter()) {
      UserDao uDao = new UserDao(FactoryProvider.getFactory());
      // Set response content type and headers for CSV file
      response.setContentType("text/csv");
      response.setHeader("Content-Disposition", "attachment; filename=\"transactions.csv\"");
      String user = request.getParameter("userId");
      String when = request.getParameter("time");
      int userId = Integer.parseInt(user);
      List<UserFinancials> transactions = null;
      // Sample data
      if (when.equals("weekly")) {
        transactions = uDao.getUserReportForTheWeek(userId, LocalDate.now());

      }
      if (when.equals("monthly")) {
        transactions = uDao.getUserReportForTheMonth(userId, LocalDate.now());

      }
      if (when.equals("yearly")) {
        transactions = uDao.getUserReportForTheYear(userId, LocalDate.now());
      }

      out.println("transactionId,type,title,description,mode,category,amount,date");

      // Loop over transactions and write each as a CSV row
      for (UserFinancials transaction : transactions) {
        out.printf("%d,%s,%s,%s,%s,%s,%.2f,%s\n",
                transaction.getTransactionId(),
                transaction.getType(),
                transaction.getTitle(),
                transaction.getDescription(),
                transaction.getMode(),
                transaction.getCategory(),
                transaction.getAmount(),
                transaction.getDate().toString()
        );
      }

      out.flush();
      out.close();
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
