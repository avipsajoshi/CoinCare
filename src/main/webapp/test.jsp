<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Date Report Submission</title>
</head>
<body>
<%
    // Variables to store date parameters
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
%>

<h1>Get Report</h1>
<form method="post">
    <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" required>
    <br>
    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate" required>
    <br>
    <button type="submit">Submit</button>
</form>

<%
    // Check if dates are received
    if (startDate != null && endDate != null) {
%>
    <h2>Report Summary</h2>
    <p>Start Date: <%= startDate %></p>
    <p>End Date: <%= endDate %></p>
<%
    }
%>
</body>
</html>
