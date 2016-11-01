<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ��Ż��</title>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
<script language="javascript"> 
 
	function begin() {
		document.myform.user_pw.focus();
	}

	function checkIt() {
		if (!document.myform.user_pw.value) {
			alert("��й�ȣ�� �Է����� �����̽��ϴ�.");
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
					alert("ȸ��Ż�� �Ǿ����ϴ�.");	
					alert("ù ȭ������ ���ư��ϴ�.");		
					location.replace("post?action=list");				
				}
				else if(data.success == 0)
				{
					alert("����� ������ �����ϴ�. �ٽ� �α��� ���ּ���.");
					location.replace("login.jsp");				
				}
				else if(data.success == 3)
				{
					alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
					location.reload();
				}
				else 
				{
					alert("ȸ��Ż�� �����߽��ϴ�.");
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
		<input type="button" value="ȸ������" onClick="location.href='user?action=user_info'" class="button_style">
		</font>
	</div>


	<div>
	<input type="button" value="����ȭ�� �Խ���" onClick="location.href='user?action=showCalendar'" id="main_button">
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

	<div class="font4">
		<center>
			<br>
			<H4>ȸ��Ż��</H4>
		</center>
	</div>
	<div class="font3">
		<form name="myform" method="post" action="post?action=list"
			id="withdraw">
			<table cellSpacing=1 cellPadding=1 width="300" align="center">
				<tr height="30">
					<td width="500" align="center">��й�ȣ</td>
					<td width="200" align="center"><input type="password"
						name="user_pw" id="user_pw" size="15" maxlength="12"></td>
				</tr>
				<tr height="10"></tr>
				<tr height="30">
					<td colspan="2" align="center"><input type="submit"
						name="withdraw" value="ȸ��Ż��" OnClick="checkIt()" class="button_style2">&nbsp;&nbsp;
						<input type="button" value="�� ��" OnClick="jsp:history.back(-1)" class="button_style2"></td>
				</tr>

			</table>
		</form>
	</div>
</body>
</html>