<%-- 
    Document   : forget-password
    Created on : 27 Jul 2024, 21:39:30
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Forget Password?</title>
    <link rel="stylesheet" href="css/fontAndColors.css" />
    <link rel="stylesheet" href="css/formStyle.css" />
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
  </head>
  <body class="body">
    <script src="js/light-dark.js"></script>
    <form method="post" id="forget-password-form" action="./ForgetPasswordServlet">
      <div class="formheader">
        <h2>Forgot Your Password?</h2>
        <br>
        <h4>1. Enter your email address below</h4>
        <h4>2. Our system will send you an OTP to the email</h4>
        <h4>3. Enter the OTP on the next page</h4>
        <p class="invalid"><%@include file="components/message.jsp" %></p>
      </div>
      <div class="text-container">
        <div class="password-more">
          <small id="email-error" class="error"></small><small>  .</small></div>
        <input type="email" id="email" name="user_email" placeholder="Enter your email address" required/>
      </div>
      <div class="submitBtn">
        <button type="submit" id="submitButton">Send OTP</button>
      </div>
    </form>
  </body>
</html>
