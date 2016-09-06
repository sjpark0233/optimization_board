<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>loginCheck</title>
</head>
<body>
<%
	String myID = "aaaa";
	String myPW = "1111";
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	if(myID.equals(id)){
		if(myPW.equals(pw)){
			//로그인 성공
			response.sendRedirect("list_in.jsp"); // ID PW 일치하면 홈 목록 화면으로 돌아감 -> 값수정필요(원래화면으로 돌아가게)
		}else{
			//비밀번호 틀림
			%>
			<script>
				alert('비밀번호가 틀렸습니다.');
				history.go(-1);
			</script>
			<%
		}
	}else{
			//아이디가 존재하지 않음
			%>
			<script>
				alert('아이디가 틀렸습니다.');
				history.go(-1);
			</script>
		}
		<%
	}
%>


</body>
</html>