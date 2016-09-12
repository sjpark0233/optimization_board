<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원탈퇴</title>

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

.font4 {
	font: bold 30px Verdana, sans-serif;
	color: #000;
	margin: 0px;
	padding: 5px 20px 5px 20px;
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
  padding: 4px 4px 4px 4px;
  background: #ffffff;
  border: solid #82B5DF 2px;
  text-decoration: none;
}

input.button_style:hover {
  background: #f2f5f7;
  text-decoration: none;
	color: gray;
}
input.button_style2{
	font: bold 20px Verdana, Arial, Helvetica, sans-serif;	
	height: 2em;
  -webkit-box-shadow: 0px 1px 3px #666666;
  -moz-box-shadow: 0px 1px 3px #666666;
  box-shadow: 0px 1px 3px #666666;
  color: #000000;
  padding: 1px 8px 1px 8px;
  background: #ffffff;
  border: solid #82B5DF 2px;
  text-decoration: none;
}

input.button_style2:hover {
  background: #f2f5f7;
  text-decoration: none;
	color: gray;
}
</style>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
<script language="javascript"> 
 
	function begin() {
		document.myform.user_pw.focus();
	}

	function checkIt() {
		if (!document.myform.user_pw.value) {
			alert("비밀번호를 입력하지 않으셨습니다.");
			location.reload();		
		}
		else
		{
			withdraw();
		}

	}
	
	function withdraw(){
			var param = "user_pw" + "=" + $("#user_pw").val();
		$.ajax({
			url : "user?action=user_withdraw",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",

			success : function(responseData) {
				var data = JSON.parse(responseData);
				if(data.success == 1)
				{
					alert("회원탈퇴 되었습니다.");	
					alert("첫 화면으로 돌아갑니다.");		
					location.replace("post?action=list");				
				}
				else if(data.success == 0)
				{
					alert("사용자 정보가 없습니다. 다시 로그인 해주세요.");
					location.replace("login.jsp");				
				}
				else if(data.success == 3)
				{
					alert("비밀번호가 틀렸습니다.");
					location.reload();
				}
				else 
				{
					alert("회원탈퇴에 실패했습니다.");
					location.reload();		
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
<body onload="begin()">
	<div align=right>
<font class = "font2"><br>
		<input type="button" value="LogOut" onClick="location.href='user?action=logout'" class="button_style">&nbsp| 
		<input type="button" value="회원정보" onClick="location.href='user?action=user_info'" class="button_style">
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

	<div class="font4">
		<center>
			<br>
			<H4>회원탈퇴</H4>
		</center>
	</div>
	<div class="font3">
		<form name="myform" method="post" action="post?action=list"
			id="withdraw">
			<table cellSpacing=1 cellPadding=1 width="300" align="center">
				<tr height="30">
					<td width="500" align="center">비밀번호</td>
					<td width="200" align="center"><input type="password"
						name="user_pw" id="user_pw" size="15" maxlength="12"></td>
				</tr>
				<tr height="10"></tr>
				<tr height="30">
					<td colspan="2" align="center"><input type="submit"
						name="withdraw" value="회원탈퇴" OnClick="checkIt()" class="button_style2">&nbsp;&nbsp;
						<input type="button" value="취 소" OnClick="jsp:history.back(-1)" class="button_style2"></td>
				</tr>

			</table>
		</form>
	</div>
</body>
</html>