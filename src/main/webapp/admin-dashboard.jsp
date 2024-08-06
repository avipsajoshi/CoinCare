<%-- 
    Document   : admin-dashboard
    Created on : 27 Jul 2024, 20:10:40
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.coincare.entities.User" %>
<%
   User user =(User) session.getAttribute("logged_user");
    if(user == null){
      session.setAttribute("message", "You are not logged in! Please login first. ");
      response.sendRedirect("login.jsp");
      return;
    }
    else{
       if(user.getUserType().equals("user")){
        session.setAttribute("message", "You do not have access to this page.");
        response.sendRedirect("login.jsp");
        return;
      }
    }
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/fontAndColors.css"/>

    <link rel="icon" type="image/png" href="./images/coincarelogo.png">

  </head>
  <body class="light_mode">
    <script src="js/light-dark.js"></script>
    <div class="main-content">
      <div class="container">
        <h1>CoinCare</h1>
      </div>
      <div class="container">
        <h2>Admin Page</h2>
      </div>

      <div class="custom-content">

      </div>
    </div>
  </body>
</html>
