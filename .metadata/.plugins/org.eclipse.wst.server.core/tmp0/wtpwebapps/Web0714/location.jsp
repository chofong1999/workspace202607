<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
   String website=request.getParameter("site");
%>
<h1>
   Website is <%=website %>!
</h1>

<h1>
   Website is <% response.sendRedirect(website); %>
</h1>

<h1>
   Website is <%=website %>!
</h1>
</body>
</html>