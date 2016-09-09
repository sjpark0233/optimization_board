<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="ldcc.board.vo.*"%>
<%
	// 로그인 여부
	Object user = request.getSession().getAttribute("user");
	boolean loggedIn = user != null && user instanceof User;

	//현재 게시판 텝 번호
	int tabCode = 0;
	if (request.getAttribute("tab_code") != null) {
		tabCode = (Integer) request.getAttribute("tab_code");
	}

	// 게시물 객체
	Post post = (Post) request.getAttribute("post");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글 수정</title>

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
	margin: 0px;
	padding: 0px 20px 0px 0px;
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


<script language="javascript">
	function fileReset() {
		var form = document.modifyform;
		form.post_filepath.value = "";
		form.file_edited.value = "true";
	}
	function fileOnChange() {
		var form = document.modifyform;
		form.file_edited.value = "true";
	}
	function modifyCheck() {
		var form = document.modifyform;

		if (!form.post_title.value) {
			alert("제목을 적어주세요");
			form.post_title.focus();
			return;
		}

		if (!form.post_content.value) {
			alert("내용을 적어주세요");
			form.post_content.focus();
			return;
		}

		form.submit();
	}
</script>

</head>
<body>

	<div align=right>
		<%
			if (loggedIn) {
		%>
		<font class="font2"> <a href="user?action=logout">LogOut</a> |
			<a href="user?action=user_info">회원정보확인</a>
		</font>
		<%
			} else {
		%>
		<font class="font2"> <a href="login.jsp">LogIn</a> | <a
			href="join.jsp">회원가입</a>
		</font>
		<%
			}
		%>
	</div>

	<div>
		<font class="font1"> 최적화팀 게시판 </font> <br> <br>
	</div>

	<div id="tabsF">
		<ul>
			<b>
				<li <%if (tabCode == 0) {%> id="current" <%}%>><a
					href="post?action=list_all"><span>Home</span></a></li>
				<li <%if (tabCode == 1) {%> id="current" <%}%>><a
					href="post?action=list_all&board_code=1"><span>Windows</span></a></li>
				<li <%if (tabCode == 2) {%> id="current" <%}%>><a
					href="post?action=list_all&board_code=2"><span>MS SQL</span></a></li>
				<li <%if (tabCode == 3) {%> id="current" <%}%>><a
					href="post?action=list_all&board_code=3"><span>Oracle</span></a></li>
				<li <%if (tabCode == 4) {%> id="current" <%}%>><a
					href="post?action=list_all&board_code=4"><span>Network</span></a></li>
				<li <%if (tabCode == 5) {%> id="current" <%}%>><a
					href="post?action=list_all&board_code=5"><span>SAP</span></a></li>
			</b>
		</ul>
	</div>

	<div class="font3">
		<table align="center">
			<form name=modifyform method=post
				action="post?action=modify<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>"
				enctype="multipart/form-data">
			<tr>
				<td>&nbsp;</td>
				<td align="center">분류</td>
				<td><select name="board_code" size="1">
						<option value=1 <%if (post.getBoard_code() == 1) {%>
							selected="selected" <%}%>>Windows</option>
						<option value=2 <%if (post.getBoard_code() == 2) {%>
							selected="selected" <%}%>>MS SQL</option>
						<option value=3 <%if (post.getBoard_code() == 3) {%>
							selected="selected" <%}%>>Oracle</option>
						<option value=4 <%if (post.getBoard_code() == 4) {%>
							selected="selected" <%}%>>Network</option>
						<option value=5 <%if (post.getBoard_code() == 5) {%>
							selected="selected" <%}%>>SAP</option>
				</select>
				<td>&nbsp;</td>
			</tr>
			<tr height="1" bgcolor="#dddddd">
				<td colspan="4"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="center">제목</td>
				<td><input name="post_title" size="100%" maxlength="100"
					value=<%=post.getPost_title()%>></td>
				<td>&nbsp;</td>
			</tr>
			<tr height="1" bgcolor="#dddddd">
				<td colspan="4"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="center">게시물타입</td>
				<td><input type="radio" name="post_type" value=0
					<%if (post.getPost_type() == 0) {%> checked="checked" <%}%>>공지
					<input type="radio" name="post_type" value=1
					<%if (post.getPost_type() == 1) {%> checked="checked" <%}%>>일반
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr height="1" bgcolor="#dddddd">
				<td colspan="4"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="center">파일업로드</td>
				<td><input type="file" name="post_filepath"
					onChange="fileOnChange()"> <input type=button value="Reset"
					onClick="fileReset()"><input type="hidden"
					name="file_edited" value="false"></td>
				<td>&nbsp;</td>
			</tr>
			<tr height="1" bgcolor="#dddddd">
				<td colspan="4"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="center">내용</td>
				<br>
				<td><textarea name="post_content" cols="100%" rows="20%"><%=post.getPost_content()%></textarea></td>
				<td>&nbsp;</td>
			</tr>
			<tr height="1" bgcolor="#dddddd">
				<td colspan="4"></td>
			</tr>
			<tr height="1" bgcolor="#82B5DF">
				<td colspan="4"></td>
			</tr>
			<tr align="center">
				<td>&nbsp;</td>
				<td colspan="2"><input type=button value="수정"
					onClick="modifyCheck()"> <input type=button value="취소"
					onClick="jsp:history.back(-1)">
				<td>&nbsp;</td>
			</tr>
			</form>
		</table>
		</td>
		</tr>
		</table>

	</div>


</body>
</html>