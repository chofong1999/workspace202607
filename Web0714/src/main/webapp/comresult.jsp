<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>表單結果</title>
<style>
body {
	font-family: Arial, sans-serif;
	max-width: 500px;
	margin: 40px auto;
}

.result {
	background: #f5f5f5;
	padding: 20px;
	border-radius: 5px;
	margin-bottom: 15px;
}

.label {
	font-weight: bold;
	color: #333;
}

a {
	color: #007bff;
}
</style>
</head>
<body>

<%
int num_1=Integer.parseInt(request.getParameter("num1"));
int num_2=Integer.parseInt(request.getParameter("num2"));
%>
	<h2>數字比較結果</h2>

	<div class="result">
		<p>
			<span class="label">比較結果: </span>
			 ${param.num1}  
			 ${Integer.parseInt(param.num1)>Integer.parseInt(param.num2) ? '>' : 
			 (Integer.parseInt(param.num1)<Integer.parseInt(param.num2) ? '<' : '=')}
			 ${param.num2}
		</p>
		
	</div>
	<div class="result">
		<p>
			<span class="label">${param.num1}和${param.num2}的大小關係：</span>
			 ${Integer.parseInt(param.num1)>Integer.parseInt(param.num2) ? "第一個數字較大" : 
			 (Integer.parseInt(param.num1) < Integer.parseInt(param.num2) ? "第二個數字較大" : "兩者相等")}
		</p>
		
	</div>
	<div class="result">
		<p>
			<span class="label"><%=num_1 %>和<%=num_2 %>的大小關係：</span>
			 <%=num_1>num_2?"第一個數字較大" : (num_1 < num_2 ? "第二個數字較大" : "兩者相等") %>
		<br>
	</div>

	<p>
		<a href="compare.html">返回表單</a>
	</p>
</body>
</html>
