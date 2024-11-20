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
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  </head>
  <body class="light_mode login-body">

    <!--    <h2 style="margin: 10px 10px;"><a href="./index.jsp"><i class='bx bx-left-arrow-alt'></i> Coin Care</a></h2>-->

    <div class ="index-content">
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
      <div class="form-content">
        <form method="post" id="register-form" action="./RegisterServlet">
          <div class="formheader">
            <h2>New here?</h2>
            <h5>Start now and watch your savings grow!</h5>
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

      </div>

    </div>
    <script src="./js/login-signup-validation.js"></script>

  </body>
</html>

