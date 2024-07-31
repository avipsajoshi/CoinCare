<%-- 
    Document   : reset-password.jsp
    Created on : 27 Jul 2024, 23:08:18
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link rel="stylesheet" href="css/fontAndColors.css" />
    <link rel="stylesheet" href="css/formStyle.css" />
    <title>Reset Password</title>
  </head>
  <body class="body"> 
    <script src="./js/light-dark.js"></script>
    <p class="invalid"><%@include file="components/message.jsp" %></p>
    <%
      String resetPassword = (String) session.getAttribute("resetPass");
      System.out.println("attribute value" +resetPassword);
      if(resetPassword.equals("otp")){
    %>
    <form id="otp-form" method="post" action="./ResetPasswordServlet">
      <div class="formheader">
        <h2>Enter OTP</h2>
      </div>
      <div class="text-container">
        <input type="text" name="otp-value" id="otp-value" placeholder="Enter OTP" required/>
      </div>
      <div class="submitBtn">
        <button type="submit" class="otp-btn">Reset Password</button>
      </div>
    </form>
    <%} else if(resetPassword.equals("newPass")){%>
    <form id="register-form" method="post" action="./NewPasswordServlet">
      <div class="formheader">
        <h2>Enter new Password</h2>
      </div>
      <div class="text-container">
        <label for="user_password">Password: </label>
        <small id="password-error" class="error"></small><br />
        <input type="password" id="password" name="user_password" />
      </div>
      <div class="text-container">
        <label for="password2">Confirm Password: </label>
        <small id="password2-error" class="error"></small><br />
        <input type="password" id="password2" name="password2" />
      </div>
      <div class="submitBtn">
        <button id="submitButton" type="submit" name="passwordChangeSrc" value="1">Save Changes</button>
      </div>
    </form>
    <%}%>
  </body>
</html>