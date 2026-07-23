<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserForm JSP</title>
</head>
<body>
<%
   String n=request.getParameter("name");
   String a=request.getParameter("age");
   User u1=new User();
   u1.setName(n);
   u1.setAge(Integer.parseInt(a));
   pageContext.setAttribute("user", u1);
%>
<h2>
<p>姓名：${user.name}</p>
<p>年齡：${user.age}</p>
</h2>
</body>
</html>