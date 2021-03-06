<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
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

	List<Comment> commentList = (List<Comment>) request.getAttribute("comment_list"); // 댓글 리스트 객체
	List<String> commentUserList = (List<String>) request.getAttribute("comment_user_list"); // 댓글 작성자 리스트 객체
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글 읽기</title>
<script language="javascript">
	function checkComment() {
		var form = document.commentform;

		if (!form.comment_content.value) {
			alert("댓글 내용을 적어주세요");
			form.comment_content.focus();
			return;
		}

		form.submit();
	}
	function checkModifyComment(commentCode) {
		var text = document.getElementById("comment_input_"+commentCode);		
		if (!text.value) {
			alert("댓글 내용을 적어주세요");
			text.focus();
			return;			
		}
		document.getElementById("comment_code").value = commentCode;
		document.modifyform.submit();
	}
	function setEnableModifyComment(commentCode, bool) {
		document.getElementById("modify_comment_"+commentCode).style.display= bool ? 'none' : 'block';
		document.getElementById("delete_comment_"+commentCode).style.display= bool ? 'none' : 'block';
		document.getElementById("comment_label_"+commentCode).style.display= bool ? 'none' : 'block';
		document.getElementById("comment_input_"+commentCode).style.display= bool ? 'block' : 'none';
		document.getElementById("modify_comment_ok_"+commentCode).style.display= bool ? 'block' : 'none';
		document.getElementById("modify_comment_cancel_"+commentCode).style.display= bool ? 'block' : 'none';
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
						<tr height="1" bgcolor="#82B5DF">
							<td colspan="4" width="407"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<form name=modifyform method=post
						action="comment?action=modify<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>"
						enctype="multipart/form-data">
						<table align="center">
							<tr height="1" bgcolor="#82B5DF">
								<td><input type="hidden" id="comment_code" name="comment_code" value="0"></td>
								<td colspan="6"></td>
							</tr>
							<tr height="1">
								<td colspan="6"></td>
							</tr>
							<%
								for (int i = 0; i < commentList.size(); i++) {
									Comment comment = commentList.get(i);
									String commentUser = commentUserList.get(i);
							%>
							<tr height="30">
								<td width="0">&nbsp;</td>
								<td align="center" width=10%><%=commentUser%></td>
								<td width="900"><input size=140 maxlength=300
									id="comment_input_<%=comment.getComment_code()%>"
									name="comment_input_<%=comment.getComment_code()%>" type="text"
									style="display: none;"
									value="<%=comment.getComment_content()%>"><label
									id="comment_label_<%=comment.getComment_code()%>">: <%=comment.getComment_content()%>
										<font style="font-size: 50%;">(<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(comment.getComment_date())%>)
									</font></label></td>
								<%
									if (((User) userObj).getUser_accept() == 3
												|| ((User) userObj).getUser_id().equals(comment.getUser_id())) {
								%>
								<td width="50"><button type="button"
										id="modify_comment_<%=comment.getComment_code()%>"
										OnClick="setEnableModifyComment(<%=comment.getComment_code()%>, true)">수정</button>
									<button type="button"
										id="modify_comment_ok_<%=comment.getComment_code()%>"
										OnClick="checkModifyComment(<%=comment.getComment_code()%>)"
										style="display: none;">확인</button></td>
								<td width="50"><button type="button"
										id="delete_comment_<%=comment.getComment_code()%>"
										OnClick="location.href='comment?action=delete<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&comment_code=<%=comment.getComment_code()%>'">삭제</button>
									<button type="button"
										id="modify_comment_cancel_<%=comment.getComment_code()%>"
										OnClick="setEnableModifyComment(<%=comment.getComment_code()%>, false)"
										style="display: none;">취소</button></td>
								<%
									} else {
								%>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<%
									}
								%>
							</tr>
							<tr height="1">
								<td colspan="5"></td>
							</tr>
							<%
								}
							%>
							<tr height="1" bgcolor="#82B5DF">
								<td colspan="5"></td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
			<tr>
				<td>
					<form name=commentform method=post
						action="comment?action=write<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>"
						enctype="multipart/form-data">
						<table align="center">
							<tr height="1" bgcolor="#82B5DF">
								<td colspan="4"></td>
							</tr>
							<tr height="1">
								<td colspan="4"></td>
							</tr>
							<tr>
								<td width="0">&nbsp;</td>
								<td align="center" width=140>
									<!-- 자신의 이름 -->
								</td>
								<td width=1000>: <textarea cols=100% name=comment_content
										rows="1"></textarea></td>
								<td><button type="button" OnClick="checkComment()">댓글
										달기</button></td>
								<td width="0">&nbsp;</td>
							</tr>
							<tr height="1">
								<td colspan="4"></td>
							</tr>
							<tr height="1" bgcolor="#82B5DF">
								<td colspan="4"></td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
			<tr>
				<td>
					<table align="right">
						<tr height="10"></tr>
						<tr>
							<td width="0">&nbsp;</td>
							<td colspan="2"><input type=button value="글쓰기"
								class="button_style2"
								OnClick="location.href='post?action=show_write<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>'">
								<input type=button value="목록" class="button_style2"
								OnClick="location.href='post?action=list<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>'">
								<input type=button value="수정" class="button_style2"
								OnClick="location.href='post?action=show_modify<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>'">
								<input type=button value="삭제" class="button_style2"
								OnClick="location.href='post?action=delete<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>'">
							<td width="0">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>