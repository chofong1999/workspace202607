<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="model.User2" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>JavaBean + EL 練習</title>
    <style>
        body { font-family: "Microsoft JhengHei", Arial; max-width: 800px; margin: 50px auto; padding: 20px; }
        .section { background: #f9f9f9; padding: 15px; margin: 10px 0; border-radius: 5px; }
        h2 { color: #333; border-bottom: 2px solid #3498db; padding-bottom: 5px; }
        .result { color: #27ae60; font-weight: bold; }
        .active { color: green; }
        .inactive { color: red; }
    </style>
</head>
<body>
    <h1>JavaBean + EL 練習</h1>
    
    <%-- 建立 User 物件 --%>
    <jsp:useBean id="user1" class="model.User2" scope="request" />
    <jsp:setProperty property="name" value="王小華" name="user1" />
    <jsp:setProperty property="age" value="15" name="user1" />
    <jsp:setProperty property="email" value="hua@example.com" name="user1" />
    <jsp:setProperty property="active" value="true" name="user1" />
    
    <!-- 1. 使用 EL 存取 Bean 屬性 -->
    <div class="section">
        <h2>1. 使用 EL 存取 Bean 屬性</h2>
        <p>姓名：<span class="result">${user1.name}</span></p>
        <p>年齡：<span class="result">${user1.age}</span></p>
        <p>Email：<span class="result">${user1.email}</span></p>
        <p>狀態：<span class="result ${user1.active ? 'active' : 'inactive'}">${user1.status}</span></p>
        <p>是否成年：<span class="result">${user1.adult ? '是' : '否'}</span></p>
    </div>
    
    <!-- 2. 條件顯示 -->
    <div class="section">
        <h2>2. 條件顯示</h2>
        <c:if test="${user1.active}">
            <p style="color: green;">✓ 帳號已啟用</p>
        </c:if>
        <c:if test="${!user1.active}">
            <p style="color: red;">✗ 帳號已停用</p>
        </c:if>
        
        <c:if test="${user1.age >= 18}">
            <p style="color: green;">✓ 已成年</p>
        </c:if>
        <c:if test="${user1.age < 18}">
            <p style="color: orange;">△ 未成年</p>
        </c:if>
    </div>
    
    <!-- 3. 使用 c:choose 條件判斷 -->
    <div class="section">
        <h2>3. 會員等級判斷</h2>
        <c:set var="points" value="750" />
        <p>點數：${points}</p>
        <p>等級：
            <c:choose>
                <c:when test="${points >= 1000}">
                    <span class="result" style="color: gold;">黃金會員</span>
                </c:when>
                <c:when test="${points >= 500}">
                    <span class="result" style="color: silver;">銀牌會員</span>
                </c:when>
                <c:otherwise>
                    <span class="result">一般會員</span>
                </c:otherwise>
            </c:choose>
        </p>
    </div>
    
    <!-- 4. 陣列與 List -->
    <div class="section">
        <h2>4. 陣列與 List</h2>
        <jsp:useBean id="colors" class="java.util.ArrayList" scope="page" />
        
        <% colors.add("紅色"); colors.add("藍色"); colors.add("綠色"); %>
        
        <p>第一個顏色：<span class="result">${colors[0]}</span></p>
        <p>第二個顏色：<span class="result">${colors[1]}</span></p>
        <p>第三個顏色：<span class="result">${colors[2]}</span></p>
        <p>總共有 <span class="result">${colors.size()}</span> 個顏色</p>
        
        <ul>
            <c:forEach var="color" items="${colors}" varStatus="status">
                <li>${status.index + 1}. ${color}</li>
            </c:forEach>
        </ul>
    </div>
    
    <!-- 5. Map 使用 -->
    <div class="section">
        <h2>5. Map 使用</h2>
        <jsp:useBean id="scores" class="java.util.HashMap" scope="page" />
        
        <% scores.put("國文", 85); scores.put("英文", 92); scores.put("數學", 78); %>
        
        <p>國文：<span class="result">${scores['國文']}</span></p>
        <p>英文：<span class="result">${scores['英文']}</span></p>
        <p>數學：<span class="result">${scores['數學']}</span></p>
    </div>
    
    <br>
    <a href="index.jsp">回首頁</a>
</body>
</html>