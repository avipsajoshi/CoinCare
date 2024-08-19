<%-- 
    Document   : dashboard
    Created on : 27 Jul 2024, 20:10:45
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.util.HashMap" %>
<%@page import="com.coincare.entities.Expense" %>
<%@page import="com.coincare.dao.ExpenseDao" %>
<%@page import="com.coincare.entities.User" %>
<%@page import="com.coincare.entities.UserFinancials" %>
<%@page import="com.coincare.entities.Category" %>
<%@page import="com.coincare.dao.UserDao" %>
<%@page import="com.coincare.dao.CategoryDao" %>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%
    LocalDate currentDate = LocalDate.now();
    int currentYear = currentDate.getYear();
    int currentDay = currentDate.getDayOfMonth();
    Month currentMonth = currentDate.getMonth();
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="css/fontAndColors.css"/>
    <link rel="stylesheet" href="css/elementStyles.css"/>
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
    <script>
      pop_p = "popup-exp";
      pop_u = "update-popup-exp";
      let dynamicBtnId;
    </script>
  </head>
  <body class="body">
    <script src="js/light-dark.js"></script>
    <%@include file="components/nav.jsp"%>

    <div class="main-content">
      <div class="container">
        <h1>Coin Care</h1>
      </div>
      <%@include file="components/message.jsp" %>
      <div class="container">

        <h2>Transaction Analysis </h2>
        <div class="summary" style="display: flex; column-count: 3; justify-content: space-between;">
          <h3><%=currentDay%> <%=currentMonth.toString()%>, <%=currentYear%></h3>
          <label id="totalExp">Total Expense: </label>
        </div>
      </div>


      <%
      String queryExpenseId = request.getParameter("ex");
      if(queryExpenseId!=null){
      %>
      <script>
      openPopup(popup_u);
      dynamicBtnId = '<%=queryExpenseId%>';
      </script>
      <%}%>
      <%
        ExpenseDao eDao = new ExpenseDao(FactoryProvider.getFactory());
        CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
        UserDao uDao = new UserDao(FactoryProvider.getFactory());
        User thisUser = uDao.getUseByEmail(user.getUserEmail());
        int uId=thisUser.getUserId();
        List<Category> allCategory = cDao.getAllCategoryForNewExpense(uId);
        List<UserFinancials> allTransactions = uDao.getUserReportForToday(uId,currentDate);
        if(allTransactions.isEmpty()){
      %>
      <br>
      <br>
      <br>
      <br>
      <br>
      <center>
        <%@include file="components/logo.jsp"%>
      </center>
      <%
        }else{
      %>

      <div class="custom-content">
        <table class="table">
          <thead>
            <tr>
              <th scope="col">Transaction</th>
              <th scope="col">Description</th>
              <th scope="col">Amount</th>
              <th scope="col">Mode</th>
              <!--<th scope="col"></th>-->
            </tr>
          </thead>
          <tbody>
            <% 
            for(UserFinancials uf: allTransactions){
//              totalExpensesToday +=e.getExpenseAmount();
            %>
            <tr>
              <td scope="row"><%=uf.getTitle()%></td>
              <td><%=uf.getDescription()%></td>
              <% if (uf.getType().equals("expense")){ %>
              <td style="color:red;"> - <%=uf.getAmount()%></td>
              <%}else if (uf.getType().equals("income")){%>
              <td style="color:#16c216;"> + <%=uf.getAmount()%></td>
              <%}}%>
            </tr>
          </tbody>
        </table>
      </div>
      <% }
      %>
    </div>



    <!--add expense-->
    <button class="add-button" id="dashboard-add-button" onclick="openAddPopup(pop_p)">+</button>



    <div id="popup-exp" class="popup-container scroll-container">
      <div class="close-button" onclick="closeAddPopup(pop_p)">X</div>
      <form id="exp-form" action="./ExpenseServlet" method="post" style="padding-left:inherit;">
        <input type="hidden" value="add" name="operationType">
        <input type="hidden" value="<%=user.getUserId()%>" name="userId">
        <!-- date added in backend -->
        <h3> Add New Expense</h3>
        <br>
        <label for="exp-name">What was the Expense on? </label>
        <small id="exp-name-error" class="error"></small>
        <br>
        <input type="text" id="exp-name" name="exp-name" placeholder="Title"/>
        <br>
        <label for="exp-description">Additional Remarks: </label>
        <small id="exp-description-error" class="error"></small>
        <br>
        <textarea id="exp-description" placeholder="Enter description about expense" class="exp-textarea" name="exp-description"></textarea>
        <br>
        <label for="exp-price">Amount: </label>
        <small id="exp-price-error" class="error"></small>
        <br>
        <input type="number" id="exp-price" name="exp-price" placeholder="Amount in numbers" />

        <br>
        <label for="select-category">Category: </label>
        <br>
        <!--expense category drop down-->
        <select name="catId" class="select-category">
          <!--add categorydao with user-category for expenses. for now -->
          <%
            for(Category c : allCategory){
          %>
          <option value="<%=c.getCategoryId()%>"> <%=c.getCategoryTitle()%> </option>
          <%}%>
        </select>
        <button type="submit" class="submitBtn-exp">Add</button>
      </form>
    </div>
    <script>

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

      //exp from validation input add
      const totalExpenseloaded = document.getElementById("totalExpense");
      const totalExp = document.getElementById("totalExp");
      const expForm = document.getElementById("exp-form");
      const expNameInput = document.getElementById("exp-name");
      const expDescriptionInput = document.getElementById("exp-description");
      const expPriceInput = document.getElementById("exp-price");
      const expNameError = document.getElementById("exp-name-error");
      const expDescriptionError = document.getElementById("exp-description-error");
      const expPriceError = document.getElementById("exp-price-error");
      //update and delete

//      let delexpid = document.getElementById("del-exp-id");
//      let upexpid = document.getElementById("up-exp-id");
//      delexpid.value = dynamicBtnId;
//      upexpid.value = dynamicBtnId;



      const upexpForm = document.getElementById("update-exp-form");
      const delexpForm = document.getElementById("del-exp-form");
      const upexpNameInput = document.getElementById("up-exp-name");
      const upexpDescriptionInput = document.getElementById("up-exp-description");
      const upexpPriceInput = document.getElementById("up-exp-price");
      const upexpNameError = document.getElementById("up-exp-name-error");
      const upexpDescriptionError = document.getElementById("up-exp-description-error");
      const upexpPriceError = document.getElementById("up-exp-price-error");
//category form validation
      document.addEventListener('DOMContentLoaded', function () {
        totalExp.innerHTML = 'Total Expense: ' + totalExpenseloaded.textContent;
        upexpForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validateText(upexpNameInput, upexpNameError) && validateText(upexpDescriptionInput, upexpDescriptionError) && validateText(upexpPriceInput, upexpPriceError)
                  ) {
            upexpForm.submit();
          }
        });
        delexpForm.addEventListener("button", function (event) {
          event.preventDefault();
          window.confirm("Are you sure?");
          delexpForm.submit();
        });
        expForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validateText(expNameInput, expNameError) && validateText(expDescriptionInput, expDescriptionError) && validateText(expPriceInput, expPriceError)
                  ) {
            expForm.submit();
          }
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
      });
    </script>
  </body>
</html>
