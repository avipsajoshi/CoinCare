package com.coincare.servlets;

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
import java.util.Random;

/**
 * changes verify status, notification status of user
 */
public class SingleChangeServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      HttpSession session = request.getSession();
      UserDao userDao = new UserDao(FactoryProvider.getFactory());
      boolean status;
      String operation = request.getParameter("singlechangeBtn");
      System.out.println(operation);
      String useremail = request.getParameter("useremail");
      
      //sends otp in mail
      if (operation.trim().equals("email-verify")) {
        if (useremail != null || !useremail.equals("")) {
          Random rand = new Random();
          int otpvalue = rand.nextInt(1255650);
          session.setAttribute("sentOtp", String.valueOf(otpvalue));
          session.setAttribute("email", useremail);
          session.setAttribute("resetPass", "verify");
          String message = "Your email verification OTP is : " + otpvalue + ". This OTP is valid only for 30 minutes, starting from the time you clicked on 'Send OTP'";
          try {
            SendMail mail = new SendMail(message, "Email Verification", useremail);
            mail.sendEmail();

          } catch (Exception e) {
            session.setAttribute("message", "An error occured, please try again");
            response.sendRedirect("./settings.jsp");
          } finally {
            response.sendRedirect("./reset-password.jsp");
            return;
          }
        }
      } else if (operation.trim().equals("verification")) {
        System.out.println("Verification 2");
        User vUser = (User) session.getAttribute("logged_user");
        String userVemail = vUser.getUserEmail();
        out.print("verification page");
        String otp = request.getParameter("otp-value-verify");
        String sentOtp = (String) session.getAttribute("sentOtp");
        System.out.println("user otp" + otp);
        System.out.println("system otp" + sentOtp);
        if (otp.equals(sentOtp)) {
          System.out.println("system otp equal");
          status = userDao.toggleUserNotificationSettings(userVemail, "verify");
          System.out.println(status);
          if (status) {
            session.setAttribute("message", "Change Successful");
            session.removeAttribute("resetPass");
            session.removeAttribute("logged_user");
            session.setAttribute("logged_user", userDao.getUseByEmail(userVemail));
            
            response.sendRedirect("./settings.jsp");
          }

        } else {
          session.setAttribute("message", "Incorrect OTP please try again!");
          response.sendRedirect("./reset-password.jsp");
          return;
        }
      } else if (operation.trim().equals("statement")) {
        status = userDao.toggleUserNotificationSettings(useremail, "statement");
        if (status) {
          session.setAttribute("message", "Change Successful");
          response.sendRedirect("./settings.jsp");

        }
      } else if (operation.trim().equals("tips")) {
        status = userDao.toggleUserNotificationSettings(useremail, "tips");
        if (status) {
          session.setAttribute("message", "Change Successful");
          response.sendRedirect("./settings.jsp");

        }
      } else {
        session.setAttribute("message", "Error changing settings. Please try again.");
        response.sendRedirect("./settings.jsp");

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
