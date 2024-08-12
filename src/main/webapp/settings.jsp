<%-- 
    Document   : settings
    Created on : 28 Jul 2024, 18:12:25
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.coincare.helper.MinorHelper" %>
<%@page import="java.util.List" %>
<%@page import="com.coincare.entities.User" %>
<%@page import="com.coincare.entities.Category" %>
<%@page import="com.coincare.entities.BudgetPlan" %>
<%@page import="com.coincare.dao.UserDao" %>
<%@page import="com.coincare.dao.CategoryDao" %>
<%@page import="com.coincare.dao.BudgetPlanDao" %>

<%@page import="java.time.Year"%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Profile Settings</title>
    <link rel="stylesheet" href="css/fontAndColors.css"/>
    <link rel="stylesheet" href="css/elementStyles.css"/>

    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
    <script>
      pop_c = "popup-cat";
      pop_cu = "update-popup-cat";
      let dynamicBtnId;
    </script>
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
                  <select name="user-country" id="country-dropdown">
                    <% if (user1.getUserCountry() != null){
                    %>
                    <option value="<%=user1.getUserCountry()%>" selected><%=user1.getUserCountry()%></option>
                    <% } else{%>
                    <option value="">Select your Country</option>
                    <% }%>
                  </select>
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


          <!--budgetplan changes-->

          <div class="collapsible">
            <button class="collapsible-button">Edit Budget Plan</button>
            <div class="collapse-content">
              <p>Your Budget Plan: </p>
              <p>Budget Plan Description</p>
            </div>
          </div>


          <!--category changes-->

          <div class="collapsible">
            <button class="collapsible-button">Customize Categories</button>
            <div class="collapse-content">
              <p>Your Categories</p>

              <div class="custom-content">
                <%
                  CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
                  UserDao uDao = new UserDao(FactoryProvider.getFactory());
                  int uId=user1.getUserId();
                  double totalExpensesToday=0;
                  List<Category> allUserCategories = cDao.getAllCategoryByUserId(uId);
                  if(allUserCategories == null || allUserCategories.isEmpty()){
                %>
                <img src="nothingtoshow.png" alt="Empty. Use the add button to fill this area!">
                <%} else{%>
                <table class="table">
                  <thead>
                    <tr>
                      <th scope="col">Name</th>
                      <th scope="col">Description</th>
                      <th scope="col">Type</th>
                      <th scope="col">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <% 
                    for(Category c : allUserCategories){
                    %>
                    <tr>
                      <td scope="row"><%=c.getCategoryTitle()%></td>
                      <td><%=c.getCategoryDescription()%></td>
                      <td><%=c.getCategoryType()!=null? c.getCategoryType(): "null"%></td>
                      <td><button type="button" name="editBtn" value="<%=c.getCategoryId()%>" class="btn action-btn" onclick="openPopup(pop_cu, this.value)">Edit</button></td>
                      <!--update category popup form-->
                  <div id="update-popup-cat<%=c.getCategoryId()%>" class="popup-container update-cat-form scroll-container">
                    <div class="close-button" onclick="closePopup(pop_cu, '<%=c.getCategoryId()%>')">X</div>
                    <form id="up-cat-form<%=c.getCategoryId()%>" action="./CategoryServlet" method="post" style="padding-left:inherit;">
                      <input type="hidden" value="<%=uId%>" name="userId">
                      <input type="hidden" value="<%=c.getCategoryId()%>" name="catId" id="up-cat-id">
                      <h3> Change a few errs</h3>
                      <br>
                      <label for="cat-name">Category Title : </label>
                      <br>
                      <small id="up-cat-name-error" class="error"></small>
                      <br>
                      <input type="text" id="up-cat-name" name="cat-name" placeholder="Title" value="<%=c.getCategoryTitle()%>"/>
                      <br>
                      <label for="cat-description">Category Description :</label>
                      <br>
                      <small id="up-cat-description-error" class="error"></small>
                      <br>
                      <textarea id="up-cat-description" placeholder="Enter description about the category" class="cat-textarea" name="cat-description"><%=c.getCategoryDescription()%></textarea>
                      <br>
                      <label for="up-select-category-type">Category Type: </label>
                      <br>

                      <select name="catType" id="category-type-dropdown" class="select-category-type">
                        <% if (c.getCategoryType() != null){
                        %>
                        <option value="<%=c.getCategoryType()%>" selected><%=c.getCategoryType()%></option>
                        <% } else{%>
                        <option value="Fixed Expense"> Fixed Expense</option>
                        <% }%>
                      </select>
                      <button type="submit" name="operationType" value="update" class="submitBtn-cat">Update Changes</button>
                    </form>
                    <form id="del-cat-form" action="./CategoryServlet" method="get" style="padding-left:inherit;">
                      <input type="hidden" value="<%=c.getCategoryId()%>" name="catId" id="del-cat-id">
                      <button type="submit" name="operationType" value="delete" class="submitBtn-cat">Delete Record</button>
                    </form>
                  </div>

                  </tr>

                  <%}%>
                  </tbody>
                </table>
                <%}%>
                <hr>
                <p>Add a New Category</p>

                <form id="cat-form" action="./CategoryServlet" method="post" style="padding-left:inherit;">
                  <div class="text-container">
                    <label for="cat-name">Category Title : </label>
                    <br>
                    <small id="cat-name-error" class="error"></small>
                    <br>
                    <input type="text" id="cat-name" name="cat-name" placeholder="Enter Title"/>
                    <br>
                  </div>
                  <div class="text-container">
                    <label for="cat-description">Category Description :</label>
                    <br>
                    <small id="cat-description-error" class="error"></small>
                    <br>
                    <textarea id="cat-description" placeholder="Enter description about the category" class="cat-textarea" name="cat-description"></textarea>
                    <br>
                  </div>
                  <label for="select-category-type">Category Type: </label>
                  <br>
                  <select name="catType" id="category-type-dropdown" class="select-category-type">
                    <option value="Fixed Expense"> Fixed Expense</option>
                  </select>
                  <button type="submit" class="submitBtn-exp">Add</button>
                </form>

              </div>



            </div>
          </div>



          <!--email preferences-->
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

          //entire content
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

          // Fetch country JSON data from the server for country dropdown
          function fetchJsonData() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "./components/country-by-currency-code.json", true);
            xhr.onload = function () {
              if (xhr.status === 200) {
                var data = JSON.parse(xhr.responseText);
                populateDropdown(data);
              } else {
                console.error("Failed to fetch JSON data");
              }
            };
            xhr.send();
          }

          // Populate dropdown with JSON data
          function populateDropdown(data) {
            var dropdown = document.getElementById("country-dropdown");

            data.forEach(function (item) {
              var option = document.createElement("option");
              option.value = item.country;
              option.text = item.country;
              dropdown.add(option);
            });
          }
          // Fetch and populate dropdown on page load
          fetchJsonData();




          //popup for update forms
          function openPopup(popup, id) {
            var pop = popup + id;
            document.getElementById(pop).style.display = "block";
            dynamicBtnId = id;
          }

          function closePopup(popup, id) {
            var pop = popup + id;
            document.getElementById(pop).style.display = "none";
          }

          //form validation
          const catAddForm = document.getElementById("cat-form");
          const catNameInput = document.getElementById("cat-name");
          const catDescriptionInput = document.getElementById("cat-description");
          const catNameError = document.getElementById("cat-name-error");
          const catDescriptionError = document.getElementById("cat-description-error");
          
  
          const upcatAddForm = document.getElementById("up-cat-form"+dynamicBtnId);
          const upcatNameInput = document.getElementById("up-cat-name");
          const upcatDescriptionInput = document.getElementById("up-cat-description");
          const upcatNameError = document.getElementById("up-cat-name-error");
          const upcatDescriptionError = document.getElementById("up-cat-description-error");


        </script>
      </div>
  </body>
</html>
