<%-- 
    Document   : feedback
    Created on : 28 Jul 2024, 18:12:35
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Feedback | CoinCare</title>

    <link rel="stylesheet" href="css/elementStyles.css"/>
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
  </head>
  <body class="body">
    <script src="js/light-dark.js"></script>
    <%@include file="components/nav.jsp"%>

    <div class="main-content">
      <div class="container">
        <h2><a href="./dashboard.jsp"><i class='bx bx-left-arrow-alt'></i> Coin Care</a> / <a href="./feedback.jsp">Give Your Feedback</a></h2>
      </div>

      <%@include file="components/message.jsp" %>
      <br><br>
      <div class="custom-content">
        <form action="./FeedbackServlet" method="POST">
          <!-- Hidden input for userId -->
          <input type="hidden" name="userId" value="<%= user.getUserId() %>">

          <!-- Feedback text area -->
          <label for="feedback">Tell us how we can improve:</label><br>
          <textarea id="feedback" name="feedback" rows="4" cols="50" required></textarea><br><br>

          <!-- Submit button -->
          <button type="submit" class="submitBtn-exp"> Submit Feedback</button>
        </form>

      </div>
    </div>
  </body>
</html>
