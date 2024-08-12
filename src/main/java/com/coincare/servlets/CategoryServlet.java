package com.coincare.servlets;

import com.coincare.dao.UserDao;
import com.coincare.dao.CategoryDao;
import com.coincare.entities.Category;
import com.coincare.entities.User;
import com.coincare.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CategoryServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      String operation = request.getParameter("operationType");
      String user = request.getParameter("userId");
      HttpSession session = request.getSession();
      CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
      UserDao userDao = new UserDao(FactoryProvider.getFactory());
      Category cat = null;
      boolean status = false;
      if (operation.trim().equals("add")) {
        //add user category
        if (status) {
          session.setAttribute("message", "Category added");
        } else {
          session.setAttribute("message", "Error adding category");
        }
        response.sendRedirect("./settings.jsp");
        return;

      } else if (operation.trim().equals("update")) {
        //update user category
        if (status) {
          session.setAttribute("message", "Category record updated");
        } else {
          session.setAttribute("message", "Error updating category");
        }
        response.sendRedirect("./settings.jsp");
        return;

      } else if (operation.trim().equals("delete")) {
        //delete user category with id
        if (status) {
          System.out.println("Deleted");
          session.setAttribute("message", "Category deleted");
        } else {
          System.out.println("Not Deleted");

          session.setAttribute("message", "Error deleting category");
        }
        response.sendRedirect("./settings.jsp");
        return;
      } else if (operation.trim().equals("adminCatAdd")) {
        //add admin category
        if (status) {
          session.setAttribute("message", "Category added");
        } else {
          session.setAttribute("message", "Error adding category");
        }
        response.sendRedirect("./settings.jsp");
        return;

      } else if (operation.trim().equals("adminCatUpdate")) {
        //update admin category
        if (status) {
          session.setAttribute("message", "Category record updated");
        } else {
          session.setAttribute("message", "Error updating category");
        }
        response.sendRedirect("./settings.jsp");
        return;

      } else if (operation.trim().equals("adminCatDelete")) {
        //delete admin category with id
        if (status) {
          System.out.println("Deleted");
          session.setAttribute("message", "Category deleted");
        } else {
          System.out.println("Not Deleted");

          session.setAttribute("message", "Error deleting category");
        }
        response.sendRedirect("./settings.jsp");
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
