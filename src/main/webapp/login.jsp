<%-- 
    Document   : login
    Created on : 27 Jul 2024, 20:09:46
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/fontAndColors.css" />
    <link rel="stylesheet" href="css/formStyle.css" />
    <title>Login</title>
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
  </head>
  <body class="body">
    <script src="./js/light-dark.js"></script>
    <form method="post" id="login-form" action="./LoginServlet">
      <div class="formheader">
        <h2>Welcome Back!</h2>
        <h4>Log in and let’s continue the tracking!</h4>
        <p class="invalid"><%@include file="components/message.jsp" %></p>
      </div>
      <div class="text-container">
        <label for="user_email">Email:</label>
        <div class="password-more">
          <small id="email-error" class="error"></small><small style="color:var(--back);">.</small></div>
        <input type="email" id="email" name="user_email" />
      </div>
      <div class="text-container">
        <label for="user_password">Password: </label>
        <div class="password-more">
          <small id="password-error" class="error"></small>
          <small id="forget-password"><a href="forget-password.jsp">Forget Password?</a></small>
        </div>
        <input type="password" id="password" name="user_password" />
      </div>
      <div class="submitBtn">
        <button type="submit" id="submitButton">Login</button>
      </div>
      <div class="register-href-div">
        <label>New Here? </label><br />
        <a href="register.jsp" id="register-href">Register Now</a>
      </div>
    </form>
    <script src="js/login-signup-validation.js"></script>
  </body>
</html>


