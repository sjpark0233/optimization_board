<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="ldcc.board.vo.*"%>
<% String phone = ((User)request.getAttribute("result")).getUser_phone().split("-")[0];%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ������ ���� ������</title>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
<script language="javascript">
function InfoCheck(){
	var user_pw0 = document.getElementById('user_pw0');
	var user_pw = document.getElementById('user_pw');
	var user_pw2 = document.getElementById('user_pw2');
	var user_name = document.getElementById('user_name');
	var team_name = document.getElementById('team_name');
	var tel1 = document.getElementById('tel1'); 
	var tel2 = document.getElementById('tel2'); 
	var tel3 = document.getElementById('tel3'); 
	var user_email = document.getElementById('user_email');
	
	if (user_pw0.value == '' || user_pw0.value == null) {
		alert('��й�ȣ�� �Է��ϼ���');
		focus.user_pw;
		return false;
	}
	
	if (user_pw.value != '' && user_pw.value != null) {
		focus.user_pw;
		if (user_pw2.value == '' || user_pw2.value == null) {
			alert('��й�ȣȮ�ζ��� �Է��ϼ���');
			focus.user_pw2;
			return false;
		}
		else
		{
			/*��й�ȣ�� ��й�ȣȮ�ζ� ������ Ȯ��*/
			if (user_pw.value != user_pw2.value){
				alert("�� ��й�ȣ�� �� ��й�ȣ Ȯ�ζ��� �ٸ��ϴ�");
				focus.user_pw;
				return false;
			}

			/*��й�ȣ ���� Ȯ��*/
			if (user_pw.value.length <5){
				alert("��й�ȣ�� 5�� �̻����� �Է����ּ���");
				focus.user_pw;
				return false;
			}
		}
	}
	
	if (user_name.value == '' || user_name.value == null) {
		alert('�̸��� �Է��ϼ���');
		focus.user_name;
		return false;
	}
	
	if (team_name.value == '' || team_name.value == null) {
		alert('���� �Է��ϼ���');
		focus.team_name;
		return false;
	}
	
	/*�ڵ��� ��ȣ ���� üũ*/
	if(tel2.value.length<=2 || tel3.value.length!=4){
		alert("�޴�����ȣ�� ����� �Է����ּ���");
		focus.tel2;
		return false;
	}
		
		/*�ڵ����� ���ڸ� ������ üũ*/
	if(isNaN(tel2.value) || isNaN(tel3.value)){
		alert("�޴�����ȣ�� ���ڸ� �� �� �ֽ��ϴ�");
		return false;
	}
		/**/
	if (tel2.value.length > 2 || tel3.value.length==4){
		document.getElementById("user_phone").value = tel1.value + "-" + tel2.value + "-" + tel3.value;;
	}
		
	if (user_email.value == '' || user_email.value == null){
		alert('������ �Է��ϼ���');
		focus.user_email;
		return false;
	}
	
	else{
		save();
	}
	
}


function save() {
	var param = "user_pw0" + "=" + $("#user_pw0").val() + "&" +"user_pw" + "="+ $("#user_pw").val() + "&" +"user_name" + "="+ $("#user_name").val() + "&" +"team_name" + "="+ $("#team_name").val() + "&" +"user_phone" + "="+ $("#user_phone").val() + "&" +"user_email" + "="+ $("#user_email").val();
	
	$.ajax({
		url : "user?action=user_info_modify",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",

		success : function(responseData) {
			var data = JSON.parse(responseData);
		if(data.success == 1)
		{
			alert("�����Ǿ����ϴ�.");
			location.replace("user?action=user_info");	
		}
		else if(data.success == 0)
		{
			alert("��й�ȣ�� ���� �ʽ��ϴ�.");	
			return false;
		}
		else
		{
			alert("������ �����߽��ϴ�.");
			return false;				
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
		<input type="button" value="LogOut" onClick="location.href='user?action=logout'" class="button_style">&nbsp| 
		<input type="button" value="ȸ������" onClick="location.href='user?action=user_info'" class="button_style">
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

	<div class="font4">
		<center>
			<br>
			<H4>ȸ����������</H4>
		</center>
	</div>

	<div class="font3" align="center">
		<form name="modify" method="post" action="user" id="user_info_modify">
			<table border="3">
				<tr>
					<td>&nbsp;���̵�&nbsp;</td>
					<td width="1000">&nbsp;&nbsp;${result.user_id}</td>
				</tr>
				<tr>
					<td>&nbsp;���� ��й�ȣ&nbsp;</td>
					<td>&nbsp;&nbsp;<input type="password" name="user_pw0"
						size="15" maxlength="12" id="user_pw0">
					</td>
				</tr>
				<tr>
					<td>&nbsp;�� ��й�ȣ&nbsp;</td>
					<td>&nbsp;&nbsp;<input type="password" name="user_pw"
						size="15" maxlength="12" id="user_pw">
					</td>
				</tr>

				<tr>
					<td>&nbsp;�� ��й�ȣ Ȯ��&nbsp;</td>
					<td>&nbsp;&nbsp;<input type="password" name="user_pw2"
						size="15" maxlength="12" id="user_pw2">
					</td>
				</tr>

				<tr>
					<td>&nbsp;�̸�&nbsp;</td>
					<td>&nbsp;&nbsp;<input type="text" name="user_name" size="15"
						maxlength="12" id="user_name" value=${result.user_name}>
					</td>
				</tr>

				<tr>
					<td>&nbsp;�Ҽ�&nbsp;</td>
					<td>&nbsp;&nbsp;<input type="text" name="team_name" size="15"
						maxlength="12" id="team_name" value=${result.team_name}>��
					</td>

				</tr>
				<tr>
					<td>&nbsp;��ȭ��ȣ</td>
					<td>&nbsp; <select name="tel1" id="tel1">
							<option value="010" <% if(phone.equals("010")){%>
								selected="selected" <%}%>>010</option>
							<option value="011" <% if(phone.equals("011")){%>
								selected="selected" <%}%>>011</option>
							<option value="016" <% if(phone.equals("016")){%>
								selected="selected" <%}%>>016</option>
							<option value="017" <% if(phone.equals("017")){%>
								selected="selected" <%}%>>017</option>
							<option value="018" <% if(phone.equals("018")){%>
								selected="selected" <%}%>>018</option>
							<option value="019" <% if(phone.equals("019")){%>
								selected="selected" <%}%>>019</option>
					</select> - <input type="text" name="tel2" size="5" maxlength="4" id="tel2"
						value=${result.user_phone.split('-')[1]}> - <input
						type="text" name="tel3" size="5" maxlength="4" id="tel3"
						value=${result.user_phone.split('-')[2]}> <input
						type=hidden id="user_phone" name="user_phone">
					</td>
				</tr>

				<tr>
					<td>&nbsp;E-Mail&nbsp;</td>
					<td>&nbsp;&nbsp;<input type="text" name="user_email"
						value=${result.user_email } id="user_email">
					</td>
				</tr>
			</table>

			<br> <input type="button" value="�����ϱ�" Onclick="InfoCheck()" class="button_style2">
			<input type="button" name="cancel" value="���"
				onClick="jsp:history.back(-1)" class="button_style2">
		</form>

	</div>

</body>
</html>