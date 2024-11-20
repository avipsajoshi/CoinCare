<%-- 
    Document   : statements
    Created on : 28 Jul 2024, 18:11:43
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList" %>
<%@page import="com.coincare.entities.UserFinancials" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your Statements | CoinCare</title>
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
    <link rel="stylesheet" href="css/fontAndColors.css"/>
    <link rel="stylesheet" href="css/elementStyles.css"/>
    <link rel="stylesheet" href="css/statement-style.css"/>
  </head>

  <body class="body">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="js/light-dark.js"></script>
    <%@include file="components/nav.jsp"%>
    <%
    UserDao uDao = new UserDao(FactoryProvider.getFactory());
    User thisUser = uDao.getUseByEmail(user.getUserEmail());
    int uId=thisUser.getUserId();
  
    %>  
    <div class="main-content">
      <div class="container">
        <h2><a href="./dashboard.jsp"><i class='bx bx-left-arrow-alt'></i> Coin Care</a> / <a href="./statements.jsp">Your Statements</a></h2>
        <h2><%=currentDay%> <%=currentMonth.toString()%>, <%=currentYear%></h2>
      </div>
      <%@include file="components/message.jsp" %>
      <div>
        <div class="summary">
          <div class="summary-summary" id="weekly-summary">
            <div>
              <label id="totalIncomeShowWeekly">Total Income: 0.0</label>
              <br>
              <label id="totalExpenseShowWeekly">Total Expense: 0.0</label>
              <br>
              <label id="balanceShowWeekly">Balance: 0.0</label>
            </div>
            <div class="export-data">
              <!--              <div class="pdf">
                              <i class='bx bxs-file-pdf' ></i>
                            </div>-->
              <div class="csv">
                <i class='bx bxs-file-export' onclick="getreport('<%=uId%>', 'weekly');"></i>
              </div>
            </div>
          </div>
          <div class="summary-summary" id="monthly-summary" style="display: none;">
            <div>
              <label id="totalIncomeShowMonthly">Total Income: 0.0</label>
              <br>
              <label id="totalExpenseShowMonthly">Total Expense: 0.0</label>
              <br>
              <label id="balanceShowMonthly">Balance: 0.0</label>
            </div>
            <div class="export-data">
              <!--              <div class="pdf">
                              <i class='bx bxs-file-pdf' ></i>
                            </div>-->
              <div class="csv">
                <i class='bx bxs-file-export' onclick="getreport('<%=uId%>', 'monthly');"></i>
              </div>
            </div>
          </div>
          <div class="summary-summary" id="yearly-summary" style="display: none;">
            <div>
              <label id="totalIncomeShowYearly">Total Income: 0.0</label>
              <br>
              <label id="totalExpenseShowYearly">Total Expense: 0.0</label>
              <br>
              <label id="balanceShowYearly">Balance: 0.0</label>
            </div>
            <div class="export-data">
              <!--              <div class="pdf">
                              <i class='bx bxs-file-pdf' ></i>
                            </div>-->
              <div class="csv">
                <i class='bx bxs-file-export' onclick="getreport('<%=uId%>', 'yearly');"></i>
              </div>
            </div>
          </div>
          <div id="generated-summary" style="display: none;">
            <div>
              <label id="totalIncomeShowGenerated">Total Income: 0.0</label>
              <br>
              <label id="totalExpenseShowGenerated">Total Expense: 0.0</label>
              <br>
              <label id="balanceShowGenerated">Balance: 0.0</label>
            </div>
          </div>
        </div>
      </div>

      <div class="custom-content">
        <%
          
          double totalExpenseW = 0;
          double totalIncomeW = 0;
          double totalCalculatedBalanceW = 0;
          
          double totalExpenseM = 0;
          double totalIncomeM = 0;
          double totalCalculatedBalanceM = 0;
          
          double totalExpenseY = 0;
          double totalIncomeY = 0;
          double totalCalculatedBalanceY = 0;
         
          
          double totalExpenseG = 0;
          double totalIncomeG = 0;
          double totalCalculatedBalanceG = 0;
          
          //for time specific
          double moneyIn = 0;
          double moneyOut = 0;
          double calculatedBalance = 0;
          
        %>
        <div class="tab-container">
          <div class="tab-nav">
            <button class="tab-link active" data-target="tab1">Weekly</button>
            <button class="tab-link" data-target="tab2">Monthly</button>
            <button class="tab-link" data-target="tab3">Yearly</button>
            <button class="tab-link" data-target="tab4">Generate</button>
          </div>
        </div>


        <!--weekly reports-->
        <div class="tab-content active" id="tab1">
          <%
            List<UserFinancials> allTransactions = uDao.getUserReportForTheWeek(uId, currentDate);
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
          <table class="table" id="weekly-table">
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
                <td class="weekly-category"><%=uf.getCategory()%></td>
                <td><%=uf.getMode()%></td>
                <% if (uf.getType().equals("expense")){
              totalExpenseW+=uf.getAmount();%>
                <td style="color:red;" class="weekly-exp-amount"> - <%=uf.getAmount()%></td>
                <%}else if (uf.getType().equals("income")){
              totalIncomeW+=uf.getAmount();%>
                <td style="color:#16c216;"> + <%=uf.getAmount()%></td>
                <%}else{} }%>
              </tr>
            </tbody>
          </table>

          <%}%>
          <!-- Empty div for weekly visual -->
          <div class="weekly-visual chart-container hidden" >

            <div class="chart">
              <canvas id="doughnutChart1W"></canvas>
            </div>  
            <div class="chart">
              <canvas id="doughnutChartW"></canvas>
            </div>
          </div>
          <i class='bx bxs-bar-chart-alt-2 visuals-button' id="report-weekly" onclick="toggleTable('weekly', this, 'weekly-visual')"></i>

          <%totalCalculatedBalanceW = totalIncomeW-totalExpenseW; %>
          <label id="totalExpensesW" style="display:none;"> <%=totalExpenseW%> </label>  
          <label id="totalIncomeW" style="display:none;"> <%=totalIncomeW%> </label>  
          <label id="calculatedBalanceW" style="display:none;"> <%=totalCalculatedBalanceW%> </label>

        </div>


        <!--monthly reports-->
        <div class="tab-content" id="tab2">
          <%
           List<UserFinancials> allMonthlyTransactions = uDao.getUserReportForTheMonth(uId, currentDate);
       if(allMonthlyTransactions.isEmpty()){
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
          <table class="table" id="monthly-table">
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
              for(UserFinancials ufM: allMonthlyTransactions){
              %>
              <tr>
                <td scope="row"><%=MinorHelper.getDateFormatted(ufM.getDate())%></td>
                <td scope="row"><%=ufM.getTitle()%></td>
                <td><%=ufM.getDescription()%></td>
                <td class="monthly-category"><%=ufM.getCategory()%></td>
                <td><%=ufM.getMode()%></td>
                <% if (ufM.getType().equals("expense")){
              totalExpenseM+=ufM.getAmount();%>
                <td style="color:red;" class="monthly-exp-amount"> - <%=ufM.getAmount()%></td>
                <%}else if (ufM.getType().equals("income")){
              totalIncomeM+=ufM.getAmount();%>
                <td style="color:#16c216;"> + <%=ufM.getAmount()%></td>
                <%}else{} }%>
              </tr>
            </tbody>
          </table>

          <%}%>
          <!-- Empty div for monthly visual reports -->
          <div class="monthly-visual chart-container hidden" >
            <div class="chart">
              <canvas id="doughnutChart1M"></canvas>
            </div>  
            <div class="chart">
              <canvas id="doughnutChartM"></canvas>
            </div>
          </div>
          <i class='bx bxs-bar-chart-alt-2 visuals-button' id="report-monthly" onclick="toggleTable('monthly', this, 'monthly-visual')"></i>


          <%totalCalculatedBalanceM = totalIncomeM-totalExpenseM; %>
          <label id="totalExpensesM" style="display:none;"> <%=totalExpenseM%> </label>  
          <label id="totalIncomeM" style="display:none;"> <%=totalIncomeM%> </label>  
          <label id="calculatedBalanceM" style="display:none;"> <%=totalCalculatedBalanceM%> </label>
        </div>


        <!--yearly reports-->
        <div class="tab-content" id="tab3">
          <%
           List<UserFinancials> allYearlyTransactions = uDao.getUserReportForTheYear(uId, currentDate);
       if(allYearlyTransactions.isEmpty()){
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
          <table class="table" id="yearly-table">
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
              for(UserFinancials ufY: allYearlyTransactions){
              %>
              <tr>
                <td scope="row"><%=MinorHelper.getDateFormatted(ufY.getDate())%></td>
                <td scope="row"><%=ufY.getTitle()%></td>
                <td><%=ufY.getDescription()%></td>
                <td class="yearly-category"><%=ufY.getCategory()%></td>
                <td><%=ufY.getMode()%></td>
                <% if (ufY.getType().equals("expense")){
              totalExpenseY+=ufY.getAmount();%>
                <td style="color:red;" class="yearly-exp-amount"> - <%=ufY.getAmount()%></td>
                <%}else if (ufY.getType().equals("income")){
              totalIncomeY+=ufY.getAmount();%>
                <td style="color:#16c216;"> + <%=ufY.getAmount()%></td>
                <%}else{} }%>
              </tr>
            </tbody>
          </table>

          <%}%>
          <!-- Empty div for yearly visual reports -->
          <div class="yearly-visual chart-container hidden" >

            <div class="chart">
              <canvas id="doughnutChart1Y"></canvas>
            </div>  
            <div class="chart">
              <canvas id="doughnutChartY"></canvas>
            </div>
          </div>
          <i class='bx bxs-bar-chart-alt-2 visuals-button' id="report-yearly" onclick="toggleTable('yearly', this, 'yearly-visual')"></i>


          <%totalCalculatedBalanceY = totalIncomeY-totalExpenseY; %>
          <label id="totalExpensesY" style="display:none;"> <%=totalExpenseY%> </label>  
          <label id="totalIncomeY" style="display:none;"> <%=totalIncomeY%> </label>  
          <label id="calculatedBalanceY" style="display:none;"> <%=totalCalculatedBalanceY%> </label>          
        </div>


        <!--generated reports-->
        <div class="tab-content" id="tab4"><center>
            <form id="dateForm" action="generate-statement.jsp">
              <small id="date-error" class="error"></small><br>
              <label for="startDate">Start Date:</label>
              <input type="date" id="startDate" name="startDate" required min="2024-07-01" max="">
              <br>
              <label for="endDate">End Date:</label>
              <input type="date" id="endDate" name="endDate" required min="2024-01-01" max="">
              <br>
              <button type="submit">Get Statement</button>
            </form>
          </center>

          <script>
            // Get today's date
            const today = new Date();
            const formattedDate = today.toISOString().split('T')[0]; // Format YYYY-MM-DD

            // Set the max attribute to today's date
            document.getElementById('startDate').setAttribute('max', formattedDate);
            document.getElementById('endDate').setAttribute('max', formattedDate);
          </script>

          <%
            // Variables to store date parameters
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            LocalDate start = null;
            LocalDate end = null;
            if (startDate != null && !startDate.isEmpty()) {
            start = MinorHelper.getStringToDate(startDate);
            }
            if (endDate != null && !endDate.isEmpty()) {
                end = MinorHelper.getStringToDate(endDate);
            }
            if (start != null && end != null) {
            List<UserFinancials> allGeneratedTransactions = uDao.getUserReportForCustomTime(uId, start, end);
            if(!allGeneratedTransactions.isEmpty()){
          %>
          <table class="table" id="generated-table">
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
              for(UserFinancials ufG: allGeneratedTransactions){
              %>
              <tr>
                <td scope="row"><%=MinorHelper.getDateFormatted(ufG.getDate())%></td>
                <td scope="row"><%=ufG.getTitle()%></td>
                <td><%=ufG.getDescription()%></td>
                <td class="yearly-category"><%=ufG.getCategory()%></td>
                <td><%=ufG.getMode()%></td>
                <% if (ufG.getType().equals("expense")){
              totalExpenseG+=ufG.getAmount();%>
                <td style="color:red;" class="generated-exp-amount"> - <%=ufG.getAmount()%></td>
                <%}else if (ufG.getType().equals("income")){
              totalIncomeG+=ufG.getAmount();%>
                <td style="color:#16c216;"> + <%=ufG.getAmount()%></td>
                <%}else{} }%>
              </tr>
            </tbody>
          </table>
          <%}}%>
          <!-- Empty div for generated visual reports -->
          <div class="generated-visual chart-container hidden" >
            <div class="chart">
              <canvas id="doughnutChart1G"></canvas>
            </div>  
            <div class="chart">
              <canvas id="doughnutChartG"></canvas>
            </div>
          </div>
          <i class='bx bxs-bar-chart-alt-2 visuals-button' id="report-generated" onclick="toggleTable('generated', this, 'generated-visual')"></i>

          <%totalCalculatedBalanceG = totalIncomeG-totalExpenseG; %>
          <label id="totalExpensesG" style="display:none;"> <%=totalExpenseG%> </label>  
          <label id="totalIncomeG" style="display:none;"> <%=totalIncomeG%> </label>  
          <label id="calculatedBalanceG" style="display:none;"> <%=totalCalculatedBalanceG%> </label>
        </div>


      </div>
    </div>

    <script>
      //for amount content loading
      //getting the dispay label for weekly
      var totalExpenseWDisplay = document.getElementById("totalExpenseShowWeekly");
      var totalIncomeWDisplay = document.getElementById("totalIncomeShowWeekly");
      var balanceWDisplay = document.getElementById("balanceShowWeekly");


      //getting the dispay label for monthly
      var totalExpenseMDisplay = document.getElementById("totalExpenseShowMonthly");
      var totalIncomeMDisplay = document.getElementById("totalIncomeShowMonthly");
      var balanceMDisplay = document.getElementById("balanceShowMonthly");


      //getting the display label for yearly
      var totalExpenseYDisplay = document.getElementById("totalExpenseShowYearly");
      var totalIncomeYDisplay = document.getElementById("totalIncomeShowYearly");
      var balanceYDisplay = document.getElementById("balanceShowYearly");

      //getting the display label for generated
      var totalExpenseGDisplay = document.getElementById("totalExpenseShowGenerated");
      var totalIncomeGDisplay = document.getElementById("totalIncomeShowGenerated");
      var balanceGDisplay = document.getElementById("balanceShowGenerated");


      //getting the calculated total amount that is loaded from data weekly
      const totalExpenseloadedW = document.getElementById("totalExpensesW");
      const totalIncomeloadedW = document.getElementById("totalIncomeW");
      const calculatedBalanceloadedW = document.getElementById("calculatedBalanceW");
      //getting the calculated total amount that is loaded from data monthly
      const totalExpenseloadedM = document.getElementById("totalExpensesM");
      const totalIncomeloadedM = document.getElementById("totalIncomeM");
      const calculatedBalanceloadedM = document.getElementById("calculatedBalanceM");
      //getting the calculated total amount that is loaded from data yearly
      const totalExpenseloadedY = document.getElementById("totalExpensesY");
      const totalIncomeloadedY = document.getElementById("totalIncomeY");
      const calculatedBalanceloadedY = document.getElementById("calculatedBalanceY");
      //getting the calculated total amount that is loaded from data GENERATED
      const totalExpenseloadedG = document.getElementById("totalExpensesG");
      const totalIncomeloadedG = document.getElementById("totalIncomeG");
      const calculatedBalanceloadedG = document.getElementById("calculatedBalanceG");

      //for charts
      var ctxW = document.getElementById('doughnutChartW').getContext('2d');
      var ctx2W = document.getElementById('doughnutChart1W').getContext('2d');

      var ctxM = document.getElementById('doughnutChartM').getContext('2d');
      var ctx2M = document.getElementById('doughnutChart1M').getContext('2d');


      var ctxY = document.getElementById('doughnutChartY').getContext('2d');
      var ctx2Y = document.getElementById('doughnutChart1Y').getContext('2d');

      var ctxG = document.getElementById('doughnutChartG').getContext('2d');
      var ctx2G = document.getElementById('doughnutChart1G').getContext('2d');
      let datasetDataInEx, labelData, datasetData;





      //display income/expenses WEEKLY
      totalExpenseWDisplay.innerHTML = 'Total Expense: ' + totalExpenseloadedW.textContent;
      totalIncomeWDisplay.innerHTML = 'Total Income: ' + totalIncomeloadedW.textContent;
      balanceWDisplay.innerHTML = 'Balance: ' + calculatedBalanceloadedW.textContent;
      var datasetDataInExW = [totalIncomeloadedW.textContent, totalExpenseloadedW.textContent];
      // Step 1 & 2: Get all amounts and corresponding categories
      const amountsWeekly = document.querySelectorAll('td.weekly-exp-amount');
      const datasetDataW = []; // a. Array to store added amounts per category
      const labelDataW = []; // b. Array to store category labels
      const categoryTotalsW = {}; // Object to store total amounts per category
      const totalExpenseAmountWeekly = parseFloat(totalExpenseloadedW.textContent);
      console.log('Amount weekly elements found:', amountsWeekly.length);
      amountsWeekly.forEach(amountCell => {
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
          if (categoryTotalsW[category]) {
            categoryTotalsW[category] += amount;
          } else {
            categoryTotalsW[category] = amount;
          }
        } else {
          console.error('Invalid amount found:', amountCell.textContent);
        }
      });
      console.log('Total Expense  weekly Loaded:', totalExpenseAmountWeekly);
      // Step 3: Add amounts under a category and multiply by 100/totalExpense
      for (const category in categoryTotalsW) {
        const categoryAmount = categoryTotalsW[category];
        const percentage = (categoryAmount * 100) / totalExpenseAmountWeekly;
        // Step 5: Push data to the arrays
        datasetDataW.push(percentage.toFixed(2));
        labelDataW.push(category);
      }

      // Check the results
      console.log('Categories:', labelDataW);
      console.log('Dataset (percentages):', datasetDataW);





      //display income/expenses MONTHLY
      totalExpenseMDisplay.innerHTML = 'Total Expense: ' + totalExpenseloadedM.textContent;
      totalIncomeMDisplay.innerHTML = 'Total Income: ' + totalIncomeloadedM.textContent;
      balanceMDisplay.innerHTML = 'Balance: ' + calculatedBalanceloadedM.textContent;
      var datasetDataInExM = [totalIncomeloadedM.textContent, totalExpenseloadedM.textContent];
      // Step 1 & 2: Get all amounts and corresponding categories
      const amountsMonthly = document.querySelectorAll('td.monthly-exp-amount');
      const datasetDataM = []; // a. Array to store added amounts per category
      const labelDataM = []; // b. Array to store category labels
      const categoryTotalsM = {}; // Object to store total amounts per category
      const totalExpenseAmountMonthly = parseFloat(totalExpenseloadedM.textContent);
      console.log('Amount monthly elements found:', amountsMonthly.length);
      amountsMonthly.forEach(amountCell => {
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
          if (categoryTotalsM[category]) {
            categoryTotalsM[category] += amount;
          } else {
            categoryTotalsM[category] = amount;
          }
        } else {
          console.error('Invalid amount found:', amountCell.textContent);
        }
      });
      console.log('Total Expense  monthly Loaded:', totalExpenseAmountMonthly);
      // Step 3: Add amounts under a category and multiply by 100/totalExpense
      for (const category in categoryTotalsM) {
        const categoryAmount = categoryTotalsM[category];
        const percentage = (categoryAmount * 100) / totalExpenseAmountMonthly;
        // Step 5: Push data to the arrays
        datasetDataM.push(percentage.toFixed(2));
        labelDataM.push(category);
      }

      // Check the results
      console.log('Categories:', labelDataM);
      console.log('Dataset (percentages):', datasetDataM);


      //display income/expenses YEARLY
      totalExpenseYDisplay.innerHTML = 'Total Expense: ' + totalExpenseloadedY.textContent;
      totalIncomeYDisplay.innerHTML = 'Total Income: ' + totalIncomeloadedY.textContent;
      balanceYDisplay.innerHTML = 'Balance: ' + calculatedBalanceloadedY.textContent;
      var datasetDataInExY = [totalIncomeloadedY.textContent, totalExpenseloadedY.textContent];
      // Step 1 & 2: Get all amounts and corresponding categories
      const amounthsYearly = document.querySelectorAll('td.yearly-exp-amount');
      const datasetDataY = []; // a. Array to store added amounts per category
      const labelDataY = []; // b. Array to store category labels
      const categoryTotalsY = {}; // Object to store total amounts per category
      const totalExpenseAmountYearly = parseFloat(totalExpenseloadedY.textContent);
      console.log('Amount monthly elements found:', amounthsYearly.length);
      amounthsYearly.forEach(amountCell => {
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
          if (categoryTotalsY[category]) {
            categoryTotalsY[category] += amount;
          } else {
            categoryTotalsY[category] = amount;
          }
        } else {
          console.error('Invalid amount found:', amountCell.textContent);
        }
      });
      console.log('Total Expense yearly Loaded:', totalExpenseAmountYearly);
      // Step 3: Add amounts under a category and multiply by 100/totalExpense
      for (const category in categoryTotalsY) {
        const categoryAmount = categoryTotalsY[category];
        const percentage = (categoryAmount * 100) / totalExpenseAmountYearly;
        // Step 5: Push data to the arrays
        datasetDataY.push(percentage.toFixed(2));
        labelDataY.push(category);
      }

      // Check the results
      console.log('Categories:', labelDataY);
      console.log('Dataset (percentages):', datasetDataY);


      //display income/expenses GENERATED
      totalExpenseGDisplay.innerHTML = 'Total Expense: ' + totalExpenseloadedG.textContent;
      totalIncomeGDisplay.innerHTML = 'Total Income: ' + totalIncomeloadedG.textContent;
      balanceGDisplay.innerHTML = 'Balance: ' + calculatedBalanceloadedG.textContent;
      var datasetDataInExG = [totalIncomeloadedG.textContent, totalExpenseloadedG.textContent];
      // Step 1 & 2: Get all amounts and corresponding categories
      const amounthsGenerated = document.querySelectorAll('td.generated-exp-amount');
      const datasetDataG = []; // a. Array to store added amounts per category
      const labelDataG = []; // b. Array to store category labels
      const categoryTotalsG = {}; // Object to store total amounts per category
      const totalExpenseAmountGenerated = parseFloat(totalExpenseloadedG.textContent);
      console.log('Amount generated elements found:', amounthsGenerated.length);
      amounthsGenerated.forEach(amountCell => {
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
          if (categoryTotalsG[category]) {
            categoryTotalsG[category] += amount;
          } else {
            categoryTotalsG[category] = amount;
          }
        } else {
          console.error('Invalid amount found:', amountCell.textContent);
        }
      });
      console.log('Total Expense GENERATED Loaded:', totalExpenseAmountGenerated);
      // Step 3: Add amounts under a category and multiply by 100/totalExpense
      for (const category in categoryTotalsG) {
        const categoryAmount = categoryTotalsG[category];
        const percentage = (categoryAmount * 100) / totalExpenseAmountGenerated;
        // Step 5: Push data to the arrays
        datasetDataG.push(percentage.toFixed(2));
        labelDataG.push(category);
      }

      // Check the results
      console.log('Categories:', labelDataG);
      console.log('Dataset (percentages):', datasetDataG);



      //for entire page
      document.addEventListener("DOMContentLoaded", function () {
        const tabLinks = document.querySelectorAll(".tab-link");
        const tabContents = document.querySelectorAll(".tab-content");
        const summaries = {
          weekly: document.getElementById("weekly-summary"),
          monthly: document.getElementById("monthly-summary"),
          yearly: document.getElementById("yearly-summary"),
          generated: document.getElementById("generated-summary"),
        };
        tabLinks.forEach((link) => {
          link.addEventListener("click", function () {
            tabLinks.forEach((item) => item.classList.remove("active"));
            tabContents.forEach((content) => content.classList.remove("active"));
            // Hide all summary sections
            Object.values(summaries).forEach(summary => summary.style.display = 'none');
            // Add active class to the clicked tab link
            this.classList.add("active");
            // Show the corresponding tab content
            const target = this.getAttribute("data-target");
            //document.getElementById(target).classList.add("active");
            const activeContent = document.getElementById(target);
            activeContent.classList.add("active");
            // Show the corresponding summary based on the active tab
            if (target === 'tab1') {
              summaries.weekly.style.display = 'flex'; // Show weekly summary
            } else if (target === 'tab2') {
              summaries.monthly.style.display = 'flex'; // Show monthly summary
            } else if (target === 'tab3') {
              summaries.yearly.style.display = 'flex'; // Show yearly summary
            } else if (target === 'tab4') {
              summaries.generated.style.display = 'flex'; // Show generated summary
            }

          });
        });
        // Function to toggle the table and the visual div
        function toggleTable(tabType, iconElement, visualClass) {
          let table = document.getElementById(tabType + '-table');
          let emptyDiv = document.querySelector('.' + visualClass);
          var ctx = ctxW;
          var ctx2 = ctx2W;
          if (tabType === "weekly") {
            ctx = ctxW;
            ctx2 = ctx2W;
            datasetDataInEx = datasetDataInExW;
            labelData = labelDataW;
            datasetData = datasetDataW;
          } else if (tabType === "monthly") {
            ctx = ctxM;
            ctx2 = ctx2M;
            datasetDataInEx = datasetDataInExM;
            labelData = labelDataM;
            datasetData = datasetDataM;
          } else if (tabType === "yearly") {
            ctx = ctxY;
            ctx2 = ctx2Y;
            datasetDataInEx = datasetDataInExY;
            labelData = labelDataY;
            datasetData = datasetDataY;
          } else if (tabType === "generated") {
            ctx = ctxG;
            ctx2 = ctx2G;
            datasetDataInEx = datasetDataInExG;
            labelData = labelDataG;
            datasetData = datasetDataG;
          } else {
          }
          // Check if table and emptyDiv are found
          if (!table || !emptyDiv) {
            console.error('Table or empty div not found:', tabType);
            return;
          }
          // If the table is currently displayed, hide it and show the empty div
          if (table.classList.contains('hidden')) {
            // Change icon to bar chart
            iconElement.className = 'bx bxs-bar-chart-alt-2 visuals-button';
            table.classList.remove('hidden');
            emptyDiv.classList.add('hidden');
          } else {
            // Change icon to list
            iconElement.className = 'bx bx-list-ul visuals-button';
            // Hide the table and show the empty div
            table.classList.add('hidden');
            emptyDiv.classList.remove('hidden');
          }

          const colorData = ['#4ECDC4', '#15A79D', '#64C3E2', '#00FFEE', '#8ADDD8', "#004D4B",
            "#003E3E", "#A7E1DB", "#B8E9E4", "#C8F2ED", "#D4F6F4", "#E1F8F7", "#D1E3E0", "#B7DBD6",
            "#A4D4D0", "#91C6C3", "#7EB1B0", "#6BA8A7", "#57A2A1", "#45A49D"];
          var labelString = 'Spent %';
          //for income and expense
          var typeInEx = {
            type: 'doughnut',
            data: {
              label: 'Amount Spent',
              labels: ['Income', 'Expense'],
              datasets: [{
                  label: 'Amount',
                  data: datasetDataInEx,
                  backgroundColor: ['#00FFEE', '#15A79D'],
                  borderWidth: 1
                }]
            },
            options: {
              responsive: true,
              plugins: {
                tooltip: {
                  enabled: true
                }
              }
            }
          };


          var typeDoughnut = {
            type: 'doughnut',
            data: {
              labels: labelData,
              datasets: [{
                  label: labelString,
                  data: datasetData,
                  backgroundColor: colorData
                }]
            },
            options: {
              responsive: true,
              plugins: {
                legend: {
                  position: 'top'
                },
                tooltip: {
                  enabled: true
                }
              }
            }
          };
          var categoryExpenseChart = new Chart(ctx, typeDoughnut);
          var incomeExpenseChart = new Chart(ctx2, typeInEx);
        }
        ;
        // Attach event listeners to each icon
        document.getElementById('report-weekly').addEventListener('click', function () {
          toggleTable('weekly', this, 'weekly-visual');
        });
        document.getElementById('report-monthly').addEventListener('click', function () {
          toggleTable('monthly', this, 'monthly-visual');
        });
        document.getElementById('report-yearly').addEventListener('click', function () {
          toggleTable('yearly', this, 'yearly-visual');
        });
        document.getElementById('report-generated').addEventListener('click', function () {
          toggleTable('generated', this, 'generated-visual');
        });
      });

      function getreport(userId, when) {
        // Prepare the data to be sent
        const params = new URLSearchParams({
          userId: userId,
          time: when
        });

        // Send the request to the servlet
        fetch('./StatementDownloadServlet', {
          method: 'POST', // or 'GET' depending on your servlet's method
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: params
        })
                .then(response => {
                  if (!response.ok) {
                    throw new Error('Network response was not ok');
                  }
                  return response.blob(); // Expecting a file (e.g., PDF)
                })
                .then(blob => {
                  // Create a link element to trigger file download
                  const url = window.URL.createObjectURL(blob);
                  const a = document.createElement('a');
                  a.href = url;
                  a.download = 'statement.csv'; // Change file name as needed
                  document.body.appendChild(a);
                  a.click();
                  a.remove();
                  window.URL.revokeObjectURL(url);
                })
                .catch(error => {
                  console.error('There was a problem with the request:', error);
                });
      }



    </script>

  </body>
</html>
