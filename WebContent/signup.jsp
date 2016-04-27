<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String path = request.getContextPath();
	//获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="signup" method="post">
	账号：<input type = "text" name="un"/>
	密码：<input type = "text" name="pw1"/>
	重复密码：<input type = "text" name="pw2"/>
	昵称：<input type = "text" name="nickName"/>
	<input type = "submit"/>
</form>
</body>
</html>