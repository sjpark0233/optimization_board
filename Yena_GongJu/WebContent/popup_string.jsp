<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script language="javascript">
	function confirm() {
		var input = document.getElementById("input");
		if(!input.value) {
			alert("파일 또는 폴더 명을 입력하세요.");
			return;
		}			

		window.returnValue = input.value;
		window.close();
	}
</script>
</head>
<body>
	<table align=center width=100% height=100% border=1>
		<tr align=center valign=middle height=100%>
			<td width=100% height=100% align=center valign="middle"><input
				type=text id="input"><input type=button value="확인" onclick="confirm()"></td>
		</tr>
	</table>
</body>
</html>