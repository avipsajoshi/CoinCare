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
    <title>Statements</title>
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
    <link rel="stylesheet" href="css/fontAndColors.css"/>
    <link rel="stylesheet" href="css/elementStyles.css"/>
    <link rel="stylesheet" href="css/statement-style.css"/>
  </head>
  <body class="body">
    <script src="js/light-dark.js"></script>
    <%@include file="components/nav.jsp"%>

    <div class="main-content">
      <div class="container">
        <h2><a href="./dashboard.jsp">Coin Care</a>\<a href="./statements.jsp">Your Statements</a></h2>
        <h2><%=currentDay%> <%=currentMonth.toString()%>, <%=currentYear%></h2>
      </div>

      <div class="custom-content">
        <%
          //for overall yearly calculation
          double totalExpense = 0;
          double totalIncome = 0;
          double totalCalculatedBalance = 0;
          
          //for time specific
          double moneyIn = 0;
          double moneyOut = 0;
          double calculatedBalance = 0;
          UserDao uDao = new UserDao(FactoryProvider.getFactory());
          User thisUser = uDao.getUseByEmail(user.getUserEmail());
          int uId=thisUser.getUserId();
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
        <div class="tab-content" id="tab1">
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
          <table class="table">
            <thead>
              <tr>
                <th scope="col">Transaction</th>
                <th scope="col">Remarks</th>
                <th scope="col">For/From</th>
                <th scope="col">Mode</th>
                <th scope="col">Amount</th>
              </tr>
            </thead>
            <tbody>
              <% 
              for(UserFinancials uf: allTransactions){
              %>
              <tr>
                <td scope="row"><%=uf.getTitle()%></td>
                <td><%=uf.getDescription()%></td>
                <td class="dashboard-category"><%=uf.getCategory()%></td>
                <td><%=uf.getMode()%></td>
                <% if (uf.getType().equals("expense")){
              totalExpense+=uf.getAmount();%>
                <td style="color:red;" class="dashboard-exp-amount"> - <%=uf.getAmount()%></td>
                <%}else if (uf.getType().equals("income")){
              totalIncome+=uf.getAmount();%>
                <td style="color:#16c216;"> + <%=uf.getAmount()%></td>
                <%}else{} }%>
              </tr>
            </tbody>
          </table>

          <%}%>
        </div>


        <!--monthly reports-->
        <div class="tab-content" id="tab2">
           <%
//            List<UserFinancials> allMonthlyTransactions = uDao.getUserReportForTheMonth(uId, currentDate);
            List<UserFinancials> allMonthlyTransactions = new ArrayList<>();;
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
          <table class="table">
            <thead>
              <tr>
                <th scope="col">Transaction</th>
                <th scope="col">Remarks</th>
                <th scope="col">For/From</th>
                <th scope="col">Mode</th>
                <th scope="col">Amount</th>
              </tr>
            </thead>
            <tbody>
              <% 
              for(UserFinancials uf: allMonthlyTransactions){
              %>
              <tr>
                <td scope="row"><%=uf.getTitle()%></td>
                <td><%=uf.getDescription()%></td>
                <td class="dashboard-category"><%=uf.getCategory()%></td>
                <td><%=uf.getMode()%></td>
                <% if (uf.getType().equals("expense")){
              totalExpense+=uf.getAmount();%>
                <td style="color:red;" class="dashboard-exp-amount"> - <%=uf.getAmount()%></td>
                <%}else if (uf.getType().equals("income")){
              totalIncome+=uf.getAmount();%>
                <td style="color:#16c216;"> + <%=uf.getAmount()%></td>
                <%}else{} }%>
              </tr>
            </tbody>
          </table>

          <%}%>
        </div>


        <!--yearly reports-->
        <div class="tab-content" id="tab3">
           <%
            //List<UserFinancials> allYearlyTransactions = uDao.getUserReportForTheYear(uId, currentDate);
            List<UserFinancials> allYearlyTransactions = new ArrayList<>();;
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
          <table class="table">
            <thead>
              <tr>
                <th scope="col">Transaction</th>
                <th scope="col">Remarks</th>
                <th scope="col">For/From</th>
                <th scope="col">Mode</th>
                <th scope="col">Amount</th>
              </tr>
            </thead>
            <tbody>
              <% 
              for(UserFinancials uf: allYearlyTransactions){
              %>
              <tr>
                <td scope="row"><%=uf.getTitle()%></td>
                <td><%=uf.getDescription()%></td>
                <td class="dashboard-category"><%=uf.getCategory()%></td>
                <td><%=uf.getMode()%></td>
                <% if (uf.getType().equals("expense")){
              totalExpense+=uf.getAmount();%>
                <td style="color:red;" class="dashboard-exp-amount"> - <%=uf.getAmount()%></td>
                <%}else if (uf.getType().equals("income")){
              totalIncome+=uf.getAmount();%>
                <td style="color:#16c216;"> + <%=uf.getAmount()%></td>
                <%}else{} }%>
              </tr>
            </tbody>
          </table>

          <%}%>
        </div>


        <!--generated reports-->
        <div class="tab-content" id="tab4">
          <p>Generated reports</p>
        </div>


      </div>
    </div>



    <script>
      //for entire page
      document.addEventListener("DOMContentLoaded", function () {
        // Get all tab links and tab content elements
        const tabLinks = document.querySelectorAll(".tab-link");
        const tabContents = document.querySelectorAll(".tab-content");

        tabLinks.forEach((link) => {
          link.addEventListener("click", function () {
            // Remove active class from all tab links and contents
            tabLinks.forEach((item) => item.classList.remove("active"));
            tabContents.forEach((content) =>
              content.classList.remove("active")
            );

            // Add active class to the clicked tab link
            this.classList.add("active");

            // Show the corresponding tab content
            const target = this.getAttribute("data-target");
            document.getElementById(target).classList.add("active");
          });
        });
      });

    </script>
  </body>
</html>
