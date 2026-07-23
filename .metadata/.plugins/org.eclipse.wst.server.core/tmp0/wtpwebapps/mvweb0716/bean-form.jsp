<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>JavaBean 與表單</title>
    <style>
        body { font-family: "Microsoft JhengHei", Arial; max-width: 800px; margin: 50px auto; padding: 20px; }
        .section { background: #f9f9f9; padding: 15px; margin: 10px 0; border-radius: 5px; }
        h2 { color: #333; border-bottom: 2px solid #3498db; padding-bottom: 5px; }
        .result { color: #27ae60; font-weight: bold; }
        form { margin: 20px 0; }
        label { display: block; margin: 10px 0 5px; }
        input { padding: 8px; width: 300px; }
        button { padding: 10px 20px; background: #3498db; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #2980b9; }
    </style>
</head>
<body>
    <h1>JavaBean 與表單</h1>
    
    <%-- 建立 Bean --%>
    <jsp:useBean id="user" class="model.User" scope="request" />
    
    <%-- 表單 --%>
    <div class="section">
        <h2>輸入資料</h2>
        <form method="post" action="bean-form.jsp">
            <label>姓名：</label>
            <input type="text" name="name" value="${user.name}" />
            
            <label>年齡：</label>
            <input type="number" name="age" value="${user.age}" />
            
            <label>Email：</label>
            <input type="email" name="email" value="${user.email}" />
            
            <br><br>
            <button type="submit">送出</button>
            <button type="reset">清除</button>
        </form>
    </div>
    
    <%-- 處理表單提交 --%>
    <c:if test="${not empty param.name}">
        <%-- 自動對應表單參數到 Bean --%>
        <jsp:setProperty name="user" property="*" />
        
        <div class="section">
            <h2>顯示結果</h2>
            <p>姓名：<span class="result">${user.name}</span></p>
            <p>年齡：<span class="result">${user.age}</span></p>
            <p>Email：<span class="result">${user.email}</span></p>
            <p>是否成年：<span class="result">${user.adult ? '是' : '否'}</span></p>
        </div>
    </c:if>
    
    <br>
    <a href="index.jsp">回首頁</a>
</body>
</html>