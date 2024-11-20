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
    <title>Update Profile | CoinCare</title>

    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
  </head>
  <body class="body"> 
    <script src="./js/light-dark.js"></script>
    <p class="invalid"><%@include file="components/message.jsp" %></p>
    <%
      String operation = (String) session.getAttribute("resetPass");
//      System.out.println("attribute value" +resetPassword);
      if(operation.equals("otp")){
    %>

    <!--reset password otp-->
    <form id="otp-form" method="post" action="./ResetPasswordServlet">
      <div class="formheader">
        <h2>Enter OTP</h2>
      </div>
      <div class="text-container">
        <input type="number" name="otp-value" id="otp-value" placeholder="Enter OTP" required/>
      </div>
      <div class="submitBtn">
        <button type="submit" class="otp-btn">Reset Password</button>
      </div>
    </form>
    <%} else if(operation.equals("newPass")){%>

    <!--change password from "forget password"-->
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
        <button id="submitButton" type="submit" name="passwordChangeSrc" value="1">Update Password</button>
      </div>
    </form>
    <%} else if(operation.equals("verify")){%>



    <!--verify email-->
    <form id="otp-form" method="post" action="./SingleChangeServlet">
      <div class="formheader">
        <h2>Enter OTP</h2>
      </div>
      <div class="text-container">
        <input type="number" name="otp-value-verify" id="otp-value" placeholder="Enter OTP" required/>
      </div>
      <div class="submitBtn">
        <button type="submit" name="singlechangeBtn"  class="otp-btn" value="verification">Verify</button>
      </div>
    </form>

    <%} else if(operation.equals("changePass")){%>

    <!--change password-->
    <form id="register-form2" method="post" action="./NewPasswordServlet">
      <div class="formheader">
        <h2>Enter Old Password</h2>
      </div>
      <div class="text-container">
        <label for="user_old_password">Password: </label>
        <small id="password-error" class="error"></small><br />
        <input type="password" id="password" name="user_old_password" />
      </div>
      <div class="formheader">
        <h2>Enter new Password</h2>
      </div>
      <div class="text-container">
        <label for="user_password">Password: </label>
        <small id="new-password-error" class="error"></small><br />
        <input type="password" id="password" name="user_password" />
      </div>
      <div class="text-container">
        <label for="password2">Confirm Password: </label>
        <small id="password2-error" class="error"></small><br />
        <input type="password" id="password2" name="password2" />
      </div>
      <div class="submitBtn">
        <button id="submitButton" type="submit" name="passwordChangeSrc" value="2">Update Password</button>
      </div>
    </form>
    <%}%>

    <script>

      document.addEventListener('DOMContentLoaded', function () {
        const registerForm = document.getElementById("register-form");
        const registerForm2 = document.getElementById("register-form2");
        const btn = document.getElementById("submitButton");

        const passwordInput = document.getElementById("password");
        const confirmPasswordInput = document.getElementById("password2");

        const passwordError = document.getElementById("password-error");
        const confirmPasswordError = document.getElementById("password2-error");
        registerForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validatePassword(passwordInput, passwordError) &&
                  validateConfirmPassword(passwordInput, confirmPasswordInput, confirmPasswordError)
                  ) {
            registerForm.submit();
          }
        });
        registerForm2.addEventListener("submit", function (event) {
          event.preventDefault();
          if (validatePassword(passwordInput, passwordError) &&
                  validateConfirmPassword(passwordInput, confirmPasswordInput, confirmPasswordError)
                  ) {
            registerForm.submit();
          }
        });
      });

// Validate Password
      function validatePassword(passwordInput, errorElement) {
        const passValue = passwordInput.value.trim();
        const passRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$/;

        if (passValue === "") {
          setError(passwordInput, "Password is required", errorElement);
          return false;
        } else if (!passRegex.test(passValue)) {
          setError(passwordInput, "Invalid password format!", errorElement);
          return false;
        } else {
          removeError(passwordInput, errorElement);
          return true;
        }
      }

// Set Error Message
      function setError(inputElement, message, errorElement) {
        errorElement.textContent = message;
        errorElement.classList.add("error-message");
      }

// Remove Error Message
      function removeError(inputElement, errorElement) {
        errorElement.textContent = "";
        errorElement.classList.remove("error-message");
      }

      function validateConfirmPassword(cpasswordInput, passwordInput, errorElement) {
        const confirmPassValue = cpasswordInput.value.trim();
        const passValue = passwordInput.value.trim();
        if (confirmPassValue === "") {
          setError(
                  " Confirm password is required",
                  errorElement
                  );
          return false;
        } else if (confirmPassValue !== passValue) {
          setError(cpasswordInput,
                  " Passwords do not match",
                  errorElement);
          return false;
        } else {
          removeError(confirmPassValue, errorElement);
          return true;
        }
      }


    </script>
  </body>
</html>
