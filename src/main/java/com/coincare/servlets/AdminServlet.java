package com.coincare.servlets;

import com.coincare.dao.CategoryDao;
import com.coincare.dao.UserDao;
import com.coincare.entities.User;
import com.coincare.helper.FactoryProvider;
import com.coincare.helper.SendMail;
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
public class AdminServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      HttpSession session = request.getSession();
      String operation = request.getParameter("operationType");
      UserDao userDao = new UserDao(FactoryProvider.getFactory());
      CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
      boolean status = false;

      //send mail to user for inappropriate profile details
      if (operation.trim().equals("userProfileInappropriate")) {
        String user = request.getParameter("userId");
        int userId = Integer.parseInt(user);
        User toUser = userDao.getUserById(userId);
        String useremail = toUser.getUserEmail();
        String message = "We’ve noticed that your name or profile picture may not meet our guidelines. Please take a moment to review and update it to ensure it aligns with our standards. Thank you for your understanding.";

        try {
          status = userDao.updateUserPicture(useremail, "images/user-images/user-image.png");
          SendMail mail = new SendMail(message, "Important: Please Review Your Profile Details", useremail);
          mail.sendEmail();
          if (status) {
            session.setAttribute("message", "Change Successful");
          }
        } catch (Exception e) {
          session.setAttribute("message", "An error occured, please try again");
          response.sendRedirect("./admin-dashboard.jsp");
        }
        return;
      } //change user type to admin
      else if (operation.trim().equals("makeAdmin")) {
        String user = request.getParameter("userId");
        int userId = Integer.parseInt(user);
        status = userDao.updateUserType("admin", userId);
        if (status) {
          session.setAttribute("message", "Change Successful");
        } else {
          session.setAttribute("message", "Change Unsuccessful");
        }
        response.sendRedirect("./admin-dashboard.jsp");
        return;
      } //change admin type to owner
      else if (operation.trim().equals("makeAdminOwner")) {
        String user = request.getParameter("adminId");
        int userId = Integer.parseInt(user);
        status = userDao.updateUserType("owner", userId);
        if (status) {
          session.setAttribute("message", "Admin Removed");
        } else {
          session.setAttribute("message", "Change Unsuccessful");
        }
        response.sendRedirect("./admin-dashboard.jsp");
        return;
      } // remove single admin and make them normal user
      else if (operation.trim().equals("removeAsAdmin")) {
        String user = request.getParameter("adminId");
        int userId = Integer.parseInt(user);
        status = userDao.updateUserType("user", userId);
        if (status) {
          session.setAttribute("message", "Admin Removed");
        } else {
          session.setAttribute("message", "Change Unsuccessful");
        }
        response.sendRedirect("./admin-dashboard.jsp");
        return;
      }
      
    }
  } // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet
    (HttpServletRequest request, HttpServletResponse response)
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
    protected void doPost
    (HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
      processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo
    
    
    
    
    
    
      
    
    
      () {
    return "Short description";
    }// </editor-fold>
}
