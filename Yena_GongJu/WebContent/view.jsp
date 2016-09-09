<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="ldcc.board.vo.*"%>
<%
	// 로그인 여부
	Object userObj = request.getSession().getAttribute("user");
	boolean loggedIn = userObj != null && userObj instanceof User;

	//현재 게시판 텝 번호
	int tabCode = 0;
	if (request.getAttribute("tab_code") != null) {
		tabCode = ((Integer) request.getAttribute("tab_code")).intValue();
	}
	
	Post post = (Post) request.getAttribute("post"); // 게시물 객체
	String boardName = (String) request.getAttribute("board_name"); // 지금 보고있는 게시물 파트명
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글 읽기</title>

<style type="text/css">
<!--
body {
	margin: 0;
	padding: 0;
	font: 11px/1.5em Verdana;
}

.font1 {
	font: bold 30px Verdana, sans-serif;
	color: #000;
	margin: 0px;
	padding: 5px 20px 15px 20px;
}

.font2 {
	font: bold 14px Verdana, sans-serif;
	color: #000;
	margin: 0px;
	padding: 0px 20px 0px 0px;
}

.font3 {
	font: 20px Verdana, sans-serif;
	color: #000;
	margin: 0;
	padding: 5% 20% 15% 20%;
}

h2 {
	font: bold 14px Verdana, Arial, Helvetica, sans-serif;
	color: #000;
	margin: 0px;
	padding: 0px 0px 0px 15px;
}

/*- Menu Tabs F--------------------------- */
#tabsF {
	float: left;
	width: 100%;
	background: #fff;
	font-size: 93%;
	line-height: normal;
	border-bottom: 1px solid #666;
}

#tabsF ul {
	margin: 0;
	padding: 10px 10px 0 50px;
	list-style: none;
}

#tabsF li {
	display: inline;
	margin: 0;
	padding: 0;
}

#tabsF a {
	float: left;
	background:
		url(http://pds7.egloos.com/pds/200803/09/83/b0050083_47d2b60bb22d2.gif)
		no-repeat left top;
	margin: 0;
	padding: 0 0 0 4px;
	text-decoration: none;
}

#tabsF a span {
	float: left;
	display: block;
	background:
		url(http://pds8.egloos.com/pds/200803/09/83/b0050083_47d2b60d5f78a.gif)
		no-repeat right top;
	padding: 5px 15px 4px 6px;
	color: #666;
}
/* Commented Backslash Hack hides rule from IE5-Mac \*/
#tabsF a span {
	float: none;
}
/* End IE5-Mac hack */
#tabsF a:hover span {
	color: #FFF;
}

#tabsF a:hover {
	background-position: 0% -42px;
}

#tabsF a:hover span {
	background-position: 100% -42px;
}

#tabsF #current a {
	background-position: 0% -42px;
}

#tabsF #current a span {
	background-position: 100% -42px;
}
-->
</style>

</head>
<body>
	<div align=right>
		<br> <font class="font2">
			<%
				if (loggedIn) {
			%><a href="user?action=logout">LogOut</a>
			<%
				if (((User) userObj).getUser_accept() == 3) {
			%> | <a href="user?action=user_info">회원정보확인</a>
			<%
				} else {
			%> | <a href="user?action=user_list">회원관리</a>
			<%
				}
				} else {
			%><a href="login.jsp">LogIn</a> | <a href="join.jsp">회원가입</a>
			<%
				}
			%>
		</font>
	</div>

	<div>
		<font class="font1"> 최적화팀 게시판 </font> <br> <br>
	</div>

	<div id="tabsF">
		<ul>
			<b>
				<li <%if (tabCode == 0) {%> id="current" <%}%>><a
					href="post?action=list"><span>Home</span></a></li>
				<li <%if (tabCode == 1) {%> id="current" <%}%>><a
					href="post?action=list&tab_code=1"><span>Windows</span></a></li>
				<li <%if (tabCode == 2) {%> id="current" <%}%>><a
					href="post?action=list&tab_code=2"><span>MS SQL</span></a></li>
				<li <%if (tabCode == 3) {%> id="current" <%}%>><a
					href="post?action=list&tab_code=3"><span>Oracle</span></a></li>
				<li <%if (tabCode == 4) {%> id="current" <%}%>><a
					href="post?action=list&tab_code=4"><span>Network</span></a></li>
				<li <%if (tabCode == 5) {%> id="current" <%}%>><a
					href="post?action=list&tab_code=5"><span>SAP</span></a></li>
			</b>
		</ul>
	</div>

	<div class="font3">
		<table align="center">
			<tr>
				<td>
					<table align="center">
						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">글번호</td>
							<td align="center" width="1000"><%=post.getPost_code()%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">분류</td>
							<td align="center" width="1000"><%=boardName%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">조회수</td>
							<td align="center" width="1000"><%=post.getPost_view()%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">게시물타입</td>
							<td align="center" width="1000"><%=post.getPost_type() == 0 ? "공지" : "일반"%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">작성일</td>
							<td align="center" width="1000"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(post.getPost_date())%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">제목</td>
							<td align="center" width="1000"><%=post.getPost_title()%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">첨부파일</td>
							<td align="center" width="1000">
								<%
									if (post.getPost_filepath() != null && !post.getPost_filepath().equals("")) {
								%> <a href="./upload/<%=post.getPost_filepath()%>"><%=post.getPost_filepath()%></a>
								<%
									}
								%>
							</td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">내용</td>
							<td valign="top" width="1000" colspan="2" height="300"><%=post.getPost_content()%></td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>
						<tr height="1" bgcolor="#82B5DF">
							<td colspan="4" width="407"></td>
						</tr>

						<table>
							<tr>
								<td>
									<p>
										<textarea cols="100%" rows="4"></textarea>
									<p>
										<button type="button">댓글 달기</button>
								</td>
							</tr>
						</table>

						<table align="right">
							<tr height="10"></tr>
							<tr>
								<td width="0">&nbsp;</td>
								<td colspan="2"><input type=button value="글쓰기"
									OnClick="location.href='post?action=show_write<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>'">
									<input type=button value="목록"
									OnClick="location.href='post?action=list<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>'">
									<input type=button value="수정"
									OnClick="location.href='post?action=show_modify<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>'">
									<input type=button value="삭제"
									OnClick="location.href='post?action=delete<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>'">
								<td width="0">&nbsp;</td>
							</tr>
						</table>
					</table>

				</td>
			</tr>
		</table>
</body>
</html>