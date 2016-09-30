<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
<script language="javascript">
	var opener;

	function init() {
		opener = window.dialogArguments;
	}

	function confirm() {
		var input = document.getElementById("input");
		if (!input.value || input.value == "") {
			alert("파일 또는 폴더 명을 입력하세요.");
			return;
		}

		opener.message = input.value;
		window.close();
	}
</script>
</head>
<body onload="init()">
	<table align=center width=100% height=100% border=1>
		<tr align=center valign=middle height=50%>
			<td width=100% height=50% align=center valign=middle>파일 또는 폴더 명을
				입력하세요.</td>
		</tr>
		<tr align=center valign=middle height=50%>
			<td width=100% height=50% align=center valign="middle"><input
				type=text id="input"><input type=button value="확인"
				onclick="confirm()"></td>
		</tr>
	</table>
</body>
</html>