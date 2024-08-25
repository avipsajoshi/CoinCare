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
  function getRandomColor(difference) {
    var base = [78, 205, 196];
    function getRandomShade(baseColor, variance) {
      // Destructure the base color into RGB components
      var [r, g, b] = baseColor;

      // Generate random offsets within the variance range and apply to each color component
      var newR = clamp(r + Math.floor(Math.random() * (2 * variance + 1)) - variance, 0, 255);
      var newG = clamp(g + Math.floor(Math.random() * (2 * variance + 1)) - variance, 0, 255);
      var newB = clamp(b + Math.floor(Math.random() * (2 * variance + 1)) - variance, 0, 255);

      // Convert the new RGB values to a hexadecimal color code
      var shade = "#" + ((1 << 24) + (newR << 16) + (newG << 8) + newB).toString(16).slice(1);

      return shade;
    }

// Helper function to keep the values within the valid range (0-255)
    function clamp(value, min, max) {
      return Math.max(min, Math.min(max, value));
    }
    return getRandomShade(base, difference);
  }

  var ctx = document.getElementById('doughnutChart').getContext('2d');
  var ctx2 = document.getElementById('doughnutChart1').getContext('2d');
//  var labeldata = ['Category1', 'Category2', 'Category3', 'Category4', 'Category5'];
//  var datasetData = [300, 50, 100, 75, 25];
  var labelString = 'Spent %';
//      var colorData = [getRandomColor(100), getRandomColor(100), getRandomColor(100), getRandomColor(100), getRandomColor(100)];
  var colorData = ['#4ECDC4', '#15A79D', '#64C3E2', '#00FFEE', '#8ADDD8'];
  
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