<%-- 
    Document   : expense
    Created on : 14 Aug 2024, 13:51:43
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.coincare.entities.Expense" %>
<%@page import="com.coincare.dao.ExpenseDao" %>
<%@page import="com.coincare.entities.User" %>
<%@page import="com.coincare.entities.Category" %>
<%@page import="com.coincare.dao.UserDao" %>
<%@page import="com.coincare.dao.CategoryDao" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your Expenses | CoinCare</title>
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
        <h2><a href="./dashboard.jsp"><i class='bx bx-left-arrow-alt'></i> Coin Care</a> / <a href="./expense.jsp">Expenses</a></h2>
        <h2><%=currentDay%> <%=currentMonth.toString()%>, <%=currentYear%></h2>
      </div>
      <%@include file="components/message.jsp" %>
      <div class="container">
        <div class="summary" style="display: flex; column-count: 3; justify-content: space-between;">
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
      <div class="custom-content">
        <% 
          ExpenseDao eDao = new ExpenseDao(FactoryProvider.getFactory());
          CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
          UserDao uDao = new UserDao(FactoryProvider.getFactory());
          User thisUser = uDao.getUseByEmail(user.getUserEmail());
          int uId=thisUser.getUserId();
          double totalExpensesToday=0;
          List<Category> allCategory = cDao.getAllCategoryForNewExpense(uId);
          List<Expense> allExpenses = eDao.getExpenseByUserIdToday(uId,currentDate);
          if(allExpenses.isEmpty()){
        %>
        <br>
        <br>
        <br>
        <br>
        <br>
        <center>
          <%@include file="components/empty.jsp"%>
        </center>
        <%
          }else{
        %>
        <table class="table">
          <thead>
            <tr>
              <th scope="col"><u>Date</u></th>
              <th scope="col"><u>Transaction</u></th>
              <th scope="col"><u>Remarks</u></th>
              <th scope="col"><u>Amount</u></th>
              <th scope="col"><u>Category</u></th>
              <th scope="col"><u>Mode</u></th>
              <th scope="col"><u>Actions</u></th>
            </tr>
          </thead>
          <tbody>
            <%
            for(Expense e : allExpenses){
            totalExpensesToday +=e.getExpenseAmount();
            %>
            <tr>
              <td scope="row"><%=MinorHelper.getDateFormatted(e.getExpenseDate())%></td>
              <td scope="row"><%=e.getExpenseTitle()%></td>
              <td><%=e.getExpenseRemarks()%></td>
              <td><%=e.getExpenseAmount()%></td>
              <td><%=(e.getCategory() != null ? e.getCategory().getCategoryTitle() : "No Category") %></td>
              <td><%=e.getMode()%></td>
              <td><button type="button" name="editBtn" value="<%=e.getExpenseId()%>" class="btn action-btn" onclick="openPopup(pop_u, this.value)">Edit</button></td>
              <!--update expense-->
          <div id="update-popup-exp<%=e.getExpenseId()%>" class="popup-container update-exp-form scroll-container">
            <div class="close-button" onclick="closePopup(pop_u, '<%=e.getExpenseId()%>')">X</div>
            <form id="update-exp-form" action="./ExpenseServlet" method="post" style="padding-left:inherit;">
              <input type="hidden"name="operationType" value="update">
              <input type="hidden" value="<%=uId%>" name="userId">
              <input type="hidden" value="<%=e.getExpenseId()%>" name="expId" id="up-exp-id">
              <h3> Change a few errs</h3>
              <br>
              <label for="up-select-category">Category: </label>
              <br>
              <!--expense category drop down-->
              <select name="catId" class="select-category">
                <!--add categorydao with user-category for expenses. for now -->

                <option value="<%=(e.getCategory() != null ? e.getCategory().getCategoryId() : 11) %>" selected> <%=(e.getCategory() != null ? e.getCategory().getCategoryTitle() : "No Category") %> </option>
                <%
            for(Category c : allCategory){
            if(c.getCategoryId() == e.getCategory().getCategoryId()) continue;
                %>
                <option value="<%=c.getCategoryId()%>"> <%=c.getCategoryTitle()%> </option>
                <%}%>
              </select>
              <br>

              <br>
              <label for="up-select-mode">Mode of Transaction: </label>
              <br>
              <select name="mode" class="select-category">
                <option value="<%=(e.getMode() != null ? e.getMode() : "No Mode") %>" selected><%=(e.getMode() != null ? e.getMode() : "No Mode") %></option>
                <% for(String m: modes){
                if(e.getMode().equals(m)) continue;
                %>
                <option value="<%=m%>"><%=m%></option>
                <%}%>
              </select>
              <br>
              <label for="exp-name">Expense on: </label>
              <br>
              <small id="up-exp-name-error" class="error"></small>
              <br>
              <input type="text" id="up-exp-name" name="up-exp-name" placeholder="Title" value="<%=e.getExpenseTitle()%>"/>
              <br>
              <label for="exp-description">Additional Remarks: </label>
              <br>
              <small id="up-exp-description-error" class="error"></small>
              <br>
              <input id="up-exp-description" placeholder="Enter description about expense" class="exp-textarea" name="up-exp-description" value="<%=e.getExpenseRemarks()%>"/>
              <br>
              <label for="exp-price">Amount: </label>
              <br><small id="up-exp-price-error" class="error"></small>
              <br>
              <input type="number" step = "0.1" min="0" id="up-exp-price" name="up-exp-price" placeholder="Amount in numbers"  value="<%=e.getExpenseAmount()%>" />
              <br>
              <button type="submit"class="submitBtn-exp">Update Changes</button>
            </form>
            <form id="del-exp-form" action="./ExpenseServlet" method="get" style="padding-left:inherit;">
              <input type="hidden" value="<%=e.getExpenseId()%>" name="expId" id="del-exp-id">
              <input type="hidden"name="operationType" value="delete">
              <button type="submit" class="submitBtn-exp">Delete Record</button>
            </form>
          </div>

          </tr>

          <%}%>
          </tbody>
        </table>

        <%}%>
      </div>
    </div>
    <label id="totalExpense" style="display:none;"> <%=totalExpensesToday%> </label>  


    <!--add expense-->
    <button class="add-button" id="dashboard-add-button" onclick="openAddPopup(pop_p)">+</button>



    <div id="popup-exp" class="popup-container scroll-container">
      <div class="close-button" onclick="closeAddPopup(pop_p)">X</div>
      <form id="exp-form" action="./ExpenseServlet" method="post" style="padding-left:inherit;">
        <input type="hidden" value="add" name="operationType">
        <input type="hidden" value="<%=uId%>" id="userId" name="userId">
        <!-- date added in backend -->
        <h3> Add New Expense</h3>
        <br>
        <label for="select-category">Category: </label>
        <br>
        <!--expense category drop down-->
        <select name="catId" class="select-category" id="selected-category" onchange="updatePrediction()" required>
          <option selected value="26">Select a Category</option>
          <%
            for(Category c : allCategory){
          %>
          <option value="<%=c.getCategoryId()%>"> <%=c.getCategoryTitle()%> </option>
          <%}%>
        </select>
        <br>
        <label for="select-mode">Mode of Transaction: </label>
        <br>
        <select name="mode" class="select-category" required>
          <% for(String m: modes){
          %>
          <option value="<%=m%>"><%=m%></option>
          <%}%>
        </select>
        <br>
        <label for="exp-name">What was the Expense on? </label>
        <small id="exp-name-error" class="error"></small>
        <br>
        <input type="text" id="exp-name" name="exp-name" placeholder="Title" required/>
        <br>
        <label for="exp-description">Additional Remarks: </label>
        <small id="exp-description-error" class="error"></small>
        <br>
        <input id="exp-description" placeholder="Enter description about expense" class="exp-textarea" name="exp-description" required/>
        <br>
        <label for="exp-price">Amount: </label>
        <small id="exp-price-error" class="error"></small>
        <br>
        <input type="number"  min="0" step="0.01" id="exp-price" name="exp-price" placeholder="Amount in numbers" required/>       
        <button type="submit" class="submitBtn-exp">Add</button>
      </form>

      <script>
        async function updatePrediction() {
          
          var selectedCategory = document.getElementById("selected-category").value;
          console.log(selectedCategory);
          var userId = document.getElementById("userId").value;
          var sending = selectedCategory + "." + userId;
          console.log(userId);
          console.log(sending);
          // Make an AJAX request to send the selected category
          var xhr = new XMLHttpRequest();
          await xhr.open("GET", "./ExpensePredictionServlet?category=" + selectedCategory, true);
          await xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

          xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
              // Update the predicted expense field with the returned value
              var response = xhr.responseText;
              document.getElementById("exp-price").value = parseFloat(response).toFixed(2);
            }
          };
          xhr.send();

        }
      </script>
    </div>
    <script>




      document.addEventListener('DOMContentLoaded', function () {
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



        const upexpForm = document.getElementById("update-exp-form");
        const delexpForm = document.getElementById("del-exp-form");
        const upexpNameInput = document.getElementById("up-exp-name");
        const upexpDescriptionInput = document.getElementById("up-exp-description");
        const upexpPriceInput = document.getElementById("up-exp-price");
        const upexpNameError = document.getElementById("up-exp-name-error");
        const upexpDescriptionError = document.getElementById("up-exp-description-error");
        const upexpPriceError = document.getElementById("up-exp-price-error");
//category form validation
        totalExp.innerHTML = 'Total Expense: ' + totalExpenseloaded.textContent;
        upexpForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validateText(upexpNameInput, upexpNameError) && validateText(upexpDescriptionInput, upexpDescriptionError) && validateText(upexpPriceInput, upexpPriceError) 
                  ) {
            upexpForm.submit();
          }
        });
        delexpForm.addEventListener("subit", function (event) {
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
      });
      function validateText(input, error_class) {
        const namevalue = input.value.trim();
        const error = error_class;
        const nameregex = /^[a-zA-Z&+\-\/\d\s]+$/;
        if (namevalue === "") {
          setError(input, " Cannot be Empty", error);
          return false;
        } else if (!nameregex.test(namevalue)) {
          setError(namevalue, " Shouldn't contain number.", error);
          return false;
        } else {
          removeError(input, error);
          return true;
        }
      }
      function validateNumber(nameInput, error_class) {
        const namevalue = nameInput.value.trim();
        // Regular expression to check if the input starts with a special character
        const nameregex = /^[^a-zA-Z0-9]/;
        const error = error_class;
        // Check if the input starts with a special character or is outside the range 0-999999
        if (nameregex.test(namevalue)) {
          setError(nameInput, " Should only contain number.", error);
          
          return false;
        }
        if (namevalue <= 0 || namevalue >= 999999) {
          setError(nameInput, "Not in range", error);
          return false;
        } else {
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
    </script>
  </body>
</html>
