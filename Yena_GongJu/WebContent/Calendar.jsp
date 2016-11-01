<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="ldcc.board.vo.*"%>
<%
	List<User> userList = (List<User>) request.getAttribute("result");

	//로그인 여부
	Object userObj = request.getSession().getAttribute("user");
	boolean loggedIn = userObj != null && userObj instanceof User;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>사용자 리스트_관리자용</title>
<script language="javascript">

function user_accept(){
	var str3 = document.getElementById('accept');
	str3.submit();
}
function team_accept(){
	var str3 = document.getElementById('team_accept');
	str3.submit();
}

</script>

</head>

<body>

	<!-- 상단 -->
	<div align=right>
		<br> <font class="font2"> <%
 	if (loggedIn) {
 %><input type="button" value="LogOut"
			onClick="location.href='user?action=logout'" class="button_style">
			<%
				if (((User) userObj).getUser_accept() == 3) {
			%> | <input type="button" value="회원관리"
			onClick="location.href='user?action=user_list'" class="button_style">
			<%
				} else {
			%> | <input type="button" value="회원정보"
			onClick="location.href='user?action=user_info'" class="button_style">
			<%
				}
				} else {
			%><input type="button" value="LogIn"
			onClick="location.href='login.jsp'" class="button_style">&nbsp|
			<input type="button" value="회원가입" onClick="location.href='join.jsp'"
			class="button_style"> <%
 	}
 %>
		</font>
	</div>

	<div>
		<font class="font1"> 
		<input type="button" value="최적화팀 게시판" onClick="location.href='user?action=showCalendar'" id="main_button">
		</font> 
		<br>
		<br>
	</div>

	<!-- 탭 -->
	<div id="tabsF">
		<ul>
			<b>
				<li><a href="post?action=list"><span>Home</span></a></li>
				<li><a href="post?action=list&tab_code=1"><span>Windows</span></a></li>
				<li><a href="post?action=list&tab_code=2"><span>MS
							SQL</span></a></li>
				<li><a href="post?action=list&tab_code=3"><span>Oracle</span></a></li>
				<li><a href="post?action=list&tab_code=4"><span>Network</span></a></li>
				<li><a href="post?action=list&tab_code=5"><span>SAP</span></a></li>
			</b>
		</ul>
	</div>

	<!-- 목록 -->
	<div id="calendar">			
	<iframe src="https://calendar.google.com/calendar/embed?src=u9rjd2p8l2hbmc5lnd24015um0%40group.calendar.google.com&ctz=Asia/Seoul" style="border: 0" width="1000" height="750" frameborder="0" scrolling="no"></iframe>	</div>
</body>
</html>