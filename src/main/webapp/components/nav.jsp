<%-- 
    Document   : nav
    Created on : 27 Jul 2024, 20:27:36
    Author     : Dell
--%>

<%@page import="com.coincare.helper.FactoryProvider" %>
<%@page import="com.coincare.entities.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  User user =(User) session.getAttribute("logged_user");
    if(user == null){
      session.setAttribute("message", "You are not logged in! Please login first. ");
      response.sendRedirect("login.jsp");
      return;
    }
    else{
       if(user.getUserType().equals("admin")){
        session.setAttribute("message", "You do not have access to this page.");
        response.sendRedirect("login.jsp");
        return;
      }
    }
%>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="css/sidebarstyle.css">
<div class="sidebar">
  <div class="top">
    <i class="bx bx-menu" id="menu-btn" onclick="menuBtnClick()"></i>
    <div class="logo">
      <i class="bx bxl-codepen"></i>
      <span>CoinCare</span>
    </div>
  </div>
  <div class="user"><a href="./settings.jsp" >
      <img src="images/<%=user.getUserPic()%>" alt="user" class="user-img"></a>
    <a href="./settings.jsp" style="text-decoration: none; " ><div>
        <p class="bold"><%= user.getUserName() %></p>
        <p><%= user.getUserType() %></p>
      </div></a>
  </div>
  <ul>
    <li>
      <a href="./dashboard.jsp">
        <i class='bx bxs-grid-alt'></i>
        <span class="nav-item">Dashboard</span>
      </a>
      <span class="tooltip">Dashboard</span>
    </li>

    <li>
      <a href="./income.jsp">
        <i class="bx bx-wallet-alt"></i>
        <span class="nav-item">Income</span>
      </a>
      <span class="tooltip">Income</span>
    </li>

    <li>
      <a href="./budget.jsp">
        <i class='bx bx-dollar-circle'></i>
        <span class="nav-item">Budgets</span>
      </a>
      <span class="tooltip">Budgets</span>
    </li>

    <li>
      <a href="./statements.jsp">
        <i class='bx bxs-report'></i>
        <span class="nav-item">Statements</span>
      </a>
      <span class="tooltip">Statements</span>
    </li>

    <li>
      <a href="./explore.jsp">
        <i class='bx bx-search-alt'></i>
        <span class="nav-item">Explore</span>
      </a>
      <span class="tooltip">Explore</span>
    </li>

    <li>
      <a href="./settings.jsp">
        <i class="bx bx-cog"></i>
        <span class="nav-item">Settings</span>
      </a>
      <span class="tooltip">Settings</span>
    </li>

    <li>
      <a href="./feedback.jsp">
        <i class='bx bx-message-alt-edit' ></i>
        <span class="nav-item">Feedback</span>
      </a>
      <span class="tooltip">Feedback</span>
    </li>

    <li>
      <a href="./help.jsp">
        <i class='bx bx-question-mark'></i>
        <span class="nav-item">Help</span>
      </a>
      <span class="tooltip">Help</span>
    </li>

    <li>
      <a href="./LogoutServlet">
        <i class="bx bx-log-out"></i>
        <span class="nav-item">Logout</span>
      </a>
      <span class="tooltip">Logout</span>
    </li>
  </ul>
</div>

<script>
  let btn = document.querySelector('#menu-btn');
  let sidebar = document.querySelector('.sidebar');
  function menuBtnClick() {
    sidebar.classList.toggle('active');
  }
  ;

</script>
