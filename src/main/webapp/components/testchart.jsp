<%-- 
    Document   : testchart
    Created on : 23 Aug 2024, 10:55:58
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<div class="chart-container">
  <div class="chart">
    <canvas id="doughnutChart1"></canvas>
  </div>  
  <div class="chart">
    <canvas id="doughnutChart"></canvas>
  </div>
</div>
<script>
  var ctx = document.getElementById('doughnutChart').getContext('2d');
  var ctx2 = document.getElementById('doughnutChart1').getContext('2d');
//  var labeldata = ['Category1', 'Category2', 'Category3', 'Category4', 'Category5'];
//  var datasetData = [300, 50, 100, 75, 25];
  var labelString = 'Spent %';
//      var colorData = [getRandomColor(100), getRandomColor(100), getRandomColor(100), getRandomColor(100), getRandomColor(100)];
  const colorData = ['#4ECDC4', '#15A79D', '#64C3E2', '#00FFEE', '#8ADDD8', "#004D4B",
    "#003E3E", "#A7E1DB", "#B8E9E4", "#C8F2ED", "#D4F6F4", "#E1F8F7", "#D1E3E0", "#B7DBD6",
    "#A4D4D0", "#91C6C3", "#7EB1B0", "#6BA8A7", "#57A2A1", "#45A49D"];

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

</script>