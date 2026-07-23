<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<%
    // 取得表單參數
    String favoriteAnimal = request.getParameter("favoriteAnimal");
    
    // 空值處理
    if (favoriteAnimal == null || favoriteAnimal.trim().isEmpty()) {
        favoriteAnimal = "未知動物";
    } else {
        favoriteAnimal = favoriteAnimal.trim();
    }
    
    // 取得目前時間
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    String currentTime = now.format(formatter);
    
    // 動物分類判斷
    String animalType = "未分類";
    String animalEmoji = "🐾";
    String animalDescription = "";
    
    String animalLower = favoriteAnimal.toLowerCase();
    if (animalLower.contains("貓") || animalLower.contains("cat")) {
        animalType = "貓科動物";
        animalEmoji = "🐱";
        animalDescription = "貓咪是獨立又優雅的夥伴！";
    } else if (animalLower.contains("狗") || animalLower.contains("dog")) {
        animalType = "犬科動物";
        animalEmoji = "🐶";
        animalDescription = "狗狗是人類最忠實的朋友！";
    } else if (animalLower.contains("兔") || animalLower.contains("rabbit")) {
        animalType = "兔科動物";
        animalEmoji = "🐰";
        animalDescription = "兔子是溫順可愛的小動物！";
    } else if (animalLower.contains("熊") || animalLower.contains("bear") || animalLower.contains("panda")) {
        animalType = "熊科動物";
        animalEmoji = "🐼";
        animalDescription = "熊類動物既強壯又可愛！";
    } else if (animalLower.contains("獅") || animalLower.contains("lion") || animalLower.contains("老虎") || animalLower.contains("tiger")) {
        animalType = "大型貓科";
        animalEmoji = "🦁";
        animalDescription = "大型貓科動物展現自然的威嚴！";
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>調查結果 - <%= favoriteAnimal %> 愛好者</title>
    <style>
        body {
            font-family: "Microsoft JhengHei", Arial, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .result-card {
            background-color: #f0f9ff;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            border-left: 4px solid #3498db;
        }
        .info-item {
            margin: 10px 0;
            padding: 8px;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #3498db;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><%= animalEmoji %> 調查結果</h1>
        
        <div class="result-card">
            <h3>您的選擇</h3>
            <p style="font-size: 1.2rem;">
                您最喜歡的動物是：<strong style="color: #3498db;"><%= favoriteAnimal %></strong>
            </p>
            <p><%= animalDescription %></p>
        </div>
        
        <div class="info-item">
            <strong>動物分類：</strong><%= animalType %>
        </div>
        
        <div class="info-item">
            <strong>提交時間：</strong><%= currentTime %>
        </div>
        
        <a href="favcss.html" class="back-link">🔄 重新選擇</a>
    </div>
</body>
</html>