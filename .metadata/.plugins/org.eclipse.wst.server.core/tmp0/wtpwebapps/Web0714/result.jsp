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
	<h2>表單提交結果</h2>

	<div class="result">
		<p>
			<span class="label">姓名：</span>${param.name}</p>
	</div>

	<div class="result">
		<p>
			<span class="label">性別：</span> ${param.gender == 'male' ? '男性' : (param.gender == 'female' ? '女性' : '其他')}
		</p>
	</div>

	<div class="result">
		<p>
			<span class="label">興趣愛好：</span>
			<%
			String[] hobbies = request.getParameterValues("hobbies");
			if (hobbies != null) {
				for (int i = 0; i < hobbies.length; i++) {
					out.print(hobbies[i]);
					// 轉換 value 為中文
					if (i < hobbies.length - 1)
				        out.print("、");
				}
			} else {
				out.print("未選擇");
			}
			%>
		</p>
	</div>

	<div class="result">
		<p>
			<span class="label">付款方式：</span> ${param.payment == 'credit' ? '信用卡' : (param.payment == 'cash' ? '現金' : (param.payment == 'transfer' ? '轉帳' : '未選擇'))}
		</p>
	</div>

	<div class="result">
		<p>
			<span class="label">訂閱通知：</span> ${not empty param.subscribe ? '已訂閱' : '未訂閱'}
		</p>
	</div>
	
	<p>
		<a href="myform.html">返回表單</a>
	</p>
</body>
</html>
