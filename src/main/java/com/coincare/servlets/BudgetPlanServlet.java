package com.coincare.servlets;

import com.coincare.dao.UserDao;
import com.coincare.dao.BudgetPlanDao;
import com.coincare.entities.BudgetPlan;
import com.coincare.entities.User;
import com.coincare.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BudgetPlanServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      String operation = request.getParameter("operationType");
      String userid = request.getParameter("userId");
      HttpSession session = request.getSession();
      BudgetPlanDao bpDao = new BudgetPlanDao(FactoryProvider.getFactory());
      UserDao userDao = new UserDao(FactoryProvider.getFactory());
      BudgetPlan bp = null;
      boolean status = false;
      if (operation.trim().equals("add")) {
        //add user bp
        String budgetTitle = request.getParameter("budget-name");
        String budgetDes = request.getParameter("budget-description");
        String budgetExp = request.getParameter("budgetExp");
        String budgetWant = request.getParameter("budgetWant");
        String budgetSave = request.getParameter("budgetSave");

        int exp = Integer.parseInt(budgetExp);
        int want = Integer.parseInt(budgetWant);
        int save = Integer.parseInt(budgetSave);
        User user = userDao.getUserById(Integer.parseInt(userid));
        bp = new BudgetPlan(budgetTitle, budgetDes, exp, want, save, user);
        status = bpDao.addBudgetPlan(bp);
        if (status) {
          session.setAttribute("message", "BudgetPlan added");
        } else {
          session.setAttribute("message", "Error adding bpegory");
        }
        response.sendRedirect("./budget.jsp");
        return;

      } else if (operation.trim().equals("update")) {
        //update user bp
        String budgetid = request.getParameter("up-budget-id");
        String budgetTitle = request.getParameter("up-budget-name");
        String budgetDes = request.getParameter("up-budget-description");
        String budgetExp = request.getParameter("up-budgetExp");
        String budgetWant = request.getParameter("up-budgetWant");
        String budgetSave = request.getParameter("up-budgetSave");

        int bpId = Integer.parseInt(budgetid);
        int exp = Integer.parseInt(budgetExp);
        int want = 0;
        if (budgetWant != null) {
          want = Integer.parseInt(budgetWant);
        }
        int save = Integer.parseInt(budgetSave);
        int user = Integer.parseInt(userid);

        status = bpDao.updateBudgetPlanByUserId(budgetTitle, budgetDes, exp, want, save, bpId, user);
        if (status) {
          session.setAttribute("message", "BudgetPlan record updated");
        } else {
          session.setAttribute("message", "Error updating bpegory");
        }
        response.sendRedirect("./budget.jsp");

      } else if (operation.trim().equals("delete")) {
        //delete user bp with id        
        String budgetid = request.getParameter("budget-id");
        int bpId = Integer.parseInt(budgetid);
        status = bpDao.deleteBudgetPlanById(bpId);
        if (status) {
          System.out.println("Deleted");
          session.setAttribute("message", "BudgetPlan deleted");
        } else {
          System.out.println("Not Deleted");

          session.setAttribute("message", "Error deleting bpegory");
        }
        response.sendRedirect("./budget.jsp");
        return;
      } else if (operation.trim().equals("adminBpAdd")) {
        //add admin bp
        String budgetTitle = request.getParameter("budget-name");
        String budgetDes = request.getParameter("budget-description");
        String budgetExp = request.getParameter("budgetExp");
        String budgetWant = request.getParameter("budgetWant");
        String budgetSave = request.getParameter("budgetSave");

        int exp = Integer.parseInt(budgetExp);
        int want = Integer.parseInt(budgetWant);
        int save = Integer.parseInt(budgetSave);
        User user = userDao.getUserById(Integer.parseInt(userid));
        bp = new BudgetPlan(budgetTitle, budgetDes, exp, want, save, user);
        status = bpDao.addBudgetPlan(bp);
        if (status) {
          session.setAttribute("message", "BudgetPlan added");
        } else {
          session.setAttribute("message", "Error adding bpegory");
        }
        response.sendRedirect("./admin-dashboard.jsp");
        return;

      } else if (operation.trim().equals("adminBpUpdate")) {
        //update admin bp
        String budgetid = request.getParameter("up-budget-id");
        String budgetTitle = request.getParameter("up-budget-name");
        String budgetDes = request.getParameter("up-budget-description");
        String budgetExp = request.getParameter("up-budgetExp");
        String budgetWant = request.getParameter("up-budgetWant");
        String budgetSave = request.getParameter("up-budgetSave");

        int bpId = Integer.parseInt(budgetid);
        int exp = Integer.parseInt(budgetExp);
        int want = 0;
        if (budgetWant != null) {
          want = Integer.parseInt(budgetWant);
        }
        int save = Integer.parseInt(budgetSave);
        int user = Integer.parseInt(userid);

        status = bpDao.updateBudgetPlanByUserId(budgetTitle, budgetDes, exp, want, save, bpId, user);
        if (status) {
          session.setAttribute("message", "BudgetPlan record updated");
        } else {
          session.setAttribute("message", "Error updating bpegory");
        }
        response.sendRedirect("./admin-dashboard.jsp");
        return;

      } else if (operation.trim().equals("adminBpDelete")) {
        //delete admin bp with id
        String budgetid = request.getParameter("budget-id");
        int bpId = Integer.parseInt(budgetid);
        status = bpDao.deleteBudgetPlanById(bpId);
        if (status) {
          System.out.println("Deleted");
          session.setAttribute("message", "BudgetPlan deleted");
        } else {
          System.out.println("Not Deleted");

          session.setAttribute("message", "Error deleting bpegory");
        }
        response.sendRedirect("./admin-dashboard.jsp");
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
