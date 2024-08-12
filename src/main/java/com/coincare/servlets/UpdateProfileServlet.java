package com.coincare.servlets;

import com.coincare.dao.UserDao;
import com.coincare.helper.FactoryProvider;
import com.coincare.helper.MinorHelper;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Collection;

@MultipartConfig
public class UpdateProfileServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      HttpSession session = request.getSession();
      UserDao userDao = new UserDao(FactoryProvider.getFactory());
      boolean success;
      String useremail = request.getParameter("useremail");
      String operationType = request.getParameter("profileBtn");
      // Debug statement to check the parameters
      System.out.println("Operation Type: " + operationType);
      System.out.println("User Email: " + useremail);
      if (operationType == null) {
        session.setAttribute("message", "Operation type is missing. Please try again.");
        response.sendRedirect("./settings.jsp");
        return;  
      }
      if (operationType.equals("1")) {
        String username = request.getParameter("user-name");
        if (username == null && username.isEmpty()) {
          session.setAttribute("message", "Update unsuccessful. Please Try Again");
          response.sendRedirect("./settings.jsp");
          return;
        }
        String dobYear = request.getParameter("user-dob-year");
        int year = Integer.parseInt(dobYear);
        String dobMonth = request.getParameter("user-dob-month");
        int month = MinorHelper.getMonth(dobMonth);
        String dobDay = request.getParameter("user-dob-day");
        int day = Integer.parseInt(dobDay);
        String country = request.getParameter("user-country");
        if (country == null && country.isEmpty()) {
          session.setAttribute("message", "Update unsuccessful. Please Try Again");
          response.sendRedirect("./settings.jsp");
          return;
        }
        success = userDao.updateUserProfile(useremail, username, year, month, day, country);
        if (!success) {
          session.setAttribute("message", "Update unsuccessful. Please Try Again");
        } else {
          session.setAttribute("message", "Profile updated successfully.");
        }

      } else if (operationType.equals("2")) {
        Part filePart = request.getPart("user-update-image");
        String fileName = filePart.getSubmittedFileName();
        // Check if a file was actually uploaded
        if (fileName != null && !fileName.isEmpty()) {
          try {
            // Get the real path to store the file
            String uploadDirectory = "/images/user-images/";
            String realPath = getServletContext().getRealPath(uploadDirectory);
            String filePath = realPath + File.separator + fileName;

            // Upload the file
            try (InputStream inputStream = filePart.getInputStream(); FileOutputStream outputStream = new FileOutputStream(filePath)) {
              byte[] buffer = new byte[1024];
              int bytesRead;
              while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
              }
            } catch (IOException e) {
              // Handle file I/O error
              e.printStackTrace();
              // Optionally, you might want to throw an exception or return an error message
            }
            // Continue with your logic after file upload
            out.print("File uploaded successfully.");
          } catch (Exception e) {
            // Handle other exceptions
            e.printStackTrace();
            // Optionally, you might want to throw an exception or return an error message
          }
        } else {
          // No file uploaded, handle this case accordingly
          out.print("No file uploaded.");
        }

        success = userDao.updateUserPicture(useremail, "./user-images/" + fileName);
        if (!success) {
          session.setAttribute("message", "Update unsuccessful. Please Try Again");
        } else {
          session.setAttribute("message", "Successfully updated.");
        }

      } else {
      }

      response.sendRedirect("./settings.jsp");
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
