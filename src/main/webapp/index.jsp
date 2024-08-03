<%-- 
    Document   : index
    Created on : 25 Jul 2024, 07:12:59
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.coincare.helper.FactoryProvider" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CoinCare</title>
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
  </head>
  <body class="body">
    <script src="js/light-dark.js"></script>
    <h1>Hello World!</h1>
    Session Factory:
    <%
      out.println(FactoryProvider.getFactory());
    %>
  </body>
</html>
