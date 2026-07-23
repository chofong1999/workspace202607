<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 取得表單參數
    String favoriteAnimal = request.getParameter("favoriteAnimal");
    
    // 空值處理
    if (favoriteAnimal == null || favoriteAnimal.trim().isEmpty()) {
        favoriteAnimal = "未知動物";
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>調查結果</title>
</head>
<body>
    <h1>調查結果</h1>
    <p>您最喜歡的動物是：<strong><%= favoriteAnimal %></strong></p>
    <p><a href="favorite.html">返回重新選擇</a></p>
</body>
</html>