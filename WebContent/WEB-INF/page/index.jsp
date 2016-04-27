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
	User user = (User)request.getSession().getAttribute("user");
%>
<html>
<head>
	<base href="<%=basePath%>">
	<meta charset="UTF-8">
	<title>Document</title>
	<link rel="stylesheet" type="text/css" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/jumbotron.css">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/font-awesome-4.5.0/css/font-awesome.min.css">
	<script type="text/javascript" src="bower_components/jquery/dist/jquery.min.js"></script>
	<script type="text/javascript" src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery-1.11.3.min.js "></script>
	<script type="text/javascript" src="bower_components/bootstrap/js/modal.js"></script>
	<script type="text/javascript" src="js/generation.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

</head>

<body>
<form action="signup" method="post" class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel" style="display:inline-block;font-size: 20px;">欢迎注册</h4><span style="font-size: 12px;color: red;margin-left: 10px">*</span><span>为必填项</span>
      </div>
      <div class="modal-body">
        <div class="form-group">
        	<label for="modal-usrname">用户名</label> <span style="color: red;">*</span> <span id="usrnameInfo" style="visibility: hidden; font-size: 12px; color: #7e7e7e;float:right;" >请输入4-20长度的英文字符</span>
            <input type="text"  id="modal-usrname" name="un" placeholder="Username" class="form-control" onclick="insertUsrname()" onblur="checkUsrname()"/>
        </div>
        <div class="form-group">
        	<label for="modal-passwd1">密码</label> <span style="color: red;">*</span> <span id="passwd1Info" style="visibility: hidden; font-size: 12px; color: #7e7e7e;float:right;" >密码长度至少为7</span>
            <input name="pw1" id="modal-passwd1" type="password" placeholder="Password" class="form-control" onclick="insertPasswd1()" onblur="checkPasswd1()">
        </div>
        <div class="form-group">
        	<label for="modal-passwd2">重复密码</label> <span style="color: red;">*</span> <span id="passwd2Info" style="visibility: hidden; font-size: 12px; color: #7e7e7e;float:right;" >密码必须保持相同</span>
            <input name="pw2" id="modal-passwd2" type="password" placeholder="Repeat" class="form-control" onclick="insertPasswd2()" onblur="checkPasswd2()">
        </div>
        <div class="form-group">
        	<label for="modal-email">邮箱地址</label> <span id="emailInfo" style="visibility: hidden; font-size: 12px; color: #7e7e7e;float:right;" >请输入正确格式的邮箱地址</span>
            <input name="email" id="modal-email" type="text" placeholder="Email-Address" class="form-control" onclick="insertEmail()" onblur="checkEmail()">
        </div>
        <div class="form-group">
        	<label for="modal-nickName">昵称</label> <span style="color: red;">*</span> <span id="nickInfo" style="visibility: hidden; font-size: 12px; color: #7e7e7e;float:right;" >昵称不能为空</span>
            <input name="nickName" id="modal-nickName" type="text" placeholder="NickName" class="form-control" onclick="insertNick()" onblur="checkNick()">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <input type="button" class="btn btn-default" onclick="checkAll()" value="提交"/>
      </div>
    </div>
  </div>
</form>
<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="javascript:void(0)">快乐运算:)</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
        	<% if(user == null){%>
            <form class="navbar-form navbar-right" action="signin" method="post">
            
	            <div class="form-group">
	              <input type="text"  name="un" placeholder="Email" class="form-control">
	            </div>
	            <div class="form-group">
	              <input name="pw" type="password" placeholder="Password" class="form-control">
	            </div>
	            <button type="submit" class="btn btn-success">Sign in</button>
	            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal">Sign up</button>
	            
	        </form>
            <% }else{%>
				<ul class="nav navbar-nav navbar-right">
            		
	            	<li><a href="userinfo" style="text-decoration: none; color: #777;;">欢迎你！<%=user.getNickName() %></a></li>
	            	<li><a href="logout" style="text-decoration: none; color: #777;;">登出</a></li>
	            </ul>
            <%}%>
            
	          
          
        </div>
      </div>
	</nav>
	<div class="jumbotron">
      <div class="container">
      	<div class="row">
      		<div class="col-md-10">
				<h3>欢迎来到快乐运算~</h3>
		        <p>在这里你将攻克各个难题，和不同的人面对难易相近的难题。希望你能披荆斩棘，走向人生巅峰。</p>
		        <strong>你可以：</strong>
		        <small>独自通关</small><br>
		        <small class="ml57">线上对战</small><br><br>
		        <button class="btn btn-primary btn-xs" href="#" role="button">详细信息 »</button>
      		</div>
  			<div class="col-md-2"><div class="thumbnail"><img src="images/logo.jpg" class="thumbnail" width="400em" height="200em"></div></div>
      	</div>
      </div>
    </div>
    <div class="container black mb30">
    	<div class="row">
	        <div class="col-md-5 bgc1 pd20" id="leftBox">
	            <h4>小试牛刀</h4>
	            <div class="dropup">
		        	<button class="btn-warning choose btn-block" data-toggle="dropdown" aria-haspopup="true">
		        		<h6>选择难度<span class="caret"></span></h6>
					</button>
		            <ul class="dropdown-menu btn-block">
					  <li><a onclick="getItem(10, 4, 2, 0, 1)">白银</a></li>
					  <li><a onclick="getItem(10, 4, 2, 0, 5)">黄金</a></li>
					  <li><a onclick="getItem(100, 4, 2, 0, 10)">白金</a></li>
					  <li><a onclick="getItem(100, 4, 4, 0, 10)">钻石</a></li>
					  <li><a onclick="getItem(100, 4, 4, 1, 100)">最强王者</a></li>
					</ul>
				</div>
				<div class="info pd20">
					<img src="images/logo.jpg" class="thumbnail" width="100em" height="100em" style="float:left">
					<% 
					String un = "尚未登陆";	
					String p = "尚未登陆";
					String level = "尚未登陆";
						if(user != null){
								un = user.getNickName();
								p = user.getPoints().toString();
								level = user.getLevel().toString();
						}
					%>
					<span class="user-name block"><a href="userinfo">姓名：<%=un%></a></span>
					<span class="user-score block">分数：<%=p%></span>
					<span class="user-rank block">等级：<%=level%></span>
					<span class="guest-score block">测试得分：</span>
					<span class="guest-score block"><button class="btn-warning choose btn-block" data-toggle="dropdown" aria-haspopup="true" onclick="showAllFormulas()">习题册</button></span>
				</div>
	        </div>
	        <div class="yourans col-md-5 bgc1 pd20" id="leftBox2" style="display: none">
	        	<h4>看看你的结果吧</h4>
				<img src="images/logo.jpg" class="thumbnail" width="100em" height="100em" style="float:left">
				<button class="btn-success" onclick="back()" style="position: absolute; margin-left:30px; margin-top:130px">返回</button>
				<table id="ans-table" class="table" style="margin-left: 110px; width: calc(100% - 110px)">
			        <tr>
			            <th scope="row">1</th>
			            <td></td>
			            <td></td>
			            <td></td>
			        </tr>
			        <tr>
			            <th scope="row">2</th>
			            <td></td>
			            <td></td>
			            <td></td>
			        </tr>
			        <tr>
			            <th scope="row">3</th>
			            <td></td>
			            <td></td>
			            <td></td>
			        </tr>
			        <tr>
			            <th scope="row">4</th>
			            <td></td>
			            <td></td>
			            <td></td>
			        </tr>
			        <tr>
			            <th scope="row">5</th>
			            <td></td>
			            <td></td>
			            <td></td>
			        </tr>
			        <tr>
			            <th scope="row">#</th>
			            <td></td>
			            <td></td>
			            <td></td>
			        </tr>
				</table>
			</div>
	        <div class="formulas col-md-5 bgc1 pd20" id="leftBox1" style="display: none">
	        	<h4>请回答下列问题：</h4>

				<table id="problem-table" class="table table-bordered" style="margin-top: 15px;">
			        <tr>
			            <th scope="row">1</th>
			            <td>1+1+1+1+1+1+1+1</td>
			            <td><input type="text" class="form-control" id="Answer1" placeholder="Answer"></td>
			        </tr>
				    <tr>
				        <th scope="row">2</th>
				        <td>吴军</td>
				        <td><input type="text" class="form-control" id="Answer1" placeholder="Answer"></td>
			        </tr>
			        <tr>
			            <th scope="row">3</th>
			            <td>高鑫</td>				            
			            <td><input type="text" class="form-control" id="Answer1" placeholder="Answer"></td>
				    </tr>
				    <tr>
				        <th scope="row">4</th>
			            <td>包玲玲</td>
			            <td><input type="text" class="form-control" id="Answer1" placeholder="Answer"></td>
			        </tr>
			        <tr>
			            <th scope="row">5</th>
			            <td>严一格</td>
			            <td><input type="text" class="form-control" id="Answer1" placeholder="Answer"></td>
			        </tr>
				</table>
				<button class="btn-success btn-block" onclick="submit()" style="margin-top: 50px">提交</button>
			</div>
	        <div class="col-md-7 bgc2 pd20" id="rightBox">
	        	<h4>榜上有名</h4>
	        	<table class="table">
	        		<thead>
						<tr>
				            <th>#</th>
				            <th>Username</th>
				            <th>Score</th>
				            <th>Rank</th>
				        </tr>
			        </thead>
	        	<% 
	        	int i = 0;
					List<User> su = (List<User>)request.getAttribute("su");
				for (User u : su){
				%>
					<tr>
			            <th scope="row"><%=++i %></th>
			            <td><%=u.getNickName()%></td>
			            <td><%=u.getPoints()%></td>
			            <td><%=u.getLevel()%></td>
			        </tr>
					<%
				}
				%>
				</table>
	       </div>
	    </div>
    </div>
    <div style="margin-bottom: 20px">
    	<div class="container">
    		<div class="row">
	    		<div class="formulas bgc1 pd20" id="leftBox3" style="display: none">
		        	<h4>请回答下列问题：</h4>

					<table id="all-problem-table" class="table table-bordered" style="margin-top: 15px;">
				        <tr>
				            <th scope="row">题号</th>
				            <td>题目</td>
				            <td>正确答案</td>
				            <td>您的答案</td>
				        </tr>
					</table>
					<button class="btn-success btn-block" onclick="miss()" style="">隐藏</button>
				</div>
			</div>
			<h1 style="display: block">灌水版聊区</h1>
    	</div>
    	
    </div>
	<div style="margin-bottom: 60px">
		<div class="container block">
			<div class="row bgc1" id= "board" style="height: 500px; position: relative;">
				<form class="form-inline">
					<div class="form-group" style="position: absolute; bottom: 5px; width: 100%;">
						<input type="text" class="form-control" id="comment" style="width: 80%">
						<button type="button" id="commentBtn" class="btn btn-default" style="width: 19%">发送弹幕</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	


    <nav class="navbar navbar-default navbar-fixed-bottom">
    	<div class="row">
    		<% if(user != null){%>
    		<div class="col-md-6 btn-success" style="min-height: 30px; line-height: 30px; text-align: center" onclick="Competed()"><a href = "game/normal">个人匹配</a></div>
    		<% }else{%>
    		<div class="col-md-6 btn-success" style="min-height: 30px; line-height: 30px; text-align: center" onclick="pleaseLogIn()"><a href = "game/normal">个人匹配</a></div>
    		<% }%>
    		<div class="col-md-6 btn-warning" style="min-height: 30px; line-height: 30px; text-align: center">多人对战</div>
    	</div>
    </nav>

</body>
<script type="text/javascript">
	function gid(id){
		return document.getElementById(id+"");
	}
	function Competed(){
		window.location.href="game/normal";
	}
	function pleaseLogIn(){
		alert("请先登录！");
	}
	function insertUsrname(){
		var usrnameInfo = gid("usrnameInfo");
		var modalusrname = gid("modal-usrname");
		usrnameInfo.style.color = '#7e7e7e';
		usrnameInfo.innerHTML = '请输入4-20长度的英文字符';
		usrnameInfo.style.visibility = 'visible';

	}

	function checkUsrname(){
		var re = /^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){3,19}$/
		var usrnameInfo = gid("usrnameInfo");
		var modalusrname = gid("modal-usrname");
		if(modalusrname.value==""){
			usrnameInfo.innerHTML = '必填';
			usrnameInfo.style.color = 'red';
		}else if(!re.test(modalusrname.value)){
			usrnameInfo.innerHTML = '请输入4-20长度的英文字符';
			usrnameInfo.style.color = 'red';
		}else{
			usrnameInfo.innerHTML = '正确';
			usrnameInfo.style.color = 'green';
			return true;
		}
		return false;
	}

	function insertPasswd1(){
		var passwd1Info = gid("passwd1Info");
		passwd1Info.style.color = '#7e7e7e';
		passwd1Info.innerHTML = '密码长度至少为7最多为20';
		passwd1Info.style.visibility = 'visible';
	}

	function checkPasswd1(){
		var re = /^([a-zA-Z0-9]|[._]){7,20}$/
		var passwd1Info = gid("passwd1Info");
		var modalpasswd1 = gid("modal-passwd1");
		if(modalpasswd1.value==""){
			passwd1Info.innerHTML = '必填';
			passwd1Info.style.color = 'red';
		}else if(!re.test(modalpasswd1.value)){
			passwd1Info.innerHTML = '请输入7-20长度的密码';
			passwd1Info.style.color = 'red';
		}else{
			passwd1Info.innerHTML = '正确';
			passwd1Info.style.color = 'green';
			return true;
		}
		return false;
	}

	function insertPasswd2(){
		var passwd2Info = gid("passwd2Info");
		passwd2Info.style.color = '#7e7e7e';
		passwd2Info.innerHTML = '密码必须保持相同';
		passwd2Info.style.visibility = 'visible';
	}

	function checkPasswd2(){
		var passwd2Info = gid("passwd2Info");
		var modalpasswd1 = gid("modal-passwd1");
		var modalpasswd2 = gid("modal-passwd2");
		if(modalpasswd2.value==""){
			passwd2Info.innerHTML = '必填';
			passwd2Info.style.color = 'red';
		}else if(modalpasswd2.value != modalpasswd1.value){
			passwd2Info.innerHTML = '密码必须保持相同';
			passwd2Info.style.color = 'red';
		}else{
			passwd2Info.innerHTML = '正确';
			passwd2Info.style.color = 'green';
			return true;
		}
		return false;
	}

	function insertEmail(){
		var emailInfo = gid("emailInfo");
		emailInfo.style.color = '#7e7e7e';
		emailInfo.innerHTML = '请输入正确格式的邮箱地址';
		emailInfo.style.visibility = 'visible';
	}

	function checkEmail(){
		var re = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
		var emailInfo = gid("emailInfo");
		var modalemail = gid("modal-email");
		console.log()
		if(modalemail.value==""){
			emailInfo.style.visibility = 'hidden';
			return true;
		}else if(!re.test(modalemail.value)){
			emailInfo.innerHTML = '请输入正确格式的邮箱地址';
			emailInfo.style.color = 'red';
		}else{
			emailInfo.innerHTML = '正确';
			emailInfo.style.color = 'green';
			return true;
		}
		return false;
	}

	function insertNick(){
		var nickInfo = gid("nickInfo");
		nickInfo.style.color = '#7e7e7e';
		nickInfo.innerHTML = '昵称不能为空';
		nickInfo.style.visibility = 'visible';
	}

	function checkNick(){
		var nickInfo = gid("nickInfo");
		var modalnickName = gid("modal-nickName");
		if(modalnickName.value==""){
			nickInfo.innerHTML = '必填';
			nickInfo.style.color = 'red';
		}else{
			nickInfo.innerHTML = '正确';
			nickInfo.style.color = 'green';
			return true;
		}
		return false;
	}

	function checkAll(){
		var flag = false;
		flag = (checkUsrname() && checkPasswd1() && checkPasswd2() && checkEmail() && checkNick());
		console.log("usr="+checkUsrname());
		console.log("checkPasswd1="+checkPasswd1());
		console.log("checkPasswd2="+checkPasswd2());
		console.log("checkEmail="+checkEmail());
		console.log("checkNick="+checkNick());
		if(flag){
			var myModal = gid("myModal");
			myModal.submit();
		}else{
			alert('请检查您的信息');
		}
	}

</script>
<script type="text/javascript">

$(document).ready(function(){
  $("#commentBtn").click(function(){
  	// alert($("#comment").val());
    $.get("submitComment?cm="+$("#comment").val(),function(data,status){
      if(data){
      	alert('发送成功');
      }else{
      	alert('发送失败');
      }
    });
  });
});

var board = $("#board");

setInterval(function(){
	$.get("getComment",function(data,status){
		var obj = JSON.parse(data);
    	for(var i = 0 ; i < obj.length ; i ++){
    		for (var property in obj[i]) {  
    			var comment = document.createElement('div');
                comment.style.position = 'absolute';
                comment.style.top = Math.random() * 500 + 'px';
                comment.style.fontSize = Math.random() * 30 + 'px';
                comment.style.whiteSpace = 'nowrap';
                comment.innerHTML = obj[i][property];
                comment.id = property;
                var cid = "#"+property;
                comment.setAttribute("speed", Math.random() * 5000);
                board.append(comment);
                var my = $(cid);
                my.animate({left:"100%"},parseInt(comment.getAttribute("speed")),
                	function(){
                		comment.remove();
                	});
       //          console.log(comment.getAttribute("speed"));
		    	// console.log(obj[i][property]);  
		    }  
    	}
    	// var comments = $(".generatedComment");
    	// console.log(comments);
	    // for(var i = 0 ; i < comments[i] ; i ++){
	    // 	console.log(comments[i].speed);

	    // }
    });
    
},2000);

</script>
</html>