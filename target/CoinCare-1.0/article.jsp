
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.coincare.entities.Article" %>
<%@page import="com.coincare.dao.ArticleDao" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
    <%
      int articleId = Integer.parseInt(request.getParameter("articleId"));
      ArticleDao aDao = new ArticleDao(FactoryProvider.getFactory());
      Article article = aDao.getArticleById(articleId);%>
    <title><%=article.getArticleTitle()%></title>
    <style>
      #articleHeading {
        border: 1px solid #ccc;
        padding: 10px;
        min-height: 40px;
        margin-bottom: 10px;
      }
      #articleBody {
        border: 1px solid #ccc;
        padding: 10px;
        min-height: 200px;
        margin-bottom: 10px;
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
        <div id="articleHeading"><h1><%=article.getArticleTitle()%></h1></div>
        <div id="articleBody"><%=article.getArticleBody()%></div>
      </div>
  </body>
</html>
