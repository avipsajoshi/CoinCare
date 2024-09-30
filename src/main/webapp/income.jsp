<%-- 
    Document   : income
    Created on : 28 Jul 2024, 18:11:16
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.coincare.entities.Income" %>
<%@page import="com.coincare.dao.IncomeDao" %>
<%@page import="com.coincare.entities.User" %>
<%@page import="com.coincare.dao.UserDao" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your Income | CoinCare</title>
    <link rel="stylesheet" href="css/fontAndColors.css"/>
    <link rel="stylesheet" href="css/elementStyles.css"/>
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">

    <script>
      pop_i = "popup-inc";
      pop_iu = "update-popup-inc";
      let dynamicBtnId;

    </script>

  </head>
  <body class="body">
    <script src="js/light-dark.js"></script>
    <%@include file="components/nav.jsp"%>

    <div class="main-content">
      <div class="container">
        <h2><a href="./dashboard.jsp">Coin Care</a>\<a href="./income.jsp">Income</a></h2>
        <h2><%=currentDay%> <%=currentMonth.toString()%>, <%=currentYear%></h2>
      </div>
      <%@include file="components/message.jsp" %>
      <div class="container">
        <div class="summary" style="display: flex; column-count: 3; justify-content: space-between;">
          <label id="totalInc">Total Income: </label>
        </div>
      </div>

      <div class="custom-content">
        <%
        IncomeDao eDao = new IncomeDao(FactoryProvider.getFactory());
        UserDao uDao = new UserDao(FactoryProvider.getFactory());
        User thisUser = uDao.getUseByEmail(user.getUserEmail());
        int uId=thisUser.getUserId();
        double totalIncomeToday=0;
        List<Income> allIncomes = eDao.getUserIncomeForTheMonth(uId);
        if(allIncomes.isEmpty()){
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
            for(Income e : allIncomes){
            
              totalIncomeToday +=e.getIncomeAmount();
            %>
            <tr>
              <td scope="row"><%=MinorHelper.getDateFormatted(e.getIncomeDate())%></td>
              <td scope="row"><%=e.getIncomeSource()%></td>
              <td><%=e.getIncomeDescription()%></td>
              <td><%=e.getIncomeAmount()%></td>
              <td><%=e.getIncomeType()%></td>
              <td><%=e.getMode()%></td>
              <td><button type="button" name="editBtn" class="btn action-btn" onclick="openUpdatePopup(pop_iu, '<%=e.getIncomeId()%>')">Edit</button></td>
          <div id="update-popup-inc<%=e.getIncomeId()%>" class="popup-container scroll-container">
            <div class="close-button" onclick="closeUpdatePopup(pop_iu, '<%=e.getIncomeId()%>')">X</div>
            <form id="update-inc-form" action="./IncomeServlet" method="post" style="padding-left:inherit;">
              <input type="hidden" name="operationType"  value="update" >
              <input type="hidden" value="<%=user.getUserId()%>" name="userId">
              <input type="hidden" value="<%=e.getIncomeId()%>" name="incId" id="up-inc-id">
              <h3> Change a few errs</h3>
              <br>
              <label for="up-select-category">Type: </label>
              <br>
              <!--incense category drop down-->
              <select name="up-catId" class="select-category">
                <!--add categorydao with user-category for incenses. for now -->
                <option value="Salary(Monthly)"> Salary(monthly)</option>
                <option value="Wages(weekly)"> Wages(weekly)</option>
                <option value="Family allowance"> Family allowance</option>
                <option value="Sale of possession">Sale of possession</option>
                <option value="Dividend/profit received"> Dividends/profit received</option>
                <option value="Interest from loan or Fixed Deposit"> Interest from loan or Fixed Deposit</option>
                <option value="Other Incomes"> Other Incomes</option>
              </select>
              <br>
              <label for="inc-name">Income on: </label>
              <br>
              <small id="up-inc-name-error" class="error"></small>
              <br>
              <input type="text" id="up-inc-name" name="up-inc-name" placeholder="Title" value="<%=e.getIncomeSource()%>"/>
              <br>
              <label for="inc-name">Description: </label>
              <br>
              <small id="up-inc-des-error" class="error"></small>
              <br>
              <input type="text" id="up-inc-des" name="up-inc-des" placeholder="Description" value="<%=e.getIncomeDescription()%>"/>
              <br>
              <label for="up-inc-price">Amount: </label>
              <br><small id="up-inc-price-error" class="error"></small>
              <br>
              <input type="number" id="up-inc-price" name="up-inc-price" placeholder="Amount in numbers" value="<%=e.getIncomeAmount()%>"/>
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
              <button type="submit" class="submitBtn-inc">Update Changes</button>
            </form>
            <form id="del-inc-form" action="./IncomeServlet" method="get" style="padding-left:inherit;">
              <input type="hidden" value="<%=e.getIncomeId()%>" name="incId" id="del-inc-id">
              <input type="hidden" name="operationType"  value="delete" >
              <button type="submit" class="submitBtn-inc">Delete</button>
            </form>
          </div>
          </tr>

          <%}%>
          </tbody>
        </table>

        <%}%>
      </div>
    </div>

    <label id="totalIncome" style="display:none;"> <%=totalIncomeToday%> </label>  

    <!--add income-->
    <button class="add-button" id="dashboard-add-button" onclick="openPopup(pop_i)">+</button>
    <div id="popup-inc" class="popup-container scroll-container">
      <div class="close-button" onclick="closePopup(pop_i)">X</div>
      <form id="inc-form" action="./IncomeServlet" method="post" style="padding-left:inherit;">
        <input type="hidden" value="add" name="operationType">
        <input type="hidden" value="<%=user.getUserId()%>" name="userId">
        <!-- date added in backend -->
        <h3> Add New Income</h3>
        <br>
        <label for="select-category">Category: </label>
        <br>
        <!--incense category drop down-->
        <select name="catId" class="select-category">
          <!--add categorydao with user-category for incenses. for now -->
          <option value="Salary(Monthly)"> Salary(monthly)</option>
          <option value="Wages(weekly)"> Wages(weekly)</option>
          <option value="Family allowance"> Family allowance</option>
          <option value="Sale of possession">Sale of possession</option>
          <option value="Dividend/profit received"> Dividends/profit received</option>
          <option value="Interest from loan or Fixed Deposit"> Interest from loan or Fixed Deposit</option>
          <option value="Other Incomes"> Other Incomes</option>
        </select>
        <br>        

        <label for="inc-name">Income source:</label>
        <small id="inc-name-error" class="error"></small>
        <br>
        <input type="text" id="inc-name" name="inc-name" placeholder="Title"/>
        <br>
        <label for="inc-name">Description: </label>
        <small id="inc-des-error" class="error"></small>
        <br>
        <input type="text" id="inc-des" name="inc-des" placeholder="Description"/>
        <br>
        <label for="inc-price">Amount: </label>
        <small id="inc-price-error" class="error"></small>
        <br>
        <input type="number" id="inc-price" name="inc-price" placeholder="Amount in numbers" />
        <br>

        <label for="up-select-mode">Mode of Transaction: </label>
        <br>
        <select name="mode" class="select-category">
          <% for(String m: modes){
          %>
          <option value="<%=m%>"><%=m%></option>
          <%}%>
        </select>
        <br>
        <button type="submit" class="submitBtn-inc">Add</button>
      </form>
    </div>
    <script>

      function openUpdatePopup(popup, id) {
        pop = popup + id;
        document.getElementById(pop).style.display = "block";
        dynamicBtnId = id;
      }

      function closeUpdatePopup(popup, id) {
        pop = popup + id;
        document.getElementById(pop).style.display = "none";
      }
      function openPopup(popup) {
        document.getElementById(popup).style.display = "block";
      }

      function closePopup(popup) {
        document.getElementById(popup).style.display = "none";
      }


      //inc from validation input
      const totalIncomeloaded = document.getElementById("totalIncome");
      const totalInc = document.getElementById("totalInc");
      const incForm = document.getElementById("inc-form");
      const incNameInput = document.getElementById("inc-name");
      const incPriceInput = document.getElementById("inc-price");
      const incDesInput = document.getElementById("inc-des");
      const incNameError = document.getElementById("inc-name-error");
      const incPriceError = document.getElementById("inc-price-error");
      const incDesError = document.getElementById("inc-des-error");

      const upincForm = document.getElementById("update-inc-form");
      const delincForm = document.getElementById("del-inc-form");
      const upincNameInput = document.getElementById("up-inc-name");
      const upincPriceInput = document.getElementById("up-inc-price");
      const upincDesInput = document.getElementById("up-inc-des");
      const upincNameError = document.getElementById("up-inc-name-error");
      const upincPriceError = document.getElementById("up-inc-price-error");
      const upincDesError = document.getElementById("up-inc-des-error");


      //category form validation
      document.addEventListener('DOMContentLoaded', function () {
        totalInc.innerHTML = 'Total Income: ' + totalIncomeloaded.textContent;

        upincForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validateText(upincNameInput, upincNameError) && validateText(upincPriceInput, upincPriceError) && validateText(upincDesInput, upincDesError)
                  ) {
            upincForm.submit();
          }
        });

        delincForm.addEventListener("submit", function (event) {
          event.preventDefault();
          window.confirm("Are you sure?");
          delincForm.submit();
        });



        incForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validateText(incNameInput, incNameError) && validateText(incPriceInput, incPriceError) && validateText(incDesInput, incDesError)
                  ) {
            incForm.submit();
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
