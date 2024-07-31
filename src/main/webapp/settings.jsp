<%-- 
    Document   : settings
    Created on : 28 Jul 2024, 18:12:25
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Settings</title>
    <link rel="stylesheet" href="css/fontAndColors.css"/>
    <link rel="stylesheet" href="css/elementStyles.css"/>
  </head>
  <body class="body">
    <script src="js/light-dark.js"></script>
    <%@include file="components/nav.jsp"%>

    <div class="main-content">
      <div class="container">
        <h1>Coin Care</h1>
      </div>

      <div class="custom-content">
        <div class="collapse-container">
          <div class="collapsible">
            <button class="collapsible-button">Edit Profile</button>
            <div class="collapse-content">
              <form action="">
                <input type="text" placeholder="budgetplan">
                <button type="submit">Change</button>
              </form>
            </div>
          </div>
          <div class="collapsible">
            <button class="collapsible-button">Edit Budget Plan</button>
            <div class="collapse-content">
              <p>Your Budget Plan: </p>
              <p>Budget Plan Description</p>
            </div>
          </div>
          <div class="collapsible">
            <button class="collapsible-button">Customize Categories</button>
            <div class="collapse-content">
              <p>Your Categories</p>
              <ul>
                <li>Category 1</li>
                <li>Category 2</li>
                <li>Category 3</li>
              </ul>
            </div>
          </div>
          <div class="collapsible">
            <button class="collapsible-button">Email Preferences</button>
            <div class="collapse-content">
              <p>Statement Notifications</p>
              <p>Advice Notifications</p>
            </div>
          </div>
        </div>
        <script>
          document.querySelectorAll('.collapsible-button').forEach(button => {
            button.addEventListener('click', () => {
              const content = button.nextElementSibling;

              // Toggle between hiding and showing the content
              if (content.style.display === 'block') {
                content.style.display = 'none';
              } else {
                content.style.display = 'block';
              }
            });
          });

        </script>
      </div>
  </body>
</html>
