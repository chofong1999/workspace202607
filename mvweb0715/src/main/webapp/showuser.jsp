<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if(session.getAttribute("user")!=null)
	{
		out.println("Your name is"+session.getAttribute("user")+"!");
	}
	else
	{
		out.println("Hello Guest!");
		response.sendRedirect("user.html");
	}
%>


</body>
</html>