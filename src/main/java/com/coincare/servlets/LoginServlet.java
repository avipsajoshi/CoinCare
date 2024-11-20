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

public class LoginServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      HttpSession httpSession = request.getSession();
      if (httpSession.getAttribute("logged_user") != null) {
        try {
          User alreadyLogged = (User) httpSession.getAttribute("logged_user");
//          response.sendRedirect("index.jsp");
          if (alreadyLogged.getUserType().equals("admin") || alreadyLogged.getUserType().equals("owner")) {
            //admin-dashboard.jsp
            response.sendRedirect("admin-dashboard.jsp");
          } else if (alreadyLogged.getUserType().equals("user")) {
            //client.jsp
            response.sendRedirect("dashboard.jsp");
          } else {
          }
        } catch (Exception e) {
          //print error in console
          e.printStackTrace();
        }
      } else {
        try {
          //get request from form
          String userEmail = request.getParameter("user_email");
          String userPassword = request.getParameter("user_password");
          // validations
          if (userEmail.isEmpty() || userPassword.isEmpty()) {
            out.println("Email Cannot be blank");
            httpSession.setAttribute("message", "Invalid email or password!");
            // ("key", "value");
            response.sendRedirect("login.jsp");
          } else {
            //creating new user object to fetch data
            //authenticatoion dao layer (data access object)
            UserDao userDao = new UserDao(FactoryProvider.getFactory());
            User logged_user = userDao.getUserByEmailandPass(userEmail, userPassword);
            if (logged_user == null) {
              httpSession.setAttribute("message", "Invalid email or password!");
              // ("key", "value");
              response.sendRedirect("login.jsp");
            } else {
              httpSession.setAttribute("logged_user", logged_user);
              //          response.sendRedirect("index.jsp");
              if(logged_user.getUserType().equals("admin") || logged_user.getUserType().equals("owner")) {
                //admin-dashboard.jsp
                response.sendRedirect("admin-dashboard.jsp");
              } else if (logged_user.getUserType().equals("user")) {
                //client.jsp
                response.sendRedirect("dashboard.jsp");
              } else {
                out.println("Error identifying user");
              }
            }
          }
        } catch (Exception e) {
          //print error in console
          e.printStackTrace();
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
