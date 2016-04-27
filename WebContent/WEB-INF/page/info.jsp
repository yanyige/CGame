<%@page import="baoda.domain.Question"%>
<%@page import="baoda.domain.QuestionWithAnswer"%>
<%@page import="baoda.domain.FinishedGameForAUser"%>
<%@page import="java.util.List"%>
<%@page import="baoda.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<base href="<%=basePath%>">
<head>
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
<% User u = ((User)request.getSession().getAttribute("user"));%>


<div class="finishedGame" style="box-sizing: border-box; padding: 6px">
	<h1>参加过的游戏</h1>
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
    	<% 
		List<FinishedGameForAUser> fgl = (List<FinishedGameForAUser>)request.getAttribute("fgl");%>
        <button class="btn btn-primary finishButton" onclick="jumpToIndex()">返回首页</button>
        	<h4>历史游戏（共<%=fgl.size()%>场）:</h4>
        	<div class="holder"></div>
        	<ul id="itemContainer">
			<%
			for(FinishedGameForAUser game : fgl){
			%>
			<li>
			<table class="table" style="text-align: center;">
				&nbsp;本局游戏id:<%=game.getId() %>
				&nbsp;&nbsp;开始时间:<%=game.getTime()%>
				 &nbsp;&nbsp;结束时间:<%=game.getFtime()%>
				&nbsp;&nbsp;总得分：<%=game.getPonits() %>
				<thead>
					<tr>
			            <td style="font-weight: bold;">ID</td>
			            <td style="font-weight: bold;">题目</td>
			            <td style="font-weight: bold;">标准答案</td>
			            <td style="font-weight: bold;">你的答案</td>
			        </tr>
		        </thead>
		        <% 
					List<QuestionWithAnswer> ql = game.getQwas();
				int i = 0;
					for(QuestionWithAnswer q : ql){
						%>

							<tr><td scope="row"><%=++i%></td>
							<td><%=q.getContent() %></td>
							<td><%=q.getAnswer() %></td>
							<td><%=q.getNanswer() %></td>
						
						<%
						i ++;
					}
				%>

			</table>
			</li>
			<%	
			}

			%>
			</ul>
       </div>

    </div>

</div>


</body>
<script type="text/javascript">
	$(function(){

    /* initiate the plugin */
	    $("div.holder").jPages({
	      containerID  : "itemContainer",
	      perPage      : 1,
	      startPage    : 1,
	      startRange   : 1,
	      midRange     : 5,
	      endRange     : 1
	    });

	});
</script>
<script type="text/javascript">
	function jumpToIndex(){
		window.location.href = "index";
	}
</script>
</html>