<%-- 
    Document   : settings
    Created on : 28 Jul 2024, 18:12:25
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.coincare.helper.MinorHelper" %>
<%@page import="com.coincare.entities.User" %>
<%@page import="com.coincare.dao.UserDao" %>
<%@page import="java.time.Year"%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Profile Settings</title>
    <link rel="stylesheet" href="css/fontAndColors.css"/>
    <link rel="stylesheet" href="css/elementStyles.css"/>

    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
  </head>
  <body class="body">
    <script src="js/light-dark.js"></script>
    <%@include file="components/nav.jsp"%>
    <div class="main-content">
      <%@include file="components/message.jsp"%>
      <div class="container">
        <h1>Coin Care</h1>
      </div>

      <div class="custom-content">
        <% User user1 =user;%>
        <div class="collapse-container">
          <div class="collapsible">
            <button class="collapsible-button">Edit Profile</button>
            <div class="collapse-content">
              <div class="singlechange-container">
                <label>Email: <%= user1.getUserEmail() %></label>
                <%
                  String useremail = user1.getUserVerify();
                  if (useremail.equals("Verify")){%>
                <form class="singlechange-form" action="./SingleChangeServlet" method="post">
                  <input type="text" name ="useremail" value="<%= user1.getUserEmail() %>" hidden/>
                  <div class="single-submitBtn">
                    <button type="submit" name="singlechangeBtn" class="setting-change-button" value="email-verify">
                      <%=user1.getUserVerify()%></button>
                  </div>
                </form>
                <%}else{%>
                <label>Verified</label>
                <%}%>
              </div>
              <hr>



              <form id="updateprofile-form" action="./UpdateProfileServlet" method="post" >
                <input type="text" name ="useremail" value="<%= user1.getUserEmail() %>" hidden/>
                <input type="hidden" name ="profileBtn" value="1"/>
                <div class="text-container">
                  <label>Full name:</label>
                  <small id="name-error" class="error"></small>
                  <input type="text" name="user-name" value="<%=user1.getUserName()%>" placeholder="Full name" required/>
                </div>



                <div class="text-container">
                  <label for="userdob">Date of Birth:</label>
                  <select name="user-dob-year" id="year">
                    <option value="<%=user1.getUserDobYear()%>"><%=user1.getUserDobYear()%></option>
                    <%   
                      int year = Year.now().getValue();
                      for(int i= year-3; i>= year-110; i--){
                      if(i == user1.getUserDobYear() ) continue;
                    %>
                    <option value="<%=i%>"><%=i%></option>
                    <%}%>
                  </select>
                  <select name="user-dob-month" id="month">
                    <option value="<%=MinorHelper.getMonth(user1.getUserDobMonth())%>"><%=MinorHelper.getMonth(user1.getUserDobMonth())%></option>
                    <%
                      String[] months = {"January", "February","March","April","May","June","July","August","September","October","November","December"};
                      for(String mn : months){
                        if (mn == MinorHelper.getMonth(user1.getUserDobMonth())) continue;
                    %>
                    <option value="<%=mn%>"><%=mn%></option>
                    <%}%>
                  </select>
                  <select name="user-dob-day" id="day">
                    <option value="<%=user1.getUserDobDay()%>"><%=user1.getUserDobDay()%></option>
                    <%
                      for(int i= 1; i<= 31; i++){
                      if(i== user1.getUserDobDay()) continue;
                    %>
                    <option value="<%=i%>"><%=i%></option>
                    <%}%>
                  </select>
                </div>



                <div class="text-container">
                  <label>Country:</label>
                  <small id="country-error" class="error"></small>
                  <input type="text" name="user-country" value="<%=user1.getUserCountry()%>" placeholder="Country" required/>
                </div>

                <div class="submitBtn">
                  <button type="submit" class="setting-change-button">Save Changes</button>
                </div>
              </form> 
              <br>
              <hr>
              <br>


              <div>
                Profile picture:
                <br>
                <br>
                <img src="images/<%=user1.getUserPic()%>" alt="user" class="user-profile-img">
                <br>
                <!--<button value="photo" id="change-image-btn" class="setting-change-button"> Change</button>-->
                <form id="updateprofilepic-form" action="./UpdateProfileServlet" method="post" enctype="multipart/form-data">
                  <input type="text" name="useremail" value="<%=user1.getUserEmail()%>" hidden />
                  <input type="hidden" name ="profileBtn" value="2"/>
                  <input type="file" id="user-update-image" name="user-update-image" required />
                  <br>
                  <div class="submitBtn">
                    <button type="submit" class="setting-change-button">Upload</button>
                  </div>
                </form>

              </div>
            </div>
          </div>




          <div class="collapsible">
            <button class="collapsible-button">Edit Budget Plan</button>
            <div class="collapse-content">
              <p>Your Budget Plan: </p>
              <p>Budget Plan Description</p>
            </div>
          </div>
          <div class="collapsible">
            <button class="collapsible-button">Customize Categories</button>
            <div class="collapse-content">
              <p>Your Categories</p>
            </div>
          </div>
          <div class="collapsible">
            <button class="collapsible-button">Email Preferences</button>
            <div class="collapse-content">
              <div class="singlechange-container">
                <label>Statements Notification</label>
                <%
                String onOff = user1.isEnableReportNotification();
                String change ="";
                if(onOff.equals("on")){
                change = "off";
                }
                if(onOff.equals("off")){
                change = "on";
                }
                %>
                <form class="singlechange-form" action="./SingleChangeServlet" method="post">
                  <input type="text" name ="useremail" value="<%= user1.getUserEmail() %>" hidden/>
                  <div class="single-submitBtn">
                    <button type="submit" class="setting-change-button" name="singlechangeBtn" value="statement">
                      Turn <% out.print(change);%></button>
                  </div>
                </form>
              </div>
              <hr>

              <div class="singlechange-container">
                <label> Advice Notification </label>
                <%
                String onOff2 = user1.getEnableTipsNotification();
                String change2 ="";
                if(onOff2.equals("on")){
                change2 = "off";
                }
                if(onOff2.equals("off")){
                change2 = "on";
                }
                %>
                <form class="singlechange-form" action="./SingleChangeServlet" method="post">
                  <input type="text" name ="useremail" value="<%= user1.getUserEmail() %>" hidden/>
                  <div class="single-submitBtn">
                    <button type="submit" class="setting-change-button" name="singlechangeBtn" value="tips">
                      Turn <% out.print(change2);%></button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <script>
          document.querySelectorAll('.collapsible-button').forEach(button => {
            button.addEventListener('click', () => {
              const content = button.nextElementSibling;

              // Toggle between hiding and showing the content
              if (content.style.display === 'block') {
                content.style.display = 'none';
              } else {
                content.style.display = 'block';
              }
            });
          });

        </script>
      </div>
  </body>
</html>
