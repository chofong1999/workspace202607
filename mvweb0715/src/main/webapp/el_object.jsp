<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>EL 內建物件練習</title>
    <style>
        body { font-family: "Microsoft JhengHei", Arial; max-width: 800px; margin: 50px auto; padding: 20px; }
        .section { background: #f9f9f9; padding: 15px; margin: 10px 0; border-radius: 5px; }
        h2 { color: #333; border-bottom: 2px solid #3498db; padding-bottom: 5px; }
        .result { color: #27ae60; font-weight: bold; }
    </style>
</head>
<body>
    <h1>EL 內建物件練習</h1>
    
    <!-- 1. param 物件 -->
    <div class="section">
        <h2>1. param 物件（取得 URL 參數）</h2>
        <p>name 參數：<span class="result">${param.name}</span></p>
        <p>age 參數：<span class="result">${param.age}</span></p>
        <form method="get">
            <label>輸入 name：</label>
            <input type="text" name="name" value="${param.name}">
            <label>輸入 age：</label>
            <input type="text" name="age" value="${param.age}">
            <button type="submit">送出</button>
        </form>
        <p><small>提示：送出後 URL 會變成 ?name=xxx&age=xxx</small></p>
    </div>
    
    <!-- 2. header 物件 -->
    <div class="section">
        <h2>2. header 物件（取得瀏覽器資訊）</h2>
        <p>User-Agent：<span class="result">${header['User-Agent']}</span></p>
        <p>Accept-Language：<span class="result">${header['Accept-Language']}</span></p>
    </div>
    
    <!-- 3. cookie 物件 -->
    <div class="section">
        <h2>3. cookie 物件</h2>
        <c:set var="cookieName" value="${cookie.JSESSIONID.name}" />
        <c:set var="cookieValue" value="${cookie.JSESSIONID.value}" />
        <p>Session Cookie 名稱：<span class="result">${cookieName}</span></p>
        <p>Session Cookie 值：<span class="result">${cookieValue}</span></p>
    </div>
    
    <!-- 4. pageContext 物件 -->
    <div class="section">
        <h2>4. pageContext 物件</h2>
        <p>Context Path：<span class="result">${pageContext.request.contextPath}</span></p>
        <p>Request URI：<span class="result">${pageContext.request.requestURI}</span></p>
        <p>Session ID：<span class="result">${pageContext.session.id}</span></p>
        <p>Server Info：<span class="result">${pageContext.servletContext.serverInfo}</span></p>
    </div>
    
    <!-- 5. 範圍物件 -->
    <div class="section">
        <h2>5. 範圍物件</h2>
        <c:set var="pageMsg" value="Page 訊息" scope="page" />
        <c:set var="requestMsg" value="Request 訊息" scope="request" />
        <c:set var="sessionMsg" value="Session 訊息" scope="session" />
        <c:set var="appMsg" value="Application 訊息" scope="application" />
        
        <p>pageScope：<span class="result">${pageScope.pageMsg}</span></p>
        <p>requestScope：<span class="result">${requestScope.requestMsg}</span></p>
        <p>sessionScope：<span class="result">${sessionScope.sessionMsg}</span></p>
        <p>applicationScope：<span class="result">${applicationScope.appMsg}</span></p>
    </div>
    
    <br>
    <a href="index.jsp">回首頁</a>
</body>
</html>