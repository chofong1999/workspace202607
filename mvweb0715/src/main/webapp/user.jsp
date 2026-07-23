<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User JSP</title>
</head>
<body>
<%
   String n=request.getParameter("username");
   session.setAttribute("user", n);
%>
<h1>你是 ${param.username}</h1>
</body>
</html>