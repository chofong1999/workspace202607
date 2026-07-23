<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee View</title>
</head>
<body>
<table border="1" width="50%">
        <tr>
            <th>編號</th>
            <th>名字</th>
            <th>Email</th>
            <th>職稱</th>
            <th>辦公室</th>
        </tr>
        <c:forEach var="employee" items="${requestScope.emps}">
            <tr>
                <td>${employee.employeeNumber}</td>
                <td>${employee.firstName}/${employee.lastName}</td>                
                <td>${employee.email}</td>
                <td>${employee.jobTitle}</td>
                <td>${employee.officeCode}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>