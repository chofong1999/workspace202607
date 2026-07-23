<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create User Bean </title>
</head>
<body>
<jsp:useBean id="userA" class="model.User"></jsp:useBean>
<jsp:setProperty property="name" name="userA" value="${param.name}" />
<jsp:setProperty property="age" name="userA" value="${param.age}" />
<h1>
  User Name :${userA.name}<br/>
  Age: ${userA.age}
</h1>
</body>
</html>