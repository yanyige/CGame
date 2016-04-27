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
		NewGame game = (NewGame) request.getAttribute("game");
		List<Question> ql = game.getQuestions();
		int gid = game.getId();
		String data_str = new Date(Long.parseLong(game.getTime())).toString();
		long lt = (Long) request.getAttribute("lt");
		long st = (Long) request.getAttribute("st") / 1000;
	%>
	<div class="gameInfo">
		<h1>游戏编号:<%=gid%></h1>
		开始时间：<%=data_str%>
		<br>
		
		<span>时间限制:<%=lt%>s</span>
	</div>
	
	<div class="problem">
	
		<span style="font-family: 'Microsoft YaHei', '黑体';font-size: 25px">题目列表：</span>

		<form id="form" action='game/submit'>
		<!-- navigation holder -->
		<input type = "hidden" name="gid"  value="<%=gid %>"/>

			<table id="problem-table" class="table table-bordered" style="margin-top: 15px;">

				<%
					int i = 0;
					for (Question q : ql) {
				%>
				<tr><th scope="row"><%=++i%></th><td><%=q.getContent()%></td><td><input type="text" name="qa[<%=q.getId() %>]" class="form-control" id="Answer1" placeholder="Answer"/></td></tr>
				<%
					}
				%>
			</table>
			<div class="formFooter" style="overflow: hidden;">
				已用时间:
				<span id='time'>
					<%=st%>
				</span>
				<input type = "submit" class="btn-success btn-sm">
			</div>
		</form>
	</div>
</body>

<script>
	var cn = <%=st%>
	function change() {
		cn++
		document.getElementById('time').innerHTML = cn
		if (cn >=<%=lt%>) {
			 document.getElementById('form').submit();
		}
	}
	self.setInterval('change()', 1000);

	// $(function(){

 //    /* initiate the plugin */
	//     $("div.holder").jPages({
	//       containerID  : "itemContainer",
	//       perPage      : 1,
	//       startPage    : 1,
	//       startRange   : 1,
	//       midRange     : 5,
	//       endRange     : 1
	//     });

	// });
  </script>
</script>

</html>