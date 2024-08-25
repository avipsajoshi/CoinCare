<%-- 
    Document   : admin-dashboard
    Created on : 27 Jul 2024, 20:10:40
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.coincare.entities.User" %>
<%@page import="com.coincare.entities.Category" %>
<%@page import="com.coincare.entities.BudgetPlan" %>
<%@page import="com.coincare.helper.FactoryProvider" %>
<%@page import="com.coincare.dao.UserDao" %>
<%@page import="com.coincare.dao.CategoryDao" %>
<%@page import="com.coincare.dao.BudgetPlanDao" %>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
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
    LocalDate currentDate = LocalDate.now();
    int currentYear = currentDate.getYear();
    int currentDay = currentDate.getDayOfMonth();
    Month currentMonth = currentDate.getMonth();


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

    </script> 
  </head>
  <body class="light_mode">
    <script src="js/light-dark.js"></script>

    <%@include file="components/message.jsp" %>
    <div class="main-content">
      <div class="container">
        <h2><a href="./dashboard.jsp">Coin Care</a>\<a href="./admin-dashboard.jsp">Admin Dashboard</a></h2>
        <h2><%=currentDay%> <%=currentMonth.toString()%>, <%=currentYear%></h2>
        <a href="./LogoutServlet"><button class="btn action-btn" style="float:right; margin-right: 20px;">Logout</button></a>
      </div>
      <div class="admin-user">
        <img src="images/<%=user.getUserPic()%>" alt="user" class="user-profile-img">
        <div class="user-info">
          <label class="bold"><%= user.getUserName() %></label><br>
          <label><%= user.getUserType() %></label>
        </div>
      </div>
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
                int userid = u.getUserId();
              %>
              <tr>
                <td><div class="user"><img src="images/<%=u.getUserPic()%>" alt="user" class="user-profile-img"></div></td>
                <td scope="row"><%=u.getUserName()%></td>
                <td scope="row"><%=u.getUserEmail()%></td>
                <td><button type="button" name="editBtn" value="<%=userid%>" class="btn action-btn" onclick="openPopup(pop_u, '<%=userid%>')">...</button>
                  <div id="popup-user<%=userid%>" class="popup-container scroll-container">
                    <div class="close-button" onclick="closePopup(pop_u, '<%=userid%>')">X</div>
                    <form id="admin-user-form" action="./AdminServlet" method="get" style="padding-left:inherit;">
                      <input type="hidden" value="<%= userid %>" name="userId" id="admin-user-id"/>
                      <button type="submit" name="operationType" value="userProfileInappropriate" class="submitBtn-admin">Inappropriate Name/Photo</button>
                    </form>
                    <%
                      if(user.getUserType().equals("owner")){
                    %>
                    <form id="admin-user-to-admin-form" action="./AdminServlet" method="get" style="padding-left:inherit;">
                      <input type="hidden" value="<%= userid %>" name="userId" id="makeAdmin">
                      <button type="submit" name="operationType" value="makeAdmin" class="submitBtn-admin">Make Admin</button>
                    </form>
                    <%}%>
                  </div>


                </td>
              </tr>
              <%}%>
            </tbody>
          </table>
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
                <td><button type="button" name="editBtn" value="<%=au.getUserId()%>" class="btn action-btn" onclick="openPopup(pop_a, '<%=au.getUserId()%>')">...</button>
                  <div id="popup-admin<%=au.getUserId()%>" class="popup-container scroll-container">
                    <div class="close-button" onclick="closePopup(pop_a, '<%=au.getUserId()%>')">X</div>
                    <form id="admin-change-form" action="./AdminServlet" method="get" style="padding-left:inherit;">
                      <input type="hidden" value="<%=au.getUserId()%>" name="adminId" id="makeOwner">
                      <button type="submit" name="operationType" value="makeAdminOwner" class="submitBtn-admin">Make Owner</button>
                    </form>
                    <form id="admin-remove-form" action="./AdminServlet" method="get" style="padding-left:inherit;">
                      <input type="hidden" value="<%=au.getUserId()%>" name="adminId" id="removeAdmin">
                      <button type="submit" name="operationType" value="removeAsAdmin" class="submitBtn-admin">Remove as Admin</button>
                    </form>
                  </div>
                </td>
                <%}%>
              </tr>
              <%}%>
            </tbody>
          </table>
        </div>


        <!--category controls-->

        <div class="tab-content" id="tab3">
          <p>This is the content for Categories</p>
          <!--
          <table class="table">
            <thead>
              <tr>
                <th scope="col">Title</th>
                <th scope="col">Description</th>
                <th scope="col">Creator</th>
                <th scope="col"></th>
              </tr>
            </thead>
            <tbody>
          <%
            CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
          List<Category> allCategories = cDao.getAllCategory();
          for(Category c : allCategories){
          %>
          <tr>
            <td scope="row"><%=c.getCategoryTitle()%></td>
            <td scope="row"><%=c.getCategoryDescription()%></td>
            <td scope="row"><%=c.getUser().getUserEmail()%></td>
          <%
            if(user.getUserType().equals("owner")){
          %>
          <td><button type="button" name="editBtn" value="<%=c.getCategoryId()%>" class="btn action-btn" onclick="openPopup(pop_cS, '<%=c.getCategoryId()%>')">...</button>
            <div id="popup-admin<%=c.getCategoryId()%>" class="popup-container scroll-container">
              <div class="close-button" onclick="closePopup(pop_c, '<%=c.getCategoryId()%>')">X</div>
              <form id="admin-category-form" action="./CategoryServlet" method="get" style="padding-left:inherit;">
                <button type="submit" name="operationType" value="adminCatUpdate" class="submitBtn-admin">Make Owner</button>
              </form>
              <form id="admin-category-delete-form" action="./CategoryServlet" method="get" style="padding-left:inherit;">
                <button type="submit" name="operationType" value="adminCatDelete" class="submitBtn-admin">Remove as Admin</button>
              </form>
            </div>
          </td>
          <%}%>
        </tr>
          <%}%>
        </tbody>
      </table>
      
      
          -->

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


      //for adding new record
      function openAddPopup(popup) {
        document.getElementById(popup).style.display = "block";
      }

      function closeAddPopup(popup) {
        document.getElementById(popup).style.display = "none";
      }

      function openPopup(popup, id) {
        var pop = popup + id;
        document.getElementById(pop).style.display = "block";
        dynamicBtnId = id;
      }

      function closePopup(popup, id) {
        var pop = popup + id;
        document.getElementById(pop).style.display = "none";
      }

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
