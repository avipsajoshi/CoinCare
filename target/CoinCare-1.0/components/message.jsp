<%-- 
    Document   : message
    Created on : 27 Jul 2024, 20:27:55
    Author     : Dell
--%>

<% 
  String message = (String)session.getAttribute("message");
  if(message != null){
    //print message
    out.println(message);
    //remove the message from session so that it is rendered only once
    session.removeAttribute("message");
  }
%>