<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean class="model.Product" id="my_product">
	<jsp:setProperty name="my_product" property="*"></jsp:setProperty>
</jsp:useBean>
<p>ProductID: ${my_product.product_id }</p>
<p>ProductName: ${my_product.product_name }</p>
<p>Price: ${my_product.price }</p>
<p>Place: ${my_product.place }</p>
</body>
</html>