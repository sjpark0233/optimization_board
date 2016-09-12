<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인</title>

<style type="text/css">
<!--
body {
	margin: 0;
	padding: 0;
	font: 11px/1.5em Verdana;
}

.font1 {
	font: bold 30px Verdana, sans-serif;
	color: #000;
	margin: 0px;
	padding: 5px 20px 15px 20px;
}

.font2 {
	font: bold 14px Verdana, sans-serif;
	color: #000;
	margin: 0px;
	padding: 0px 20px 0px 0px;
}

.font3 {
	font: 20px Verdana, sans-serif;
	color: #000;
}

h2 {
	font: bold 14px Verdana, Arial, Helvetica, sans-serif;
	color: #000;
	margin: 0px;
	padding: 0px 0px 0px 15px;
}

/*- Menu Tabs F--------------------------- */
#tabsF {
	float: left;
	width: 100%;
	background: #fff;
	font-size: 93%;
	line-height: normal;
	border-bottom: 1px solid #666;
}

#tabsF ul {
	margin: 0;
	padding: 10px 10px 0 50px;
	list-style: none;
}

#tabsF li {
	display: inline;
	margin: 0;
	padding: 0;
}

#tabsF a {
	float: left;
	background:
		url(http://pds7.egloos.com/pds/200803/09/83/b0050083_47d2b60bb22d2.gif)
		no-repeat left top;
	margin: 0;
	padding: 0 0 0 4px;
	text-decoration: none;
}

#tabsF a span {
	float: left;
	display: block;
	background:
		url(http://pds8.egloos.com/pds/200803/09/83/b0050083_47d2b60d5f78a.gif)
		no-repeat right top;
	padding: 5px 15px 4px 6px;
	color: #666;
}
/* Commented Backslash Hack hides rule from IE5-Mac \*/
#tabsF a span {
	float: none;
}
/* End IE5-Mac hack */
#tabsF a:hover span {
	color: #FFF;
}

#tabsF a:hover {
	background-position: 0% -42px;
}

#tabsF a:hover span {
	background-position: 100% -42px;
}

#tabsF #current a {
	background-position: 0% -42px;
}

#tabsF #current a span {
	background-position: 100% -42px;
}
-->

input.button_style{
	font: bold 14px Verdana, Arial, Helvetica, sans-serif;	
	height: 2em;
  -webkit-box-shadow: 0px 1px 3px #666666;
  -moz-box-shadow: 0px 1px 3px #666666;
  box-shadow: 0px 1px 3px #666666;
  color: #000000;
  padding: 4px 2px 4px 2px;
  background: #ffffff;
  border: solid #82B5DF 2px;
  text-decoration: none;
}

input.button_style:hover {
  background: #f2f5f7;
  text-decoration: none;
	color: gray;
}
</style>


<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
<script language="javascript">


function loginCheck(){
	var param = "user_id" + "=" + $("#user_id").val() + "&" +"user_pw" + "="+ $("#user_pw").val();
	$.ajax({
		url : "user?action=login",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		success : function(responseData) {
			var data = JSON.parse(responseData);
			if(data != null)
			{
				var str3 = document.getElementById('login');
				str3.submit();
				alert("로그인 되었습니다.");
				location.replace("post?action=list");
			}
			else
			{
				var str3 = document.getElementById('login');
				str3.submit();
				alert("아이디나 비밀번호가 틀렸거나 권한이 없습니다.");
				location.replace("login.jsp");
			}	
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : "
						+ request.reponseText + "\r\nerror : " + error);
			}
		}
	});
}
</script>
</head>
<body>
	<!-- 상단 -->
	<div align=right>
		<font class = "font2"><br>
		<input type="button" value="LogIn" onClick="location.href='login.jsp'" class="button_style">&nbsp| 
		<input type="button" value="회원가입" onClick="location.href='join.jsp'" class="button_style">
		</font>
	</div>
	<div>
		<font class="font1"> 최적화팀 게시판 </font> <br>
		<br>
	</div>
	<!-- 탭 -->
	<div id="tabsF">
		<ul>
			<b>
				<li id="current"><a href="post?action=list"><span>Home</span></a></li>
				<li><a href="post?action=list&tab_code=1"><span>Windows</span></a></li>
				<li><a href="post?action=list&tab_code=2"><span>MS
							SQL</span></a></li>
				<li><a href="post?action=list&tab_code=3"><span>Oracle</span></a></li>
				<li><a href="post?action=list&tab_code=4"><span>Network</span></a></li>
				<li><a href="post?action=list&tab_code=5"><span>SAP</span></a></li>
			</b>
		</ul>
	</div>
	<div class="font1">
		<center>
			<br>
			<H4>로그인</H4>
		</center>
	</div>
	<div class="font3" align="center">
		<form name="login" method="post" action="user" id="login">
			<table align="center" border="3" width="400" height="150"
				border="solid" bordercolor="#333333">
				<tr>
					<td>&nbsp;<label>아이디 : </label> <input type="text"
						id="user_id" name="user_id" size="15" maxlength="12"> <br>
					<br> &nbsp;<label>비밀번호 : </label> <input type="password"
						id="user_pw" name="user_pw" size="15" maxlength="12">
					</td>
				</tr>
			</table>
			<br> &nbsp;<input type="submit" value="로그인"
				onClick='loginCheck()'>&nbsp;&nbsp; <input type="button"
				value="회원가입" onClick="location.href='join.jsp'">&nbsp;
		</form>
	</div>
</body>
</html>