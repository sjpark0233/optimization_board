<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>아이디 중복 확인</title>

 <script>
	function idChkClose() 
	{ // 메인폼에 검색한 아이디를 표시
		opener.document.joinform.value="myID"		
	  // 현재창 닫기
		window.close();
		//self.close();
	}
 </script>

</head>
<body>
<!-- 수정필요(중복값있을 때는 중복되는 아이디라고 떠야함) -->
	<div align="center"> </div>당신이 입력한 아이디는 사용가능한 <br>아이디 입니다.<p>
  <div align="right">
  <input type="button" value="Close" onClick="idChkClose()">
  </div>
</body>

</body>
</html>