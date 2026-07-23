<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>我的 Web 應用程式</title>
</head>
<body>
    <h1>歡迎來到我的 Web 應用程式</h1>
    <p>使用 Eclipse + Maven + Tomcat 10.1 建立</p>
    
    <form action="hello" method="get">
        <label>請輸入姓名：</label>
        <input type="text" name="name" placeholder="輸入姓名">
        <button type="submit">送出</button>
    </form>
</body>
</html>