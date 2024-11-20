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
    <title>Login | CoinCare</title>
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  </head>
  <body class="body login-body">
    <script src="./js/light-dark.js"></script>
    <!--    <h2 style="margin: 10px 10px;"><a href="./index.jsp"><i class='bx bx-left-arrow-alt'></i> Coin Care</a></h2>-->
    <div class ="index-content">
      <div class="form-content">
        <form method="post" id="login-form" action="./LoginServlet">
          <div class="formheader">
            <!--        <div class="logo" style="width: 1022px;">
                      <a href="index.jsp"><%//@include file="components/logo.jsp"%></a>
                    </div>-->
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
            </div>
            <input type="password" id="password" name="user_password" />
          </div>
          <div class="submitBtn">
            <button type="submit" id="submitButton">Login</button>
          </div>
          <div class="register-href-div">
            <label>Don't have an account? </label><br />
            <a href="register.jsp" id="register-href">Sign Up</a>
            <br><br>
            <small id="forget-password"><a href="forget-password.jsp">Forgot Password?</a></small>
          </div>
        </form>
      </div>
      <!--<script src="./js/login-signup-validation.js">-->
      <script>
        document.addEventListener("DOMContentLoaded", function () {
          const loginForm = document.querySelector("#login-form");
          const btn = document.getElementById("submitButton");

          const emailInput = document.getElementById("email");
          const passwordInput = document.getElementById("password");

          const emailError = document.getElementById("email-error");
          const passwordError = document.getElementById("password-error");

          loginForm.addEventListener("submit", function (event) {
            event.preventDefault();

            // Validate email and password
            const isEmailValid = validateEmail(emailInput, emailError);
            const isPasswordValid = validateLoginPassword(passwordInput, passwordError);

            if (isEmailValid && isPasswordValid) {
              loginForm.submit(); // Submit form if validation passes
            }
          });
        });

// Validate Email
        function validateEmail(emailInput, errorElement) {
          const emailValue = emailInput.value.trim();
          const emailRegex = /^[A-Za-z][A-Za-z0-9._%+-]*@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

          if (emailValue === "") {
            setError(emailInput, "Email is required", errorElement);
            return false;
          } else if (!emailRegex.test(emailValue)) {
            setError(emailInput, "Invalid email format!", errorElement);
            return false;
          } else {
            removeError(emailInput, errorElement);
            return true;
          }
        }

// Validate Password
        function validateLoginPassword(passwordInput, errorElement) {
          const passValue = passwordInput.value.trim();
          const passRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$/;

          if (passValue === "") {
            setError(passwordInput, "Password is required", errorElement);
            return false;
//          } else if (!passRegex.test(passValue)) {
//            setError(passwordInput, "Invalid password format!", errorElement);
//            return false;
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

      </script>

      <div class="logo-content flex flex-col items-center justify-center w-full sm:w-auto mx-auto">
        <div class="flex items-center mb-4">
          <svg
            width="199px"
            height="48px"
            viewBox="0 0 199 48"
            version="1.1"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            >
          <g
            id="Work-in-Progress"
            stroke="none"
            stroke-width="1"
            fill="none"
            fill-rule="evenodd"
            >
          <g
            id="Header---3-Copy"
            class="mode"
            transform="translate(-146.000000, -31.000000)"
            >
          <g id="Group-4" transform="translate(146.000000, 31.000000)">
          <g id="Group-6">
          <text
            id="Retra-Insights"
            font-size="20"
            font-weight="400"
            letter-spacing="0.1"
            fill="#2D3748"
            >
          <tspan x="60" y="30">CoinCare</tspan>
          </text>
          <g id="Group">
          <polyline
            id="Fill-18"
            fill="var(--logo1)"
            points="36 5.99986676 24 0 24 12 36 5.99986676"
            ></polyline>
          <polyline
            id="Fill-19"
            fill="var(--logo2)"
            points="48 12.0001332 36 6 36 18 48 12.0001332"
            ></polyline>
          <polyline
            id="Fill-20"
            fill="var(--logo1)"
            points="48 24 48 12 36 17.9999334 48 24"
            ></polyline>
          <polyline
            id="Fill-21"
            fill="var(--logo3)"
            points="12 6 12 18 24 12.0001332 12 6"
            ></polyline>
          <polyline
            id="Fill-22"
            fill="var(--logo2)"
            points="24 0 12 5.99986676 24 12 24 0"
            ></polyline>
          <polyline
            id="Fill-23"
            fill="var(--logo3)"
            points="0 12 0 24 12 17.9999334 0 12"
            ></polyline>
          <polyline
            id="Fill-24"
            fill="var(--logo4)"
            points="12 6 0 12.0001332 12 18 12 6"
            ></polyline>
          <polyline
            id="Fill-25"
            fill="var(--logo1)"
            points="24 24.0000666 12 18 12 30 24 24.0000666"
            ></polyline>
          <polyline
            id="Fill-26"
            fill="var(--logo3)"
            points="0 24 0 36 12 29.9999334 0 24"
            ></polyline>
          <polyline
            id="Fill-27"
            fill="var(--logo2)"
            points="12 18 0 24.0000666 12 30 12 18"
            ></polyline>
          <polyline
            id="Fill-28"
            fill="var(--logo4)"
            points="12 30 0 35.9999334 12 42 12 30"
            ></polyline>
          <polyline
            id="Fill-29"
            fill="var(--logo1)"
            points="24 48 36 42.0001332 24 36 24 48"
            ></polyline>
          <polyline
            id="Fill-30"
            fill="var(--logo2)"
            points="24 36 12 42.0001332 24 48 24 36"
            ></polyline>
          <polyline
            id="Fill-31"
            fill="var(--logo2)"
            points="48 24 36 18 36 30 48 24"
            ></polyline>
          <polyline
            id="Fill-32"
            fill="var(--logo3)"
            points="48 36 48 24 36 29.9999334 48 36"
            ></polyline>
          <polyline
            id="Fill-33"
            fill="var(--logo4)"
            points="36 42 48 35.9999334 36 30 36 42"
            ></polyline>
          <polyline
            id="Fill-34"
            fill="var(--logo3)"
            points="36 18 24 24 36 30 36 18"
            ></polyline>
          <polyline
            id="Fill-35"
            fill="var(--logo3)"
            points="36 30 24 35.9999334 36 42 36 30"
            ></polyline>
          </g>
          </g>
          </g>
          </g>
          </g>
          </svg>
        </div>
        <div class="w-11/12 sm:w-2/3 mb-5 sm:mb-10">
          <h1
            class="text-2xl sm:text-3xl text-center text-white font-bold leading-tight"
            >
            Stay on Top of Your Spending
          </h1>
          <p class="pt-4 w-10/12 text-center mx-auto text-white">
            Track your spending, set budgets, and reach your financial
            goals with our powerful expense management tool. Stay informed and achieve financial freedom. <br />
          </p>
        </div>
      </div>
    </div>



  </body>
</html>


