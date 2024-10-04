<%-- 
    Document   : budget
    Created on : 28 Jul 2024, 18:11:48
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.util.HashMap" %>
<%@page import="com.coincare.entities.Income" %>
<%@page import="com.coincare.dao.IncomeDao" %>
<%@page import="com.coincare.entities.User" %>
<%@page import="com.coincare.dao.UserDao" %>
<%@page import="com.coincare.entities.BudgetPlan" %>
<%@page import="com.coincare.dao.BudgetPlanDao" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Budget Plans | CoinCare</title>
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
    <link rel="stylesheet" href="css/bp-style.css"/>
  </head>
  <body class="body">
    <script src="js/light-dark.js"></script>
    <%@include file="components/nav.jsp"%>

    <div class="main-content">
      <div class="container">
        <h2><a href="./dashboard.jsp"><i class='bx bx-left-arrow-alt'></i> Coin Care</a> / <a href="./budget.jsp">Your Budget Plans and Limits</a></h2>
      </div>

      <%@include file="components/message.jsp"%>  

      <div class="custom-content">
        <%
        BudgetPlanDao bDao = new BudgetPlanDao(FactoryProvider.getFactory());
        UserDao uDao = new UserDao(FactoryProvider.getFactory());
        User thisUser = uDao.getUseByEmail(user.getUserEmail());
        IncomeDao iDao = new IncomeDao(FactoryProvider.getFactory());
        double totalIncome = iDao.getTotalMontlyIncome(thisUser.getUserId());
        int bpId =thisUser.getSubscribedBudgetPlan().getBudgetPlanId();
        HashMap<String, String> dividedBudget = bDao.getDividedBudget(bpId, totalIncome);
        HashMap<String, String> spentBudget = bDao.getSpent(bpId, totalIncome, thisUser.getUserId());
        %>
        <br>
        <h3>Your Subscribed Budget Plan :  <%=thisUser.getSubscribedBudgetPlan().getBudgetPlanTitle()%></h3> 
        <%=thisUser.getSubscribedBudgetPlan().getBudgetPlanDescription()%>
        <br><br><h3>
          Total Income: <%=totalIncome%></h3>
        <br>
        <div class="budget-container-parent">
          <div class="column">
            <h3>Monthly Budget</h3>
            <br>
            <div class="budgetplan-super-container">
              <div class="budgetplan-container">
                <p>Monthly Expense: <%= spentBudget.get("Monthly Expense Amount")%>/<%= dividedBudget.get("Monthly Expense")%></p>
                <span class="percentage" id="percentage-expense-monthly"></span>
                <p id="expense-monthly" hidden><%= spentBudget.get("Monthly Expense")%></p>
              </div>
              <div class="progress-container">
                <div class="progress-bar">
                  <div class="progress" id="progress-expense-monthly"></div>
                </div>
              </div>
            </div>
            <%
            if (dividedBudget.containsKey("Monthly Wants") && !dividedBudget.get("Monthly Wants").equals("0.00")) {
            %>
            <div class="budgetplan-super-container">
              <div class="budgetplan-container">
                <p>Monthly Wants:  <%= spentBudget.get("Monthly Wants Amount")%>/<%= dividedBudget.get("Monthly Wants")%></p>
                <span class="percentage" id="percentage-wants-monthly"></span>
                <p id="wants-monthly" hidden><%= spentBudget.get("Monthly Wants")%></p>
              </div>
              <div class="progress-container">
                <div class="progress-bar">
                  <div class="progress" id="progress-wants-monthly"></div>
                </div>
              </div>
            </div>
            <%
            }
            %>
            <div class="budgetplan-super-container">
              <div class="budgetplan-container">
                <p>Monthly Savings:  <%= spentBudget.get("Monthly Savings Amount")%>/<%= dividedBudget.get("Monthly Savings")%></p>
                <span class="percentage" id="percentage-savings-monthly"></span>
                <p id="savings-monthly" hidden><%= spentBudget.get("Monthly Savings")%></p>
              </div>
              <div class="progress-container">
                <div class="progress-bar">
                  <div class="progress" id="progress-savings-monthly"></div>
                </div>
              </div>
            </div>
          </div>

          <div class="column">
            <h3>Weekly Budget</h3>
            <br>
            <div class="budgetplan-super-container">
              <div class="budgetplan-container">
                <p>Weekly Expense:  <%= spentBudget.get("Weekly Expense Amount")%>/<%= dividedBudget.get("Weekly Expense")%></p>
                <span class="percentage" id="percentage-expense-weekly"></span>
                <p id="expense-weekly" hidden><%= spentBudget.get("Weekly Expense")%></p>
              </div>
              <div class="progress-container">
                <div class="progress-bar">
                  <div class="progress" id="progress-expense-weekly"></div>
                </div>
              </div>
            </div>
            <%
            if (dividedBudget.containsKey("Weekly Wants") && !dividedBudget.get("Weekly Wants").equals("0.00")) {
            %>

            <div class="budgetplan-super-container">
              <div class="budgetplan-container">
                <p>Weekly Wants:<%= spentBudget.get("Weekly Wants Amount")%>/<%= dividedBudget.get("Weekly Wants")%></p>
                <span class="percentage" id="percentage-wants-weekly"></span>
                <p id="wants-weekly" hidden><%= spentBudget.get("Weekly Wants")%></p>
              </div>
              <div class="progress-container">
                <div class="progress-bar">
                  <div class="progress" id="progress-wants-weekly"></div>
                </div>
              </div>
            </div>
            <%
            }
            %>
            <div class="budgetplan-super-container">
              <div class="budgetplan-container">
                <p>Weekly Savings: <%= spentBudget.get("Weekly Savings Amount")%>/<%= dividedBudget.get("Weekly Savings")%></p>
                <span class="percentage" id="percentage-savings-weekly"></span>
                <p id="savings-weekly" hidden><%= spentBudget.get("Weekly Savings")%></p>
              </div>
              <div class="progress-container">
                <div class="progress-bar">
                  <div class="progress" id="progress-savings-weekly"></div>
                </div>
              </div>
            </div>
          </div>

          <div class="column">
            <h3>Daily Budget</h3>
            <br>
            <div class="budgetplan-super-container">
              <div class="budgetplan-container">
                <p>Daily Expense: <%= spentBudget.get("Daily Expense Amount")%>/<%= dividedBudget.get("Daily Expense")%></p>
                <span class="percentage" id="percentage-expense-daily"></span>
                <p id="expense-daily" hidden><%= spentBudget.get("Daily Expense")%></p>
              </div>
              <div class="progress-container">
                <div class="progress-bar">
                  <div class="progress" id="progress-expense-daily"></div>
                </div>
              </div>
            </div>


            <%
            if (dividedBudget.containsKey("Daily Wants")&& !dividedBudget.get("Daily Wants").equals("0.00")) {
            %>
            <div class="budgetplan-super-container">
              <div class="budgetplan-container">
                <p>Daily Wants: <%= spentBudget.get("Daily Wants Amount")%>/<%= dividedBudget.get("Daily Wants")%></p>
                <span class="percentage" id="percentage-wants-daily"></span>
                <p id="wants-daily" hidden><%= spentBudget.get("Daily Wants")%></p>
              </div>
              <div class="progress-container">
                <div class="progress-bar">
                  <div class="progress" id="progress-wants-daily"></div>
                </div>
              </div>
            </div>
            <%
            }
            %>
            <div class="budgetplan-super-container">
              <div class="budgetplan-container">
                <p>Daily Savings: <%= spentBudget.get("Daily Savings Amount")%>/<%= dividedBudget.get("Daily Savings")%></p>
                <span class="percentage" id="percentage-savings-daily"></span>
                <p id="savings-daily" hidden><%= spentBudget.get("Daily Savings")%></p>
              </div>
              <div class="progress-container">
                <div class="progress-bar">
                  <div class="progress" id="progress-savings-daily"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script>
      const expense_monthly = document.getElementById("expense-monthly").innerText;
      const savings_monthly = document.getElementById("savings-monthly").innerText;

      const expense_weekly = document.getElementById("expense-weekly").innerText;
      const savings_weekly = document.getElementById("savings-weekly").innerText;

      const expense_daily = document.getElementById("expense-daily").innerText;
      const savings_daily = document.getElementById("savings-daily").innerText;




      function progress(percentage, timing) {
        const progress = document.getElementById("progress" + timing);
        const percentageText = document.getElementById("percentage" + timing);

        if (parseFloat(percentage) > 100) {
          progress.style.width = "100" + "%";
          progress.style.backgroundColor = "lightcoral";
          percentageText.textContent = "100" + "%";
        } else {
          progress.style.width = percentage + "%";
          percentageText.textContent = percentage + "%";
        }
      }

      progress(expense_monthly, "-expense-monthly");
      progress(savings_monthly, "-savings-monthly");

      progress(expense_weekly, "-expense-weekly");
      progress(savings_weekly, "-savings-weekly");

      progress(expense_daily, "-expense-daily");
      progress(savings_daily, "-savings-daily");

      if (document.getElementById("wants-monthly").innerText !== null) {
        const wants_monthly = document.getElementById("wants-monthly").innerText;
        const wants_weekly = document.getElementById("wants-weekly").innerText;
        const wants_daily = document.getElementById("wants-daily").innerText;

        progress(wants_monthly, "-wants-monthly");
        progress(wants_weekly, "-wants-weekly");
        progress(wants_daily, "-wants-daily");
      }

    </script>
  </body>
</html>
