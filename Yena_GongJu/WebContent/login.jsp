<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�α���</title>
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
				alert("�α��� �Ǿ����ϴ�.");
				if(data.success==1){
					location.replace("user?action=showCalendar");
				}
				else{
					location.replace("post?action=list");
				}
			}
			else
			{
				var str3 = document.getElementById('login');
				str3.submit();
				alert("���̵� ��й�ȣ�� Ʋ�Ȱų� ������ �����ϴ�.");
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
	<!-- ��� -->
	<div align=right>
		<font class = "font2"><br>
		<input type="button" value="LogIn" onClick="location.href='login.jsp'" class="button_style">&nbsp| 
		<input type="button" value="ȸ������" onClick="location.href='join.jsp'" class="button_style">
		</font>
	</div>
	<div>
		<font class="font1"> ����ȭ�� �Խ��� </font> <br>
		<br>
	</div>
	<!-- �� -->
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
			<H4>�α���</H4>
		</center>
	</div>
	<div class="font3" align="center">
		<form name="login" method="post" action="user" id="login">
			<table align="center" border="3" width="400" height="150"
				border="solid" bordercolor="#333333">
				<tr>
					<td>&nbsp;<label>&nbsp;&nbsp; ���̵� : </label> <input type="text"
						id="user_id" name="user_id" size="15" maxlength="12" style="width:60%;"> <br>
					<br> &nbsp;<label>��й�ȣ : </label> <input type="password"
						id="user_pw" name="user_pw" size="15" maxlength="12" style="width:60%;">
					</td>
				</tr>
			</table>
			<br> &nbsp;<input type="submit" value="�α���"
				onClick='loginCheck()' class="button_style2">&nbsp;&nbsp; <input type="button"
				value="ȸ������" onClick="location.href='join.jsp'" class="button_style2">&nbsp;
		</form>
	</div>
</body>
</html>