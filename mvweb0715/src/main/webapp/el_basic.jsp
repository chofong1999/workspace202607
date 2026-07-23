<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>EL 基本練習</title>
    <style>
        body { font-family: "Microsoft JhengHei", Arial; max-width: 800px; margin: 50px auto; padding: 20px; }
        .section { background: #f9f9f9; padding: 15px; margin: 10px 0; border-radius: 5px; }
        h2 { color: #333; border-bottom: 2px solid #3498db; padding-bottom: 5px; }
        .result { color: #27ae60; font-weight: bold; }
    </style>
</head>
<body>
    <h1>EL 基本練習</h1>
    
    <!-- 設定變數 -->
    <c:set var="name" value="張小明" />
    <c:set var="age" value="25" />
    <c:set var="score" value="85.5" />
    
    <!-- 1. 顯示變數 -->
    <div class="section">
        <h2>1. 顯示變數</h2>
        <p>姓名：<span class="result">${name}</span></p>
        <p>年齡：<span class="result">${age}</span></p>
        <p>分數：<span class="result">${score}</span></p>
    </div>
    
    <!-- 2. 算術運算 -->
    <div class="section">
        <h2>2. 算術運算</h2>
        <p>10 + 5 = <span class="result">${10 + 5}</span></p>
        <p>10 - 5 = <span class="result">${10 - 5}</span></p>
        <p>10 * 5 = <span class="result">${10 * 5}</span></p>
        <p>10 / 3 = <span class="result">${10 / 3}</span></p>
        <p>10 % 3 = <span class="result">${10 % 3}</span></p>
    </div>
    
    <!-- 3. 比較運算 -->
    <div class="section">
        <h2>3. 比較運算</h2>
        <p>10 > 5：<span class="result">${10 > 5}</span></p>
        <p>10 < 5：<span class="result">${10 < 5}</span></p>
        <p>10 == 10：<span class="result">${10 == 10}</span></p>
        <p>10 != 5：<span class="result">${10 != 5}</span></p>
    </div>
    
    <!-- 4. 邏輯運算 -->
    <div class="section">
        <h2>4. 邏輯運算</h2>
        <p>true && false：<span class="result">${true && false}</span></p>
        <p>true || false：<span class="result">${true || false}</span></p>
        <p>!true：<span class="result">${!true}</span></p>
    </div>
    
    <!-- 5. 條件運算 -->
    <div class="section">
        <h2>5. 條件運算</h2>
        <c:set var="score2" value="75" />
        <p>成績：${score2}</p>
        <p>是否及格：<span class="result">${score2 >= 60 ? '及格' : '不及格'}</span></p>
        <p>等級：<span class="result">${score2 >= 90 ? 'A' : score2 >= 80 ? 'B' : score2 >= 70 ? 'C' : 'D'}</span></p>
    </div>
    
    <!-- 6. empty 運算 -->
    <div class="section">
        <h2>6. empty 運算</h2>
        <c:set var="emptyStr" value="" />
        <c:set var="nullStr" value="${null}" />
        <c:set var="hasValue" value="Hello" />
        <p>空字串 empty ''：<span class="result">${empty emptyStr}</span></p>
        <p>null empty null：<span class="result">${empty nullStr}</span></p>
        <p>有值 empty 'Hello'：<span class="result">${empty hasValue}</span></p>
    </div>
    
    <br>
    <a href="index.jsp">回首頁</a>
</body>
</html>