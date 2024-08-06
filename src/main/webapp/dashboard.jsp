<%-- 
    Document   : dashboard
    Created on : 27 Jul 2024, 20:10:45
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.coincare.entities.Expense" %>
<%@page import="com.coincare.dao.ExpenseDao" %>
<%@page import="com.coincare.entities.User" %>
<%@page import="com.coincare.dao.UserDao" %>

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
      function openPopup(popup) {
        document.getElementById(popup).style.display = "block";
      }

      function closePopup(popup) {
        document.getElementById(popup).style.display = "none";
      }
    </script>
  </head>
  <body class="body">
    <script src="js/light-dark.js"></script>
    <%@include file="components/nav.jsp"%>

    <div class="main-content">
      <div class="container">
        <h1>Coin Care</h1>
      </div>
      <div class="container">
        <h2>Your Transactions for the Day</h2>
      </div>

      <div class="custom-content">
        <table class="table">
          <thead>
            <tr>
              <th scope="col">Topic</th>
              <th scope="col">Remarks</th>
              <th scope="col">Amount</th>
              <th scope="col">Category</th>
              <th scope="col">Actions</th>
            </tr>
          </thead>
          <tbody>
            <% ExpenseDao eDao = new ExpenseDao(FactoryProvider.getFactory());
            UserDao uDao = new UserDao(FactoryProvider.getFactory());
            User thisUser = uDao.getUseByEmail(user.getUserEmail());
            int uId=thisUser.getUserId();
            List<Expense> allExpenses = eDao.getExpenseByUserId(uId);
            for(Expense e : allExpenses){ %>
            <tr>
              <td scope="row"><%=e.getExpenseTitle()%></td>
              <td><%=e.getExpenseRemarks()%></td>
              <td><%=e.getExpenseAmount()%></td>
              <td><%=(e.getCategory() != null ? e.getCategory().getCategoryTitle() : "No Category") %></td>
              <td><button type="button" class="btn action-btn">Edit</button></td>
            </tr>
            <%}%>
          </tbody>
        </table>

        <div class="summary">
          <label>Total expense</label>
        </div>
      </div>
    </div>

    <button class="add-button" id="dashboard-add-button" onclick="openPopup(pop_p)">+</button>
    <div id="popup-exp" class="popup-container">
      <div class="close-button" onclick="closePopup(pop_p)">X</div>
      <form id="exp-form" action="./ExpenseServlet" method="post" style="padding-left:inherit;">
        <input type="hidden" value="add" name="operationType">
        <input type="hidden" value="<%=user.getUserId()%>" name="userId">
        <!<!-- date added in backend -->
        <h3> Add New Expense</h3>
        <br>
        <label for="exp-name">What was the Expense on? </label>
        <small id="exp-name-error" class="error"></small>
        <br>
        <input type="text" id="exp-name" name="exp-name" />
        <br>
        <label for="exp-description">Additional Remarks: </label>
        <small id="exp-description-error" class="error"></small>
        <br>
        <textarea id="exp-description" class="exp-textarea" name="exp-description"></textarea>
        <br>
        <label for="exp-price">Amount: </label>
        <small id="exp-price-error" class="error"></small>
        <br>
        <input type="number" id="exp-price" name="exp-price" />

        <br>
        <label for="select-category">Category: </label>
        <br>
        <!--expense category drop down-->

        <select name="catId" class="select-category">
          <!--add categorydao with user-category for expenses. for now -->
          <option value="1"> Rent </option>
        </select>
        <button type="submit" class="submitBtn-exp">Add</button>
      </form>
    </div>
    <script>
      //exp from validation input
      const expNameInput = document.getElementById("exp-name");
      const expDescriptionInput = document.getElementById("exp-description");
      const expPriceInput = document.getElementById("exp-price");
      const expNameError = document.getElementById("exp-name-error");
      const expDescriptionError = document.getElementById("exp-description-error");
      const expPriceError = document.getElementById("exp-price-error");


//category form validation
      document.addEventListener('DOMContentLoaded', function () {
        expForm.addEventListener("submit", function (event) {
          event.preventDefault();
          if (
                  validateText(expNameInput, expNameError) && validateText(expDescriptionInput, expDescriptionError) && validateText(expPriceInput, expPriceError) && validateText(expQuantityInput, expQuantityError) && validateText(expDiscountInput, expDiscountError)
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
