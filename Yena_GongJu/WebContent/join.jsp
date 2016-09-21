<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입 페이지</title>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>

<script language="javascript">
	var count = 0;

	function idCheck() {

		var text = $("#user_id").val();

		var regexp = /[0-9a-zA-Z]/; // 숫자,영문,특수문자
		// var regexp = /[0-9]/; // 숫자만
		//         var regexp = /[a-zA-Z]/; // 영문만

		for (var i = 0; i < text.length; i++) {
			if (text.charAt(i) != " " && regexp.test(text.charAt(i)) == false) {
				alert("한글이나 특수문자는 입력불가능 합니다.");
				return false;
			} else if (text.length > 10 || text.length < 5) {
				alert("아이디는 5~15자 이내로 만들어주세요.");
				return false;
			}
		}
		overlapCheck();
	}

	function overlapCheck() {
		var param = "user_id" + "=" + $("#user_id").val();
		if ($("#user_id").val() == '' || $("#user_id").val() == null) {
			alert("아이디를 입력하세요");
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
					alert("사용 가능한 아이디입니다");
				} else {
					count = 0;
					alert("중복되는 아이디입니다");
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
			alert('아이디를 입력하세요');
			focus.user_id;
			return false;
		}

		if (count == 0) {
			alert("아이디 중복을 확인하세요");
			return false;
		}

		if (user_pw.value == '' || user_pw.value == null) {
			alert('비밀번호를 입력하세요');
			focus.user_pw;
			return false;
		}

		if (user_pw.value.length<5|| user_pw.value.length>10) {
			alert('비밀번호는 5~10자 사이로 입력해주세요.');
			focus.user_pw;
			return false;
		}

		if (user_pw2.value == '' || user_pw2.value == null) {
			alert('비밀번호확인란을 입력하세요');
			focus.user_pw2;
			return false;
		}

		/*비밀번호와 비밀번호확인란 같은지 확인*/
		if (user_pw.value != user_pw2.value) {
			alert("비밀번호와 비밀번호 확인란이 다릅니다");
			focus.user_pw;
			return false;
		}

		if (user_name.value == '' || user_name.value == null) {
			alert('이름을 입력하세요');
			focus.user_name;
			return false;
		}

		if (user_name.value.length > 4) {
			alert('제대로된 이름을 입력해주세요.');
			focus.user_name;
			return false;
		}

		if (team_name.value == '' || team_name.value == null) {
			alert('팀을 입력하세요');
			focus.team_name;
			return false;
		}

		if (team_name.value.length > 15) {
			alert('팀 이름은 15자 이내로 입력해주세요.');
			focus.team_name;
			return false;
		}

		/*핸드폰 번호 길이 체크*/
		if (tel2.value.length <= 2 || tel3.value.length != 4) {
			alert("휴대폰번호를 제대로 입력해주세요");
			focus.hp2;
			return false;
		}
		/*핸드폰이 숫자만 들어가는지 체크*/
		if (isNaN(tel2.value) || isNaN(tel3.value)) {
			alert("휴대폰번호는 숫자만 들어갈 수 있습니다.");
			return false;
		}
		/**/
		if (tel2.value.length > 2 || tel3.value.length == 4) {
			document.getElementById("user_phone").value = tel1.value + "-"
					+ tel2.value + "-" + tel3.value;
			;
		}

		if (user_email.value == '' || user_email.value == null) {
			alert('메일을 입력하세요');
			focus.user_email;
			return false;
		}

		if (user_email.value.length > 20) {
			alert('제대로된 메일 주소를 입력해주세요.');
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
					alert("회원가입 되었습니다.");
					location.replace("post?action=list");
				} else {
					alert("회원가입에 실패했습니다.");
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
			<input type="button" value="회원가입" onClick="location.href='join.jsp'" class="button_style">
		</font>
	</div>

	<div>
		<font class="font1"> 최적화팀 게시판 </font> <br> <br>
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
			<H4>회원가입</H4>
		</center>
	</div>
	<div class="font3" align="center">
		<form name="joinform" method="post" action="user" id="join">
			<table border="3">
				<tr>
					<td width="200">&nbsp;아이디</td>
					<td width="450">&nbsp; <input type="text" id="user_id" name="user_id" autofocus required style="width: 40%;">&nbsp;&nbsp;&nbsp;
						<input type="button" value="아이디 중복확인" onClick="idCheck()" size="15" class="button_style2" maxlength="12">


					</td>
				</tr>
				<tr>
					<td>&nbsp;비밀번호</td>
					<td>&nbsp;&nbsp;<input type="password" id="user_pw" style="width: 40%;" name="user_pw" size="15" maxlength="12">
					</td>
				</tr>

				<tr>
					<td>&nbsp;비밀번호 중복확인</td>
					<td>&nbsp;&nbsp;<input type="password" id="user_pw2" style="width: 40%;" name="user_pw2" size="15" maxlength="12">
					</td>
				</tr>

				<tr>
					<td>&nbsp;이름</td>
					<td>&nbsp;&nbsp;<input type="text" id="user_name" style="width: 40%;" name="user_name" size="15" maxlength="12">
					</td>
				</tr>

				<tr>
					<td>&nbsp;소속</td>
					<td>&nbsp;&nbsp;<input type="text" id="team_name" style="width: 40%;" name="team_name" size="15" maxlength="12">
						팀
					</td>
				</tr>

				<tr>
					<td>&nbsp;전화번호</td>
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

			<br> <input type="button" name="join" value="회원가입" Onclick="joinCheck()" class="button_style2">&nbsp; 
			<input type="reset" value="다시입력" onclick='init()' class="button_style2">&nbsp;
			<input type="button" name="cancel" value="취소" onClick="jsp:history.back(-1)" class="button_style2">
		</form>
	</div>
</body>
</html>