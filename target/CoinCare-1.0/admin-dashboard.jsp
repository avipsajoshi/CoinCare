<%-- 
    Document   : admin-dashboard
    Created on : 27 Jul 2024, 20:10:40
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.coincare.entities.User" %>
<%@page import="com.coincare.entities.Category" %>
<%@page import="com.coincare.entities.BudgetPlan" %>
<%@page import="com.coincare.helper.MinorHelper" %>
<%@page import="com.coincare.entities.Article" %>
<%@page import="com.coincare.helper.FactoryProvider" %>
<%@page import="com.coincare.dao.UserDao" %>
<%@page import="com.coincare.dao.CategoryDao" %>
<%@page import="com.coincare.dao.BudgetPlanDao" %>
<%@page import="com.coincare.dao.ArticleDao" %>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
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
    int uId = user.getUserId();
    LocalDate currentDate = LocalDate.now();
    int currentYear = currentDate.getYear();
    int currentDay = currentDate.getDayOfMonth();
    Month currentMonth = currentDate.getMonth();
    String[] categoryTypes = {"Fixed Expenses", "Non-fixed Expenses","Emergency Expenses","Education Expenses", "Other Expenses"};

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
                <th scope="col">Status</th>
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
                <td scope="row"><%=u.getUserVerify()%></td>
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
                    <form id="admin-user-to-admin-form" action="./AdminServlet" method="get" style="padding-left:inherit;">
                      <input type="hidden" value="<%= userid %>" name="userId" id="makeAdmin">
                      <button type="submit" name="operationType" value="remove" class="submitBtn-admin">Remove</button>
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
                <th scope="col">Status</th>
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
                <td scope="row"><%=au.getUserVerify()%></td>
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


          <table class="table">
            <thead>
              <tr>
                <th scope="col">Title</th>
                <th scope="col">Description</th>
                <th scope="col">Creator</th>
                <th scope="col" onclick="opencategory()"> + </th>
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
                <td scope="row"><%=c.getUser().getUserName()%></td>
                <%
                  if(user.getUserType().equals("owner")){
                %>
                <td><button type="button" name="editBtn" value="<%=c.getCategoryId()%>" class="btn action-btn" onclick="openPopup(pop_c, '<%=c.getCategoryId()%>')">...</button>
                  <div id="popup-category<%=c.getCategoryId()%>" class="popup-container scroll-container">
                    <div class="close-button" onclick="closePopup(pop_c, '<%=c.getCategoryId()%>')">X</div>
                    <form id="admin-category-form" action="./CategoryServlet" method="get" style="padding-left:inherit;">
                      <input type="hidden" name="operationType" value="adminCatUpdate">
                      <input type="hidden" value="<%=c.getCategoryId()%>" name="catId" id="up-cat-id">
                      <h3> Change a few errs</h3>
                      <br>
                      <div class="text-container">
                        <label for="cat-name">Category Title : </label>
                        <br>
                        <small id="up-cat-name-error" class="error"></small>
                        <br>
                        <input type="text" id="up-cat-name" name="up-cat-name" placeholder="Title" value="<%=c.getCategoryTitle()%>"/>
                      </div>
                      <div class="text-container">
                        <label for="cat-description">Category Description :</label>
                        <br>
                        <small id="up-cat-description-error" class="error"></small>
                        <br>
                        <input id="up-cat-description" placeholder="Enter description about the category" class="cat-textarea" name="up-cat-description" value="<%=c.getCategoryDescription()%>"/>
                      </div>
                      <div class="text-container">
                        <label for="up-select-category-type">Category Type: </label>
                        <br>
                        <select name="up-catType" id="category-type-dropdown" class="select-category-type">
                          <option value="<%=(c.getCategoryType() != null ? c.getCategoryType() : "No Category") %>" selected><%=(c.getCategoryType() != null ? c.getCategoryType() : "No Category") %></option>
                          <% for(String ct: categoryTypes){
                          if(c.getCategoryType().equals(ct)) continue;
                          %>
                          <option value="<%=ct%>"><%=ct%></option>
                          <%}%>
                        </select>
                      </div>
                      <button type="submit" name="operationType" value="adminCatUpdate" class="submitBtn-admin">Edit</button>
                    </form>
                    <form id="admin-category-delete-form" action="./CategoryServlet" method="get" style="padding-left:inherit;">
                      <button type="submit" class="submitBtn-admin" name="operationType" value="adminCatDelete" class="submitBtn-admin">Delete</button>
                    </form>
                  </div>
                </td>
                <%}%>
              </tr>
              <%}%>
            </tbody>
          </table>

          <div id="add-cat" class="popup-container scroll-container">
            <div class="close-button" onclick="closecategory()">X</div>
            <form id="cat-form" action="./CategoryServlet" method="post" style="padding-left:inherit;">
              <h3>Add a category</h3>
              <input type="hidden" name="operationType" value="adminCatAdd">
              <input type="hidden" value="<%=uId%>" name="userId">
              <div class="text-container">
                <label for="cat-name">Category Title : </label>
                <br>
                <small id="cat-name-error" class="error"></small>
                <br>
                <input type="text" id="cat-name" name="cat-name" placeholder="Enter Title"/>
              </div>
              <div class="text-container">
                <label for="cat-description">Category Description :</label>
                <br>
                <small id="cat-description-error" class="error"></small>
                <input id="cat-description" placeholder="Enter description about the category" class="cat-textarea" name="cat-description"/>
                <br>
              </div>
              <div class="text-container">
                <label for="select-category-type">Category Type: </label>
                <select name="catType" id="category-type-dropdown" class="select-category-type">
                  <% for(String ct: categoryTypes){%>
                  <option value="<%=ct%>"><%=ct%></option>
                  <%}%>
                </select>
              </div>
              <br>
              <button type="submit" class="submitBtn-admin">Add</button>
            </form>
          </div>



        </div>

        <!--budget plans controls-->

        <div class="tab-content" id="tab4">


          <table class="table">
            <thead>
              <tr>
                <th scope="col">Title</th>
                <th scope="col">Description</th>
                <th scope="col">Creator</th>
                <th scope="col" onclick="openbudget()"> + </th>
              </tr>
            </thead>
            <tbody>
              <%
              BudgetPlanDao bDao = new BudgetPlanDao(FactoryProvider.getFactory());
              List<BudgetPlan> allBudgetPlans = bDao.getAllBudgetPlan();
              for(BudgetPlan b : allBudgetPlans){
              %>
              <tr>
                <td scope="row"><%=b.getBudgetPlanTitle()%></td>
                <td scope="row"><%=b.getBudgetPlanDescription()%></td>
                <td scope="row"><%=b.getUser().getUserName()%></td>
                <%
                  if(user.getUserType().equals("owner")){
                %>
                <td><button type="button" name="editBtn" value="<%=b.getBudgetPlanId()%>" class="btn action-btn" onclick="openPopup(pop_b, '<%=b.getBudgetPlanId()%>')">...</button>
                  <div id="popup-budget<%=b.getBudgetPlanId()%>" class="popup-container scroll-container">
                    <div class="close-button" onclick="closePopup(pop_b, '<%=b.getBudgetPlanId()%>')">X</div>
                    <form id="admin-budget-form" action="./BudgetPlanServlet" method="get" style="padding-left:inherit;">

                      <input type="hidden" value="update" name="operationType">
                      <input type="hidden" value="<%=uId%>" id="userId" name="userId">
                      <input type="hidden" value="<%=b.getBudgetPlanId()%>" id="up-budget-id" name="up-budget-id">

                      <h3>Update Budget Plan</h3>
                      <br>

                      <label for="up-budget-name">Budget Title:</label>
                      <small id="up-budget-name-error" class="error"></small>
                      <br>
                      <input type="text" id="up-budget-name" name="up-budget-name" placeholder="Enter budget title" value="<%=b.getBudgetPlanTitle()%>" required/>
                      <br>

                      <label for="up-budget-description">Budget Description:</label>
                      <small id="up-budget-description-error" class="error"></small>
                      <br>
                      <input id="up-budget-description" placeholder="Enter description about the budget" class="budget-textarea" name="up-budget-description" value="<%=b.getBudgetPlanDescription()%>" required/>
                      <br>

                      <label for="up-budget-exp">Expenses Percentage</label>
                      <small id="up-budget-exp-error" class="error"></small>
                      <br>
                      <input type="number" id="up-budget-exp" name="up-budgetExp" placeholder="Enter percent for expenses" value="<%=b.getBudgetPlanExpense()%>" required/>
                      <br>

                      <label for="up-budget-want">Wants Amount:</label>
                      <small id="up-budget-want-error" class="error"></small>
                      <br>
                      <input type="number" id="up-budget-want" name="up-budgetWant" placeholder="Enter amount for wants" value="<%=b.getBudgetPlanWants()%>" required/>
                      <br>

                      <label for="up-budget-save">Savings Amount:</label>
                      <small id="up-budget-save-error" class="error"></small>
                      <br>
                      <input type="number" id="up-budget-save" name="up-budgetSave" placeholder="Enter amount for savings" value="<%=b.getBudgetPlanSavings()%>" required/>
                      <br>

                      <button type="submit" name="operationType" value="adminBpUpdate" class="submitBtn-admin">Edit</button>
                    </form>
                    <form id="admin-budget-delete-form" action="./BudgetPlanServlet" method="get" style="padding-left:inherit;">
                      <input type="hidden" value="<%=b.getBudgetPlanId()%>" id="budget-id" name="budget-id">
                      <button type="submit" name="operationType" value="adminBpDelete" class="submitBtn-admin">Remove</button>
                    </form>
                  </div>
                </td>
                <%}%>
              </tr>
              <%}%>
            </tbody>
          </table>

          <div id="add-budget" class="popup-container scroll-container">
            <div class="close-button" onclick="closebudget()">X</div>
            <form id="budget-form" action="./BudgetServlet" method="post" style="padding-left:inherit;">
              <input type="hidden" value="adminBpAdd" name="operationType">
              <input type="hidden" value="<%=uId%>" id="userId" name="userId">

              <h3>Add New Budget Plan</h3>
              <br>

              <label for="budget-name">Budget Title:</label>
              <small id="budget-name-error" class="error"></small>
              <br>
              <input type="text" id="budget-name" name="budget-name" placeholder="Enter budget title" />
              <br>

              <label for="budget-description">Budget Description:</label>
              <small id="budget-description-error" class="error"></small>
              <br>
              <input id="budget-description" placeholder="Enter description about the budget" class="budget-textarea" name="budget-description" />
              <br>

              <label for="budget-exp">Expenses Percentage:</label>
              <small id="budget-exp-error" class="error"></small>
              <br>
              <input type="number" id="budget-exp" name="budgetExp" placeholder="Enter percent for expenses" required/>
              <br>

              <label for="budget-want">Wants Percentage:</label>
              <small id="budget-want-error" class="error"></small>
              <br>
              <input type="number" id="budget-want" name="budgetWant" placeholder="Enter percent for wants" required />
              <br>

              <label for="budget-save">Savings Percentage:</label>
              <small id="budget-save-error" class="error"></small>
              <br>
              <input type="number" id="budget-save" name="budgetSave" placeholder="Enter percent for savings" required/>
              <br>

              <button type="submit" class="submitBtn-admin">Add Budget Plan</button>
            </form>
          </div>


        </div>

        <!--articles controls-->

        <div class="tab-content" id="tab5">
          <table class="table">
            <thead>
              <tr>
                <th scope="col">Title</th>
                <th scope="col">Description</th>
                <th scope="col">Status</th>
                <th scope="col" onclick="openarticle()"> + </th>
              </tr>
            </thead>
            <tbody>
              <%
                ArticleDao articleDao = new ArticleDao(FactoryProvider.getFactory());
                List<Article> allArticles = articleDao.getAllArticles();
                for(Article a : allArticles){
              %>
              <tr>
                <td scope="row"><%=a.getArticleTitle()%></td>
                <td scope="row"><%=MinorHelper.get20Words(a.getArticleBody())%></td>
                <!--<td scope="row"><% //a.getUser().getUserName()%></td>-->
                <td scope="row"><%=a.getPublishStatus()%></td>
                <td><button type="button" name="editBtn" value="<%=a.getArticleId()%>" class="btn action-btn" onclick="openPopup(pop_ar, '<%=a.getArticleId()%>')">...</button>
                  <div id="popup-article<%=a.getArticleId()%>" class="popup-container scroll-container">
                    <div class="close-button" onclick="closePopup(pop_ar, '<%=a.getArticleId()%>')">X</div>
                    <form id="article-up-form" action="./ArticleServlet" method="get" style="padding-left:inherit;">
                      <input type="hidden" name="articleId" value="<%= a.getArticleId() %>">
                      <label for="title">Article Title:</label>
                      <small id="article-up-title-error" class="error"></small>
                      <input type="text" id="article-up-title" name="articleTitle" value="<%= a.getArticleTitle() %>" required>

                      <label for="article-up-body">Article Body:</label>

                      <small id="article-up-body-error" class="error"></small>
                      <textarea id="article-up-body" name="articleBody" required><%=a.getArticleBody() %></textarea>

                      <label for="publishStatus">Publish Status:</label>
                      <select id="publishStatus" name="publishStatus" required>
                        <option value="published" <%= a.getPublishStatus().equals("published") ? "selected" : "" %> >Published</option>
                        <option value="draft" <%= a.getPublishStatus().equals("not-published") ? "selected" : "" %>>Not Published </option>
                      </select>
                      <button type="submit" name="operationType" value="update" class="submitBtn-admin">Edit</button>
                    </form>
                    <form id="article-delete-form" action="./ArticleServlet" method="get" style="padding-left:inherit;">
                      <input type="hidden" name="articleId" value="<%= a.getArticleId() %>">
                      <button type="submit" name="operationType" value="delete" class="submitBtn-admin">Remove</button>
                    </form>
                  </div>
                </td>
              </tr>
              <%}%>
            </tbody>
          </table>


          <div id="add-article" class="popup-container scroll-container">
            <div class="close-button" onclick="closearticle()">X</div>
            <form id="article-form" action="./ArticleServlet" method="post" style="padding-left:inherit;">
              <input type="hidden" value="add" name="operationType">
              <input type="hidden" value="<%=uId%>" id="userId" name="userId">

              <h3>Add New Article</h3>
              <br>

              <label for="article-name">Article Heading</label>
              <small id="article-name-error" class="error"></small>
              <br>
              <input type="text" id="article-name" name="articleTitle" placeholder="Enter aritcle heading" />
              <br>

              <label for="article-description">Article Body</label> <button
                type="button"
                onclick="makeBold()"
                >
                <i class="bx bx-bold"></i>
              </button>
              <button type="button" onclick="makeItalic()">
                <i class="bx bx-italic"></i>
              </button>
              <small id="article-description-error" class="error"></small>
              <br>
              <textarea id="article-description" placeholder="Enter article body" class="article-textarea" name="articleBody"></textarea>
              <br>

              <label for="status">Status:</label>
              <select id="status" name="publishStatus" class="select-category" required>
                <option value="not_published">Not Published</option>
                <option value="published">Published</option>
              </select><br /><br />

              <button type="submit" class="submitBtn-admin">Add Article</button>
            </form>
          </div>

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

      function opencategory() {
        document.getElementById("add-cat").style.display = "block";
      }
      function closecategory() {
        document.getElementById("add-cat").style.display = "none";
      }
      function openbudget() {
        document.getElementById("add-budget").style.display = "block";
      }
      function closebudget() {
        document.getElementById("add-budget").style.display = "none";
      }
      function openarticle() {
        document.getElementById("add-article").style.display = "block";
      }
      function closearticle() {
        document.getElementById("add-article").style.display = "none";
      }

      function makeBold() {
        document.execCommand("bold"); // Makes selected text bold
      }

      function makeItalic() {
        document.execCommand("italic"); // Makes selected text italic
      }
      //for user actions
      let userIdforChange = document.getElementById("admin-user-id");
      let userIdToMakeAdmin = document.getElementById("makeAdmin");
      let adminIdToRemove = document.getElementById("admin-user-id");
      let adminIdToMakeOwner = document.getElementById("makeOwner");
      userIdforChange.value = dynamicBtnId;
      userIdToMakeAdmin.value = dynamicBtnId;

      document.addEventListener('DOMContentLoaded', function () {

        // Category Update Form
        const catForm = document.getElementById("admin-category-form");
        const catNameInput = document.getElementById("up-cat-name");
        const catDescriptionInput = document.getElementById("up-cat-description");
        const catNameError = document.getElementById("up-cat-name-error");
        const catDescriptionError = document.getElementById("up-cat-description-error");
        const catTypeDropdown = document.getElementById("category-type-dropdown");

        catForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validateText(catNameInput, catNameError) &&
                  validateText(catDescriptionInput, catDescriptionError)
                  ) {
            catForm.submit();
          }
        });


// Budget Update Form
        const budgetForm = document.getElementById("admin-budget-form");
        const budgetNameInput = document.getElementById("up-budget-name");
        const budgetDescriptionInput = document.getElementById("up-budget-description");
        const budgetExpenseInput = document.getElementById("up-budget-exp");
        const budgetWantsInput = document.getElementById("up-budget-want");
        const budgetSavingsInput = document.getElementById("up-budget-save");

        const budgetNameError = document.getElementById("up-budget-name-error");
        const budgetDescriptionError = document.getElementById("up-budget-description-error");
        const budgetExpenseError = document.getElementById("up-budget-exp-error");
        const budgetWantsError = document.getElementById("up-budget-want-error");
        const budgetSavingsError = document.getElementById("up-budget-save-error");

        budgetForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validateText(budgetNameInput, budgetNameError) &&
                  validateText(budgetDescriptionInput, budgetDescriptionError)
                  ) {
            budgetForm.submit();
          }
        });

// Add Category Form
        const addCatForm = document.getElementById("cat-form");
        const addCatNameInput = document.getElementById("cat-name");
        const addCatDescriptionInput = document.getElementById("cat-description");
        const addCatTypeDropdown = document.getElementById("category-type-dropdown");
        const addCatNameError = document.getElementById("cat-name-error");
        const addCatDescriptionError = document.getElementById("cat-description-error");

        addCatForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validateText(addCatNameInput, addCatNameError) &&
                  validateText(addCatDescriptionInput, addCatDescriptionError)
                  ) {
            addCatForm.submit();
          }
        });


// Add Article Form
        const addArticleForm = document.getElementById("article-form");
        const addArticleTitleInput = document.getElementById("article-name");
        const addArticleBodyInput = document.getElementById("article-description");
        const addArticleStatusDropdown = document.getElementById("status");
        const addArticleTitleError = document.getElementById("article-name-error");
        const addArticleBodyError = document.getElementById("article-description-error");

        addArticleForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validateText(addArticleTitleInput, addArticleTitleError) &&
                  validateText(addArticleBodyInput, addArticleBodyError)
                  ) {
            addArticleForm.submit();
          }
        });

// Article Update Form
        const articleupForm = document.getElementById("article-up-form");
        const articleUpTitle = document.getElementById("article-up-title");
        const articleUpBody = document.getElementById("article-up-body");
        const articlePublishStatusDropdown = document.getElementById("publishStatus");
        const articleUpTitleError = document.getElementById("article-up-title-error");
        const articleUpBodyError = document.getElementById("article--up-body-error");

        articleupForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validateText(articleUpTitle, articleUpTitleError) &&
                  validateText(articleUpBody, articleUpBodyError)
                  ) {
            articleupForm.submit();
          }
        });
      });




      function validateText(input, error_class) {
        const namevalue = input.value.trim();
        const error = error_class;
        const nameregex = /^[a-zA-Z&+\-\/\d\s]+$/;
        if (namevalue === "") {
          setError(input, " Cannot be Empty", error);
          return false;
        } else {
          removeError(input, error);
          return true;
        }
      }
      // Set error message
      function setError(inputElement, message, errorId) {
        const errorElement = errorId;
        errorElement.textContent = message;
      }

      // Remove error message
      function removeError(inputElement, errorId) {
        const errorElement = errorId;
        errorElement.textContent = "";
      }

    </script>
  </body>
</html>
