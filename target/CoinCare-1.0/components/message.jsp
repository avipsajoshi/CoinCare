<%-- 
    Document   : message
    Created on : 27 Jul 2024, 20:27:55
    Author     : Dell
--%>

<% 
//  String message = (String)session.getAttribute("message");
//  if(message != null){
//    //print message
//    out.println(message);
//    //remove the message from session so that it is rendered only once
//    session.removeAttribute("message");
//  }

String message = (String)session.getAttribute("message");
  if(message != null){
    out.print("<style>#message-container{display:flex; justify-content:space-between; border-bottom: 1px solid var(--action); padding-bottom: 5px; z-index: 1;position:relative; border-bottom}  .close-message-button {cursor: pointer;  }  @media (max-width: 800px) {    .message-container{      height: 30px;      width: min-content;    }  }</style>");
    out.print("<script>function closeMPopup() {"
    + "document.getElementById('message-container').style.display = 'none';");
    session.removeAttribute("message");
    out.print("}</script>");
    out.print("<div id='message-container'>");
    //print message
    out.println(message);
    out.print("<div class='close-message-button' onclick='closeMPopup()'>X</div>");
    out.print("</div>");
    //remove the message from session so that it is rendered only once
    session.removeAttribute("message");
  }
%>