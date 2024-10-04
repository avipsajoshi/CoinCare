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
    <script src="js/light-dark.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <%@include file="components/nav.jsp"%>
    <div class="main-content">
      <div class="container">
        <h2><a href="./dashboard.jsp"><i class='bx bx-left-arrow-alt'></i> Coin Care</a> / <a href="./statements.jsp">Your Statements</a></h2>
        <h2><%=currentDay%> <%=currentMonth.toString()%>, <%=currentYear%></h2>
      </div>
      <%@include file="components/message.jsp" %>
      <div>
        <div class="summary">
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
          double totalExpenseG = 0;
          double totalIncomeG = 0;
          double totalCalculatedBalanceG = 0;

          //for time specific
          double moneyIn = 0;
          double moneyOut = 0;
          double calculatedBalance = 0;
          UserDao uDao = new UserDao(FactoryProvider.getFactory());
          User thisUser = uDao.getUseByEmail(user.getUserEmail());
          int uId=thisUser.getUserId();
          // Variables to store date parameters
          String startDate = request.getParameter("startDate");
          String endDate = request.getParameter("endDate");
//          out.println(startDate + "<br>");
//          out.println(endDate);
          LocalDate start = LocalDate.now();
          LocalDate end = LocalDate.now();
          if (startDate == null || endDate == null) {
            out.println("<p style='color:red;'>Please select a start date and an end date to generate the statement.</p>");
    }
          if (startDate != null && !startDate.isEmpty()) {
            start = MinorHelper.getStringToDate(startDate);
//            out.println(start + "<br>");
          }
          if (endDate != null && !endDate.isEmpty()) {
            end = MinorHelper.getStringToDate(endDate);
//            out.println(end + "<br>");
          }
          if (start != null && end != null) {
          List<UserFinancials> allGeneratedTransactions = uDao.getUserReportForCustomTime(uId, start, end);
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
            if(!allGeneratedTransactions.isEmpty()){
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

        <%
          totalCalculatedBalanceG = totalIncomeG-totalExpenseG; 
        %>
        <label id="totalExpensesG" style="display:none;"> <%=totalExpenseG%> </label>  
        <label id="totalIncomeG" style="display:none;"> <%=totalIncomeG%> </label>  
        <label id="calculatedBalanceG" style="display:none;"> <%=totalCalculatedBalanceG%> </label>
      </div>
    </div>
    <script>
      //getting the display label for generated
      var totalExpenseGDisplay = document.getElementById("totalExpenseShowGenerated");
      var totalIncomeGDisplay = document.getElementById("totalIncomeShowGenerated");
      var balanceGDisplay = document.getElementById("balanceShowGenerated");

      var ctxG = document.getElementById('doughnutChartG').getContext('2d');
      var ctx2G = document.getElementById('doughnutChart1G').getContext('2d');
      let datasetDataInEx, labelData, datasetData;

      //getting the calculated total amount that is loaded from data GENERATED
      const totalExpenseloadedG = document.getElementById("totalExpensesG");
      const totalIncomeloadedG = document.getElementById("totalIncomeG");
      const calculatedBalanceloadedG = document.getElementById("calculatedBalanceG");

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



      // Function to toggle the table and the visual div
      function toggleTable(tabType, iconElement, visualClass) {
        let table = document.getElementById(tabType + '-table');
        let emptyDiv = document.querySelector('.' + visualClass);
        var ctx = ctxG;
        var ctx2 = ctx2G;
        datasetDataInEx = datasetDataInExG;
        labelData = labelDataG;
        datasetData = datasetDataG;
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

    </script>
  </body>
</html>
