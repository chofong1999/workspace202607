<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>
Price : ${param.price} <br/>
Quantity : ${param.qty} <br/>
Total : ${param.price * param.qty} <br/>

Compare : ${param.price}  
			 ${param.price>param.qty ? '>' : (param.price<param.qty ? '<' : '=')}
			 ${param.qty}

</h2>
</body>
</html>