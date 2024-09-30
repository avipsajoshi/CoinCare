<%-- 
    Document   : register
    Created on : 27 Jul 2024, 20:10:00
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/fontAndColors.css" />
    <link rel="stylesheet" href="css/formStyle.css" />
    <title>Register | CoinCare</title>
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
  </head>
  <body class="light_mode">
    <form method="post" id="register-form" action="./RegisterServlet">
      <div class="formheader">
        <h2>New here?</h2>
        <h5>Join us in being more financially responsible. Let's start tracking!</h5>
        <p class="invalid"><%@include file="components/message.jsp" %></p>
      </div>
      <div class="text-container">
        <label for="user_name">Full Name:</label>
        <small id="name-error" class="error"></small>
        <br />
        <input type="text" id="user_name" name="user_name" />
      </div>
      <div class="text-container">
        <label for="user_email">Email:</label>
        <small id="email-error" class="error"></small>
        <br />
        <input type="email" id="email" name="user_email" />
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
        <button id="submitButton" type="submit">Register Now</button>
      </div>
      <div class="register-href-div">
        <label>Already have an account? </label><br />
        <a href="login.jsp" id="register-href">Login Here</a>
      </div>
    </form>
    <script src="js/login-signup-validation.js"></script>

  </body>
</html>

