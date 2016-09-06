<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원탈퇴</title>
</head>

<% 
 String id = (String)session.getAttribute("id"); 
 String passwd = request.getParameter("pw"); 
 LogonDBBean manager = LogonDBBean.getInstance(); 

 int check = manager.deleteMember(id,pw); 

 if(check==1){ 
	 session.invalidate(); 
	 }
%> 

<body>

	<form method="post" action="list_main.jsp" name="userinput">
	
		<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
			<tr>
				<td height="39" align="center"><font size="+1"><b>회원정보가 삭제되었습니다.</b></font></td>
			</tr>

			<tr>
				<td align="center">
					<p>안녕히 가세요.</p>
					<meta http-equiv="Refresh" content="5; url=list_main.jsp">
				</td>
			</tr>
			
			<tr>
				<td align="center"><input type="submit" value="확인"></td>
			</tr>
		</table>

	</form>

	<%}else {%>

	<script language="javascript">
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>

	<%}%>

</body>
</html>