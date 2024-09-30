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

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard | CoinCare</title>
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
        <h2><a href="./dashboard.jsp">Coin Care</a>\<a href="./dashboard.jsp">Dashboard</a></h2>
        <h2><%=currentDay%> <%=currentMonth.toString()%>, <%=currentYear%></h2>
      </div>
      <%@include file="components/message.jsp" %>
      <div class="container">
        <div class="summary" style="display: flex; column-count: 3; justify-content: space-between;">
          
          <div>
            <label id="totalIncomeShow">Total Income:0.0</label>
            <br>
            <label id="totalExpenseShow">Total Expense: 0.0</label>
            <br>
            <label id="balanceShow">Balance: 0.0</label>
          </div>
        </div>
      </div>


      <%
      String queryExpenseId = request.getParameter("ex");
      double totalExpensesToday = 0;
      double totalIncomesToday = 0;
      double calculatedBalance = 0;
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
        List<UserFinancials> allTransactions = uDao.getUserReportForToday(uId, currentDate);
        if(allTransactions.isEmpty()){
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

      <div class="custom-content">
        <table class="table">
          <thead>
            <tr>
              <th scope="col"><u>Date</u></th>
              <th scope="col"><u>Transaction</u></th>
              <th scope="col"><u>Remarks</u></th>
              <th scope="col"><u>Category</u></th>
              <th scope="col"><u>Mode</u></th>
              <th scope="col"><u>Amount</u></th>
            </tr>
          </thead>
          <tbody>
            <% 
            for(UserFinancials uf: allTransactions){     

            %>
            <tr>
              <td scope="row"><%=MinorHelper.getDateFormatted(uf.getDate())%></td>
              <td scope="row"><%=uf.getTitle()%></td>
              <td><%=uf.getDescription()%></td>
              <td class="dashboard-category"><%=uf.getCategory()%></td>
              <td><%=uf.getMode()%></td>
              <% if (uf.getType().equals("expense")){
              totalExpensesToday +=uf.getAmount();%>
              <td style="color:red;" class="dashboard-exp-amount"> - <%=uf.getAmount()%></td>
              <%}else if (uf.getType().equals("income")){
              totalIncomesToday +=uf.getAmount();%>
              <td style="color:#16c216;"> + <%=uf.getAmount()%></td>
              <%}else{} }%>
            </tr>
          </tbody>
        </table>
      </div>
      <%calculatedBalance = totalIncomesToday-totalExpensesToday; %>
      <label id="totalExpenses" style="display:none;"> <%=totalExpensesToday%> </label>  
      <label id="totalIncome" style="display:none;"> <%=totalIncomesToday%> </label>  
      <label id="calculatedBalance" style="display:none;"> <%=calculatedBalance%> </label>  

      <script>
        //for report visualization
        var totalExpenseDisplay = document.getElementById("totalExpenseShow");
        var totalIncomeDisplay = document.getElementById("totalIncomeShow");
        var balanceDisplay = document.getElementById("balanceShow");

        const totalExpenseloaded = document.getElementById("totalExpenses");
        const totalIncomeloaded = document.getElementById("totalIncome");
        const calculatedBalanceloaded = document.getElementById("calculatedBalance");
        var datasetDataInEx = [totalIncomeloaded.textContent, totalExpenseloaded.textContent];

        // Step 1 & 2: Get all amounts and corresponding categories
        const amounts = document.querySelectorAll('td.dashboard-exp-amount');
        const datasetData = []; // a. Array to store added amounts per category
        const labelData = []; // b. Array to store category labels
        const categoryTotals = {}; // Object to store total amounts per category
        const totalExpenseAmount = parseFloat(totalExpenseloaded.textContent);
        console.log('Amount elements found:', amounts.length);

        amounts.forEach(amountCell => {
          const categoryCell = (amountCell.previousElementSibling).previousElementSibling; // Get the previous sibling (category)

          // Check if categoryCell exists
          if (!categoryCell) {
            console.error('No sibling found for:', amountCell);
            return;
          }

          // Clean up the amount text (remove hyphens and extra spaces)
          let amountText = amountCell.textContent.trim().replace('-', '');

          const amount = parseFloat(amountText); // Convert cleaned text to a number
          const category = categoryCell.textContent.trim(); // Get category text

          if (!isNaN(amount)) {
            // Aggregate amounts by category
            if (categoryTotals[category]) {
              categoryTotals[category] += amount;
            } else {
              categoryTotals[category] = amount;
            }
          } else {
            console.error('Invalid amount found:', amountCell.textContent);
          }
        });

        console.log('Total Expense Loaded:', totalExpenseAmount);

        // Step 3: Add amounts under a category and multiply by 100/totalExpense
        for (const category in categoryTotals) {
          const categoryAmount = categoryTotals[category];
          const percentage = (categoryAmount * 100) / totalExpenseAmount;

          // Step 5: Push data to the arrays
          datasetData.push(percentage);
          labelData.push(category);
        }

        // Check the results
        console.log('Categories:', labelData);
        console.log('Dataset (percentages):', datasetData);
      </script>

      <%@include file="components/testchart.jsp"%>

      <% }
      %>


    </div>

    <!--add expense form-->
    <button class="add-button" id="dashboard-add-button" onclick="openAddPopup(pop_p)">+</button>

    <!--add new expense-->

    <div id="popup-exp" class="popup-container scroll-container">
      <div class="close-button" onclick="closeAddPopup(pop_p)">X</div>
      <form id="exp-form" action="./ExpenseServlet" method="post" style="padding-left:inherit;">
        <input type="hidden" value="add" name="operationType">
        <input type="hidden" value="<%=user.getUserId()%>" name="userId">
        <!-- date added in backend -->
        <h3> Add New Expense</h3>
        <br>
        <label for="select-category">Category: </label>
        <br>
        <!--expense category drop down-->
        <select name="catId" class="select-category">
          <%
            for(Category c : allCategory){
          %>
          <option value="<%=c.getCategoryId()%>"> <%=c.getCategoryTitle()%> </option>
          <%}%>
        </select>
        <br>
         <label for="select-mode">Mode of Transaction: </label>
        <br>
        <select name="mode" class="select-category">
          <% for(String m: modes){
          %>
          <option value="<%=m%>"><%=m%></option>
          <%}%>
        </select>
        <br>
        
        <label for="exp-name">What was the Expense on? </label>
        <small id="exp-name-error" class="error"></small>
        <br>
        <input type="text" id="exp-name" name="exp-name" placeholder="Title"/>
        <br>
        <label for="exp-description">Additional Remarks: </label>
        <small id="exp-description-error" class="error"></small>
        <br>
        <input id="exp-description" placeholder="Enter description about expense" class="exp-textarea" name="exp-description"/>
        <br>
        <label for="exp-price">Amount: </label>
        <small id="exp-price-error" class="error"></small>
        <br>
        <input type="number" id="exp-price" name="exp-price" placeholder="Amount in numbers" />

        <br>
       
        
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
      document.addEventListener('DOMContentLoaded', function () {

        //display income/expenses
        totalExpenseDisplay.innerHTML = 'Total Expense: ' + totalExpenseloaded.textContent;
        totalIncomeDisplay.innerHTML = 'Total Income: ' + totalIncomeloaded.textContent;
        balanceDisplay.innerHTML = 'Balance: ' + calculatedBalanceloaded.textContent;


        //add expense form validation
        expForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (validateText(expNameInput, expNameError) && validateText(expDescriptionInput, expDescriptionError) && validateText(expPriceInput, expPriceError)) {
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
