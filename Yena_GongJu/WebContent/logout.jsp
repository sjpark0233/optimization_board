<%@ page language="java" conrmtentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그아웃</title>
</head>
<body>

 <h1>로그아웃 페이지</h1>
    <h2>logout.jsp</h2>
   
    <% 
    session.invalidate();
    response.sendRedirect("list_main.jsp");
    %>

</body>
</html>