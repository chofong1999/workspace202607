<%-- student-form.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
          <c:when test="${isEdit}">編輯學生
          </c:when>
          <c:otherwise>新增學生</c:otherwise>
        </c:choose>
    </title>
</head>
<body>
    <h1><c:choose>
          <c:when test="${isEdit}">編輯學生</c:when>
          <c:otherwise>新增學生</c:otherwise>
        </c:choose></h1>
    
    <form method="post" action="student">
        <c:choose>
            <c:when test="${isEdit}">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${student.id}">
            </c:when>
            <c:otherwise>
                <input type="hidden" name="action" value="save">
            </c:otherwise>
        </c:choose>
        
        <p>
            <label>姓名：</label>
            <input type="text" name="name" value="${isEdit ? student.name : ''}" required>
        </p>
        
        <p>
            <label>年齡：</label>
            <input type="number" name="age" value="${isEdit ? student.age : ''}" required>
        </p>
        
        <p>
            <label>電子郵件：</label>
            <input type="email" name="email" value="${isEdit ? student.email : ''}" required>
        </p>
        
        <p>
            <button type="submit">儲存</button>
            <a href="student?action=list">取消</a>
        </p>
    </form>
</body>
</html>