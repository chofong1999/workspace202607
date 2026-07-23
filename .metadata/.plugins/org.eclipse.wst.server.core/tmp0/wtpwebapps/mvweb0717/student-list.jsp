<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student View</title>
 <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:hover { background-color: #f5f5f5; }
        .btn { padding: 5px 10px; text-decoration: none; border-radius: 3px; }
        .btn-edit { background-color: #2196F3; color: white; }
        .btn-delete { background-color: #f44336; color: white; }
        .btn-add { background-color: #4CAF50; color: white; padding: 10px 20px; }
 </style>
</head>
<body>
<a href="student?action=add" class="btn btn-add">新增學生</a><br/><br/>
<table border="1" width="50%">
        <tr>
            <th>學號</th>
            <th>名字</th>
            <th>Email</th>
            <th>年紀</th>
            <th>Action</th>
        </tr>
        <c:forEach var="s" items="${requestScope.students}">
            <tr>
                <td>${s.id}</td>                                
                <td>${s.name}</td>
                <td>${s.email}</td>
                <td>${s.age}</td>
                <td>
                    <a href="student?action=edit&id=${s.id}" class="btn btn-edit">編輯</a>
                    <a href="javascript:if(confirm('確定刪除？'))location.href='student?action=delete&id=${s.id}'" 
                       class="btn btn-delete">刪除</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>