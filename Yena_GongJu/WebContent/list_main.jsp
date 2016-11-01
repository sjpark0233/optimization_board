<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*" %>
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

	// 게시물 리스트 객체
	List<Post> noticeList = (List<Post>) request.getAttribute("notice_list");
	List<Post> postList = (List<Post>) request.getAttribute("post_list");

	// 하단의 게시물 페이지 표시를 위한 변수
	int nowPage = ((Integer) request.getAttribute("page")).intValue();
	int maxPage = ((Integer) request.getAttribute("max_page")).intValue();
	int startPage = ((Integer) request.getAttribute("start_page")).intValue();
	int endPage = ((Integer) request.getAttribute("end_page")).intValue();

	// 검색 결과인 경우를 위한 변수
	int searchType = 0;
	if (request.getAttribute("search") != null) {
		searchType = ((Integer) request.getAttribute("search")).intValue();
	}
	String searchKeyword = "";
	if (request.getAttribute("keyword") != null) {
		searchKeyword = (String) request.getAttribute("keyword");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<link rel="stylesheet" href="main.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판 Main</title>
<script language="javascript">
	function checkSearch(tabCode) {
		var type = document.getElementById("search_type");
		var keyword = document.getElementById("search_keyword");

		if (!keyword.value) {
			alert("검색 내용을 적어주세요.");
			keyword.focus();
			return;
		}

		var keywordStr = encodeURI(keyword.value, 'euc-kr');
		location.href = "post?action=list"
				+
(tabCode != 0 ? "&tab_code=" + tabCode : "")
	+ "&search="
				+ type.value + "&keyword=" + keywordStr;
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
		<input type="button" value="최적화팀 게시판" onClick="location.href='user?action=showCalendar'" id="main_button">
	</div>

	<!-- 탭 -->
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

	<!-- 목록 -->
	<div class="font2">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr height="5">
				<td width="5"></td>
			</tr>
			<tr
				style="background: url('img/table_mid.gif') repeat-x; text-align: center;">
				<td width="5"><img src="img/table_left.gif" width="5"
					height="30" /></td>
				<td width="73">번호</td>
				<td width="379">제목</td>
				<td width="73">작성자</td>
				<td width="164">작성일</td>
				<td width="58">조회수</td>
				<td width="7"><img src="img/table_right.gif" width="5"
					height="30" /></td>
			</tr>

			<!-- 내용부분 -->

			<tr height="10" align="center">
			</tr>
			<%
				for (Post notice : noticeList) {
			%>
			<tr height="5" style="text-align: center;" bgcolor="F3F7FD"></tr>
			<tr style="text-align: center; background-color: #F3F7FD;">
				<td width="5"></td>
				<td width="103">공지</td>
				<td width="349" align="center"><a
					href="post?action=read<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=notice.getPost_code()%>"><%=notice.getPost_title()%></a></td>
				<td width="73"><%=notice.getUser_name()%></td>
				<td width="164"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(notice.getPost_date())%></td>
				<td width="58"><%=notice.getPost_view()%></td>
				<td width="7"></td>
			</tr>
			<tr height="5" style="text-align: center;" bgcolor="F3F7FD"></tr>
			<%
				}
			%>
			<%
				for (Post post : postList) {
			%>
			<tr height="5" align="center"></tr>
			<tr style="text-align: center;">
				<td width="5"></td>
				<td width="103"><%=post.getPost_code()%></td>
				<td width="349" align="center"><a
					href="post?action=read<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>"><%=post.getPost_title()%></a></td>
				<td width="73"><%=post.getUser_name()%></td>
				<td width="164"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(post.getPost_date())%></td>
				<td width="58"><%=post.getPost_view()%></td>
				<td width="7"></td>
			</tr>
			<tr height="5" align="center"></tr>
			<%
				}
			%>
			<tr height="10" align="center"></tr>
			<tr height="1" bgcolor="#D2D2D2">
				<td colspan="6"></td>
			</tr>
			<tr height="1" bgcolor="#82B5DF">
				<td colspan="6" width="752"></td>
			</tr>
		</table>

		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td colspan="4" height="5"></td>
			</tr>
			<tr>
				<td width="20%"></td>
				<td align="center">
					<%
						if (nowPage <= 1) {
					%> [이전]&nbsp; <%
 	} else {
 %> <a
					href="post?action=list<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&page=<%=nowPage - 1%><%=searchType != 0 ? "&search=" + searchType + "&keyword=" + URLEncoder.encode(searchKeyword, "utf-8") : ""%>">[이전]</a>&nbsp;
					<%
						}
					%> <%
 	for (int i = startPage; i <= endPage; i++) {
 		if (i == nowPage) {
 %> [<%=i%>] <%
 	} else {
 %> <a
					href="post?action=list<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&page=<%=i%><%=searchType != 0 ? "&search=" + searchType + "&keyword=" + URLEncoder.encode(searchKeyword, "utf-8") : ""%>">[<%=i%>]
				</a> <%
 	}
 %> <%
 	}
 %> <%
 	if (nowPage >= maxPage) {
 %> [다음] <%
 	} else {
 %> <a
					href="post?action=list<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&page=<%=nowPage + 1%><%=searchType != 0 ? "&search=" + searchType + "&keyword=" + URLEncoder.encode(searchKeyword, "utf-8") : ""%>">[다음]</a>&nbsp;
					<%
						}
					%>
				</td>
				<td width="20%" align="right"><input type=button value="글쓰기"
					class="button_style2"
					onClick="location.href='post?action=show_write<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>'">&nbsp;&nbsp;
				</td>
			</tr>
			<tr align="center">
				<td colspan=3><select id="search_type" name="search_type">
						<option value=1 <%if (searchType == 1) {%> selected="selected"
							<%}%>>번호</option>
						<option value=2 <%if (searchType == 2) {%> selected="selected"
							<%}%>>작성자</option>
						<option value=3 <%if (searchType == 3) {%> selected="selected"
							<%}%>>제목</option>
						<option value=4 <%if (searchType == 4) {%> selected="selected"
							<%}%>>내용</option>
				</select>&nbsp; <input id="search_keyword" name="search_keyword" type=text
					size=40
					onkeydown="javascript:if(event.keyCode==13){ checkSearch(<%=tabCode%>); }" value=<%=searchKeyword %>>&nbsp;
					<input type=button value="검색" onClick="checkSearch(<%=tabCode%>)"></td>
			</tr>
		</table>
	</div>

</body>
</html>