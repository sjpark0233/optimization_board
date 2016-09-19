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
<link rel="stylesheet" href="main.css" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글 수정</title>

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
	
	 function chkword(obj, maxByte) {
		 
	        var strValue = obj.value;
	        var strLen = strValue.length;
	        var totalByte = 0;
	        var len = 0;
	        var oneChar = "";
	        var str2 = "";
	 
	        for (var i = 0; i < strLen; i++) {
	            oneChar = strValue.charAt(i);
	            if (escape(oneChar).length > 4) {
	                totalByte += 2;
	            } else {
	                totalByte++;
	            }
	 
	            // 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
	            if (totalByte <= maxByte) {
	                len = i + 1;
	            }
	        }
	 
	        // 넘어가는 글자는 자른다.
	        if (totalByte > maxByte) {
	            alert(maxByte + "자를 초과할 수 없습니다.");
	            str2 = strValue.substr(0, len);
	            obj.value = str2;
	            chkword(obj, 4000);
	        }
	    }
</script>

</head>
<body>
	<div align=right>
		<br> <font class="font2">
			<%
				if (loggedIn) {
			%><input type="button" value="LogOut" onClick="location.href='user?action=logout'" class="button_style"><%
				if (((User) userObj).getUser_accept() == 3) {
			%> | <input type="button" value="회원관리" onClick="location.href='user?action=user_list'" class="button_style">
			<%
				} else {
			%> | <input type="button" value="회원정보" onClick="location.href='user?action=user_info'" class="button_style">
			<%
				}
				} else {
			%><input type="button" value="LogIn" onClick="location.href='login.jsp'" class="button_style"> | <input type="button" value="회원가입" onClick="location.href='join.jsp'" class="button_style">
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
					value="<%=post.getPost_title()%>" onkeyup="chkword(this, 80)"></td>
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
				<td><textarea name="post_content" cols="100%" rows="20%" onkeyup="chkword(this, 3000)"><%=post.getPost_content()%></textarea></td>
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
				<td colspan="2"><input type=button value="수정" class="button_style2"
					onClick="modifyCheck()"> <input type=button value="취소" class="button_style2"
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