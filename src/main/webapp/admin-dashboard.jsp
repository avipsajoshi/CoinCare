<%-- 
    Document   : admin-dashboard
    Created on : 27 Jul 2024, 20:10:40
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.coincare.entities.User" %>
<%@page import="com.coincare.helper.FactoryProvider" %>
<%@page import="com.coincare.dao.UserDao" %>
<%@page import="java.util.List" %>
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
    <link rel="stylesheet" href="css/admin-style.css"/>
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">

    <script>
      pop_u = "popup-user";
      pop_a = "popup-admin";
      pop_c = "popup-category";
      pop_b = "popup-budget";
      pop_ar = "popup-article";
      pop_f = "popup-feedback";
      let dynamicBtnId;
      function openPopup(popup, id) {
        document.getElementById(popup).style.display = "block";
        dynamicBtnId = id;
      }

      function closePopup(popup, id) {
        document.getElementById(popup).style.display = "none";
      }
      function openPopup(popup) {
        document.getElementById(popup).style.display = "block";
      }

      function closePopup(popup) {
        document.getElementById(popup).style.display = "none";
      }
    </script> 
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
        <div class="tab-container">
          <div class="tab-nav">
            <button class="tab-link active" data-target="tab1">Users</button>
            <button class="tab-link" data-target="tab2">Admins</button>
            <button class="tab-link" data-target="tab3">Categories</button>
            <button class="tab-link" data-target="tab4">Budget Plans</button>
            <button class="tab-link" data-target="tab5">Articles</button>
            <button class="tab-link" data-target="tab6">Feedback</button>
          </div>


          <!--user controls-->

          <div class="tab-content active" id="tab1">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">Profile</th>
                  <th scope="col">Name</th>
                  <th scope="col">Email</th>
                  <th scope="col"></th>
                </tr>
              </thead>
              <tbody>
                <%
                UserDao uDao = new UserDao(FactoryProvider.getFactory());
                List<User> allUsers = uDao.getUserByType("user");
                for(User u : allUsers){
                %>
                <tr>
                  <td><div class="user"><img src="images/<%=u.getUserPic()%>" alt="user" class="user-profile-img"></div></td>
                  <td scope="row"><%=u.getUserName()%></td>
                  <td scope="row"><%=u.getUserEmail()%></td>
                  <td><button type="button" name="editBtn" value="<%=u.getUserId()%>" class="btn action-btn" onclick="openPopup(pop_u, this.value)">...</button></td>
                </tr>
                <%}%>
              </tbody>
            </table>

            <div id="user-popup" class="popup-container">
              <div class="close-button" onclick="closePopup(pop_u)">X</div>
              <form id="admin-user-form" action="./AdminServlet" method="get" style="padding-left:inherit;">
                <input type="hidden" value="" name="userId" id="admin-user-id">
                <button type="button" name="operationType" value="userProfileInappropriate" class="submitBtn-exp">Inappropriate Name/Photo</button>
              </form>
              <%
                if(user.getUserType().equals("owner")){
              %>
              <form id="admin-user-to-admin-form" action="./AdminServlet" method="get" style="padding-left:inherit;">
                <input type="hidden" value="" name="userId" id="makeAdmin">
                <button type="button" name="operationType" value="makeAdmin" class="submitBtn-exp">Make Admin</button>
              </form>
              <%}%>
            </div>

          </div>


          <!--admin controls-->


          <div class="tab-content" id="tab2">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">Profile</th>
                  <th scope="col">Name</th>
                  <th scope="col">Email</th>
                  <th scope="col"></th>
                </tr>
              </thead>
              <tbody>
                <%
                List<User> allAdminUsers = uDao.getUserByType("admin");
                for(User au : allAdminUsers){
                %>
                <tr>
                  <td><div class="user"><img src="images/<%=au.getUserPic()%>" alt="user" class="user-profile-img"></div></td>
                  <td scope="row"><%=au.getUserName()%></td>
                  <td scope="row"><%=au.getUserEmail()%></td>
                  <%
                    if(user.getUserType().equals("owner")){
                  %>
                  <td><button type="button" name="editBtn" value="<%=au.getUserId()%>" class="btn action-btn" onclick="openPopup(pop_a, this.value)">...</button></td>
                  <%}%>
                </tr>
                <div id="admin-popup" class="popup-container">
              <div class="close-button" onclick="closePopup(pop_a)">X</div>
              <form id="admin-change-form" action="./AdminServlet" method="get" style="padding-left:inherit;">
                <input type="hidden" value="" name="adminId" id="makeOwner">
                <button type="button" name="operationType" value="makeAdminOwner" class="submitBtn-exp">Make Owner</button>
              </form>
              <form id="admin-remove-form" action="./AdminServlet" method="get" style="padding-left:inherit;">
                <input type="hidden" value="" name="adminId" id="removeAdmin">
                <button type="button" name="operationType" value="removeAsAdmin" class="submitBtn-exp">Remove as Admin</button>
              </form>
              <%}%>
            </div>
              </tbody>
            </table>

            

          </div>


          <!--category controls-->

          <div class="tab-content" id="tab3">
            <p>This is the content for Categories</p>
          </div>

          <!--budget plans controls-->

          <div class="tab-content" id="tab4">
            <p>This is the content for Budget plans</p>
          </div>

          <!--articles controls-->

          <div class="tab-content" id="tab5">
            <p>This is the content for Articles.</p>
          </div>


          <!--user feedback controls-->


          <div class="tab-content" id="tab6">
            <p>This is the content for User Feedback.</p>
          </div>



        </div>
      </div>

    </div>
    <script>
      //for entire page
      document.addEventListener("DOMContentLoaded", function () {
        // Get all tab links and tab content elements
        const tabLinks = document.querySelectorAll(".tab-link");
        const tabContents = document.querySelectorAll(".tab-content");

        tabLinks.forEach((link) => {
          link.addEventListener("click", function () {
            // Remove active class from all tab links and contents
            tabLinks.forEach((item) => item.classList.remove("active"));
            tabContents.forEach((content) =>
              content.classList.remove("active")
            );

            // Add active class to the clicked tab link
            this.classList.add("active");

            // Show the corresponding tab content
            const target = this.getAttribute("data-target");
            document.getElementById(target).classList.add("active");
          });
        });
      });

      //for user actions
      let userIdforChange = document.getElementById("admin-user-id");
      let userIdToMakeAdmin = document.getElementById("makeAdmin");
      let adminIdToRemove = document.getElementById("admin-user-id");
      let adminIdToMakeOwner = document.getElementById("makeOwner");
      userIdforChange.value = dynamicBtnId;
      userIdToMakeAdmin.value = dynamicBtnId;
    </script>
  </body>
</html>
