<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ������ ������</title>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>

<script language="javascript">
	var count = 0;

	function idCheck() {

		var text = $("#user_id").val();

		var regexp = /[0-9a-zA-Z]/; // ����,����,Ư������
		// var regexp = /[0-9]/; // ���ڸ�
		//         var regexp = /[a-zA-Z]/; // ������

		for (var i = 0; i < text.length; i++) {
			if (text.charAt(i) != " " && regexp.test(text.charAt(i)) == false) {
				alert("�ѱ��̳� Ư�����ڴ� �ԷºҰ��� �մϴ�.");
				return false;
			} else if (text.length > 10 || text.length < 5) {
				alert("���̵�� 5~15�� �̳��� ������ּ���.");
				return false;
			}
		}
		overlapCheck();
	}

	function overlapCheck() {
		var param = "user_id" + "=" + $("#user_id").val();
		if ($("#user_id").val() == '' || $("#user_id").val() == null) {
			alert("���̵� �Է��ϼ���");
			return false;
		}

		$.ajax({
			url : "user?action=user_check",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",

			success : function(responseData) {
				var data = JSON.parse(responseData);
				if (data != null) {
					count = 1;
					alert("��� ������ ���̵��Դϴ�");
				} else {
					count = 0;
					alert("�ߺ��Ǵ� ���̵��Դϴ�");
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

	function joinCheck() {
		var user_id = document.getElementById('user_id');
		var user_pw = document.getElementById('user_pw');
		var user_pw2 = document.getElementById('user_pw2');
		var user_name = document.getElementById('user_name');
		var team_name = document.getElementById('team_name');
		var tel1 = document.getElementById('tel1');
		var tel2 = document.getElementById('tel2');
		var tel3 = document.getElementById('tel3');
		var user_email = document.getElementById('user_email');

		if (user_id.value == '' || user_id.value == null) {
			alert('���̵� �Է��ϼ���');
			focus.user_id;
			return false;
		}

		if (count == 0) {
			alert("���̵� �ߺ��� Ȯ���ϼ���");
			return false;
		}

		if (user_pw.value == '' || user_pw.value == null) {
			alert('��й�ȣ�� �Է��ϼ���');
			focus.user_pw;
			return false;
		}

		if (user_pw.value.length<5|| user_pw.value.length>10) {
			alert('��й�ȣ�� 5~10�� ���̷� �Է����ּ���.');
			focus.user_pw;
			return false;
		}

		if (user_pw2.value == '' || user_pw2.value == null) {
			alert('��й�ȣȮ�ζ��� �Է��ϼ���');
			focus.user_pw2;
			return false;
		}

		/*��й�ȣ�� ��й�ȣȮ�ζ� ������ Ȯ��*/
		if (user_pw.value != user_pw2.value) {
			alert("��й�ȣ�� ��й�ȣ Ȯ�ζ��� �ٸ��ϴ�");
			focus.user_pw;
			return false;
		}

		if (user_name.value == '' || user_name.value == null) {
			alert('�̸��� �Է��ϼ���');
			focus.user_name;
			return false;
		}

		if (user_name.value.length > 4) {
			alert('����ε� �̸��� �Է����ּ���.');
			focus.user_name;
			return false;
		}

		if (team_name.value == '' || team_name.value == null) {
			alert('���� �Է��ϼ���');
			focus.team_name;
			return false;
		}

		if (team_name.value.length > 15) {
			alert('�� �̸��� 15�� �̳��� �Է����ּ���.');
			focus.team_name;
			return false;
		}

		/*�ڵ��� ��ȣ ���� üũ*/
		if (tel2.value.length <= 2 || tel3.value.length != 4) {
			alert("�޴�����ȣ�� ����� �Է����ּ���");
			focus.hp2;
			return false;
		}
		/*�ڵ����� ���ڸ� ������ üũ*/
		if (isNaN(tel2.value) || isNaN(tel3.value)) {
			alert("�޴�����ȣ�� ���ڸ� �� �� �ֽ��ϴ�.");
			return false;
		}
		/**/
		if (tel2.value.length > 2 || tel3.value.length == 4) {
			document.getElementById("user_phone").value = tel1.value + "-"
					+ tel2.value + "-" + tel3.value;
			;
		}

		if (user_email.value == '' || user_email.value == null) {
			alert('������ �Է��ϼ���');
			focus.user_email;
			return false;
		}

		if (user_email.value.length > 20) {
			alert('����ε� ���� �ּҸ� �Է����ּ���.');
			focus.user_email;
			return false;
		}

		else {
			save();
		}

	}

	function init() {
		count = 0;
	}

	function save() {
		var param = "user_id" + "=" + $("#user_id").val() + "&" + "user_pw"
				+ "=" + $("#user_pw").val() + "&" + "user_name" + "="
				+ $("#user_name").val() + "&" + "team_name" + "="
				+ $("#team_name").val() + "&" + "user_phone" + "="
				+ $("#user_phone").val() + "&" + "user_email" + "="
				+ $("#user_email").val();
		$.ajax({
			url : "user?action=join",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",

			success : function(responseData) {
				var data = JSON.parse(responseData);
				if (data != null) {
					alert("ȸ������ �Ǿ����ϴ�.");
					location.replace("post?action=list");
				} else {
					alert("ȸ�����Կ� �����߽��ϴ�.");
					location.replace("post?action=list");
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

	function countCheck() {
		if (count == 1) {
			count = 0;
		}
	}
</script>

</head>

<body>
	<div align=right>
		<font class="font2"><br> 
			<input type="button" value="LogIn" onClick="location.href='login.jsp'" class="button_style">&nbsp;| 
			<input type="button" value="ȸ������" onClick="location.href='join.jsp'" class="button_style">
		</font>
	</div>

	<div>
		<font class="font1"> ����ȭ�� �Խ��� </font> <br> <br>
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
			<H4>ȸ������</H4>
		</center>
	</div>
	<div class="font3" align="center">
		<form name="joinform" method="post" action="user" id="join">
			<table border="3">
				<tr>
					<td width="200">&nbsp;���̵�</td>
					<td width="450">&nbsp; <input type="text" id="user_id" name="user_id" autofocus required style="width: 40%;">&nbsp;&nbsp;&nbsp;
						<input type="button" value="���̵� �ߺ�Ȯ��" onClick="idCheck()" size="15" class="button_style2" maxlength="12">


					</td>
				</tr>
				<tr>
					<td>&nbsp;��й�ȣ</td>
					<td>&nbsp;&nbsp;<input type="password" id="user_pw" style="width: 40%;" name="user_pw" size="15" maxlength="12">
					</td>
				</tr>

				<tr>
					<td>&nbsp;��й�ȣ �ߺ�Ȯ��</td>
					<td>&nbsp;&nbsp;<input type="password" id="user_pw2" style="width: 40%;" name="user_pw2" size="15" maxlength="12">
					</td>
				</tr>

				<tr>
					<td>&nbsp;�̸�</td>
					<td>&nbsp;&nbsp;<input type="text" id="user_name" style="width: 40%;" name="user_name" size="15" maxlength="12">
					</td>
				</tr>

				<tr>
					<td>&nbsp;�Ҽ�</td>
					<td>&nbsp;&nbsp;<input type="text" id="team_name" style="width: 40%;" name="team_name" size="15" maxlength="12">
						��
					</td>
				</tr>

				<tr>
					<td>&nbsp;��ȭ��ȣ</td>
					<td>&nbsp; <select id="tel1" name="tel1">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
					</select> - 
						<input type="text" id="tel2" name="tel2" size="5" maxlength="4"> - 
						<input type="text" id="tel3" name="tel3" size="5" maxlength="4">
						<input type=hidden id="user_phone" name="user_phone">
					</td>
				</tr>

				<tr>
					<td>&nbsp;E-Mail</td>
					<td>&nbsp;&nbsp;<input type="text" id="user_email" style="width: 50%;" name="user_email">
					</td>
				</tr>
			</table>

			<br> <input type="button" name="join" value="ȸ������" Onclick="joinCheck()" class="button_style2">&nbsp; 
			<input type="reset" value="�ٽ��Է�" onclick='init()' class="button_style2">&nbsp;
			<input type="button" name="cancel" value="���" onClick="jsp:history.back(-1)" class="button_style2">
		</form>
	</div>
</body>
</html>