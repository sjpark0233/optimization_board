<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원탈퇴</title>

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
	<input type="button" value="최적화팀 게시판" onClick="location.href='user?action=showCalendar'" id="main_button">
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