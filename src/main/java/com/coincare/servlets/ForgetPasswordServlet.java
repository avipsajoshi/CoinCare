package com.coincare.servlets;

import com.coincare.helper.SendMail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;

public class ForgetPasswordServlet extends HttpServlet {
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    String mailTo = request.getParameter("user_email");
    int otpvalue = 0;
    try (PrintWriter out = response.getWriter()) {
      HttpSession httpSession = request.getSession();
      if(mailTo!=null|| !mailTo.equals("")){
        Random rand = new Random();
        otpvalue = rand.nextInt(1255650);
        httpSession.setAttribute("sentOtp", String.valueOf(otpvalue));
        httpSession.setAttribute("email", mailTo);
        httpSession.setAttribute("resetPass", "otp");
        String message = "Your Password Recovery OTP is : " + otpvalue + ". This OTP is valid only for 30 minutes, starting from the time you clicked on 'Send OTP'";
        SendMail mail = new SendMail(message, "Password Recovery", mailTo);
        mail.sendEmail();
        response.sendRedirect("./reset-password.jsp");
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
