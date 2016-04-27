<%@page import="baoda.domain.QuestionWithAnswer"%>
<%@page import="baoda.domain.FinishedGameForAUser"%>
<%@page import="baoda.util.SystemCfg"%>
<%@page import="java.util.Date"%>
<%@page import="baoda.domain.Question"%>
<%@page import="java.util.List"%>
<%@page import="baoda.domain.NewGame"%>
<%@page import="baoda.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<head>
<base href="<%=basePath%>">
	<meta charset="UTF-8">
	<title>Document</title>
	<link rel="stylesheet" type="text/css" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/jumbotron.css">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/sec.css">
	<link rel="stylesheet" type="text/css" href="css/font-awesome-4.5.0/css/font-awesome.min.css">
	<script type="text/javascript" src="bower_components/jquery/dist/jquery.min.js"></script>
	<script type="text/javascript" src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery-1.11.3.min.js "></script>
	<link rel="stylesheet" href="css/jPages.css">
    <script src="js/jPages.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>Insert title here</title>
</head>
<body>
	<%
		FinishedGameForAUser game = (FinishedGameForAUser) request.getAttribute("result");
		List<QuestionWithAnswer> ql = game.getQwas();
		double gp = game.getPonits();
		User u = game.getUser();
	%>

	<div class="finishedGame">
		<h1>GameOver!</h1>
		游戏编号:<%=game.getId() %><br>
		开始时间：<%=game.getTime() %>
		结束时间:<%=game.getFtime() %>
		本场得分：<%=game.getPonits() %>
		<br>
	
	</div>

	<div class="container black mb30 mt15">
    	<div class="row">
	        <div class="col-md-3 bgc1 pd20" id="leftBox" style="height: 228px">
	        	<h3 style="text-indent: 19px; margin-top: 10px;">账号：</h3>
				<div class="info pd20">
					<img src="images/logo.jpg" class="thumbnail" width="100em" height="100em" style="float:left">
					
					<span class="user-name block">姓名：<%=u.getNickName() %></span>
					<span class="user-score block">分数：<%=u.getPoints() %></span>
					<span class="user-rank block">等级：<%=u.getLevel() %></span>
				</div>
	        </div>
	        <div class="col-md-9 bgc2 pd20" id="rightBox" style="position:relative;">
	        <button class="btn btn-primary finishButton" onclick="jumpToIndex()">返回首页</button>
	        	<h4>Replay:</h4>
	        	<table class="table" style="text-align: center;">
	        		<thead>
						<tr>
				            <td style="font-weight: bold;">ID</td>
				            <td style="font-weight: bold;">题目</td>
				            <td style="font-weight: bold;">标准答案</td>
				            <td style="font-weight: bold;">你的答案</td>
				        </tr>
			        </thead>

	        		
					<tbody>
					<% 	int i = 0;
						for(QuestionWithAnswer q : ql){%>
						<tr><td scope="row"><%=++i%></td>
						<td><%=q.getContent() %></td>
						<td><%=q.getAnswer() %></td>
						<td><%=q.getNanswer() %></td>
						</tr>
					<%}%>
			        

				</tbody></table>
	       </div>

	    </div>

    </div>


	
	
</body>
<script type="text/javascript">
	function jumpToIndex(){
		window.location.href = "index";
	}
</script>
</html>