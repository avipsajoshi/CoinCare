<%-- 
    Document   : explore
    Created on : 28 Jul 2024, 18:12:07
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.coincare.entities.Article" %>
<%@page import="com.coincare.dao.ArticleDao" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Explore | CoinCare</title>

    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
    <style>
      .card {
        background-color: var(--back);
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width: 300px;
        padding: 20px;
      }

      .card img {
        width: 100%;
        border-radius: 8px 8px 0 0;
      }

      .card-title {
        font-size: 1.5em;
        margin: 15px 0;
        color: var(--primary);
      }

      .card-text {
        color: var(--text);
        font-size: 1em;
        margin-bottom: 20px;
      }

      .card-button {
        background-color: var(--btn);
        color: var(--text);
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 5px;
      }

      .card-button:hover {
        background-color: var(--action-alt);
      }
    </style>
  </head>
  <body class="body">
    <script src="js/light-dark.js"></script>
    <%@include file="components/nav.jsp"%>

    <div class="main-content">

      <div class="container">
        <h2><a href="./dashboard.jsp"><i class='bx bx-left-arrow-alt'></i> Coin Care</a> / <a href="./explore.jsp">Explore</a></h2>
      </div>

      <%@include file="components/message.jsp" %>

      <div class="custom-content">
        <%
          ArticleDao aDao = new ArticleDao(FactoryProvider.getFactory());
          List<Article> allArticles = aDao.getArticlesPublished();
          for(Article a : allArticles){
        %>
        <div class="card">
          <h2 class="card-title"><%=a.getArticleTitle()%></h2>
          <p class="card-text"><%= MinorHelper.get20Words(a.getArticleBody()) %></p>
          <a href="./article.jsp?articleId=<%=a.getArticleId()%>" class="card-button">Read More</a>
        </div>
        <%}%>
      </div>
    </div>
  </body>
</html>
