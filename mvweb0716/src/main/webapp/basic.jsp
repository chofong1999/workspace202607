<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>1. 建立 Bean 並手動設定屬性</h2>
        <jsp:useBean id="user1" class="model.User" />
        <jsp:setProperty name="user1" property="name" value="張小明" />
        <jsp:setProperty name="user1" property="age" value="25" />
        <jsp:setProperty name="user1" property="email" value="ming@example.com" />
        <jsp:setProperty name="user1" property="active" value="false" />
    <h2>
       Status : ${user1.status}<br/>
       Greeting : ${user1.greeting}
    </h2>
</body>
</html>