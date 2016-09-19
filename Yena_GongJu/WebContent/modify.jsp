<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="ldcc.board.vo.*"%>
<%
	// 로그인 여부
	Object userObj = request.getSession().getAttribute("user");
	boolean loggedIn = userObj != null && userObj instanceof User;

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
<link rel="stylesheet" href="main.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글 수정</title>

<script language="javascript">
	function confirmDeleteFile() {
		if (confirm("기존 파일을 삭제하시겠습니까?")) {
			document.getElementById("file_label").style.display = 'none';
			document.getElementById("file_delete").style.display = 'none';
			document.getElementById("post_filepath").style.display = 'block';
			document.modifyform.file_edited.value = "true";
		}
	}

	function fileEdited() {
		document.modifyform.file_edited.value = "true";
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
			onClick="location.href='login.jsp'" class="button_style"> | <input
			type="button" value="회원가입" onClick="location.href='join.jsp'"
			class="button_style"> <%
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
		<form name=modifyform method=post
			action="post?action=modify<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>"
			enctype="multipart/form-data">
			<table align="center">
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
						value="<%=post.getPost_title()%>"></td>
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
					<td>
						<%
							if (post.getPost_filepath() != null && !post.getPost_filepath().equals("")) {
						%> <label id="file_label">&nbsp;<%=post.getPost_filepath()%>&nbsp;
					</label> <input type="button" id="file_delete" value="기존 파일 삭제"
						onClick="confirmDeleteFile()"><input
						style="display: none;" type="file" id="post_filepath"
						name="post_filepath"> <%
 	} else {
 %><input type="file" id="post_filepath" name="post_filepath"
						onChange="fileEdited()"> <%
 	}
 %> <input type="hidden" name="file_edited" value="false">
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="1" bgcolor="#dddddd">
					<td colspan="4"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">내용</td>
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
						class="button_style2" onClick="modifyCheck()"> <input
						type=button value="취소" class="button_style2"
						onClick="jsp:history.back(-1)">
					<td>&nbsp;</td>
				</tr>
			</table>
		</form>
		</td>
		</tr>
		</table>

	</div>


</body>
</html>