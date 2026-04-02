<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm");
    String formattedNow = now.format(formatter);
%>
<html>
<head><title>Test</title></head>
<body>
<h1>Test Page</h1>
<p>Current time: <%= formattedNow %></p>
<p>JSP is working!</p>
</body>
</html>