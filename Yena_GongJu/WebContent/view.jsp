<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="ldcc.board.vo.*"%>
<%
	// �α��� ����
	Object userObj = request.getSession().getAttribute("user");
	boolean loggedIn = userObj != null && userObj instanceof User;

	//���� �Խ��� �� ��ȣ
	int tabCode = 0;
	if (request.getAttribute("tab_code") != null) {
		tabCode = ((Integer) request.getAttribute("tab_code")).intValue();
	}

	Post post = (Post) request.getAttribute("post"); // �Խù� ��ü
	String boardName = (String) request.getAttribute("board_name"); // ���� �����ִ� �Խù� ��Ʈ��

	List<Comment> commentList = (List<Comment>) request.getAttribute("comment_list"); // ��� ����Ʈ ��ü
	List<String> commentUserList = (List<String>) request.getAttribute("comment_user_list"); // ��� �ۼ��� ����Ʈ ��ü
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�� �б�</title>
<script language="javascript">
	function checkComment() {
		var form = document.commentform;

		if (!form.comment_content.value) {
			alert("��� ������ �����ּ���");
			form.comment_content.focus();
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
			%> | <input type="button" value="ȸ������"
			onClick="location.href='user?action=user_list'" class="button_style">
			<%
				} else {
			%> | <input type="button" value="ȸ������"
			onClick="location.href='user?action=user_info'" class="button_style">
			<%
				}
				} else {
			%><input type="button" value="LogIn"
			onClick="location.href='login.jsp'" class="button_style"> | <input
			type="button" value="ȸ������" onClick="location.href='join.jsp'"
			class="button_style"> <%
 	}
 %>
		</font>
	</div>

	<div>
		<font class="font1"> ����ȭ�� �Խ��� </font> <br> <br>
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
		<table align="center" border=1>
			<tr>
				<td>
					<table align="center">
						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="200">�۹�ȣ</td>
							<td align="center" width="1000"><%=post.getPost_code()%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="200">�з�</td>
							<td align="center" width="1000"><%=boardName%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="200">��ȸ��</td>
							<td align="center" width="1000"><%=post.getPost_view()%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="200">�Խù�Ÿ��</td>
							<td align="center" width="1000"><%=post.getPost_type() == 0 ? "����" : "�Ϲ�"%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="200">�ۼ���</td>
							<td align="center" width="1000"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(post.getPost_date())%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="200">����</td>
							<td align="center" width="1000"><%=post.getPost_title()%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="200">÷������</td>
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
							<td align="center" width="200">����</td>
							<td valign="top" width="1000" colspan="2" height="300"><%=post.getPost_content()%></td>
						</tr>
						<tr height="1" bgcolor="#82B5DF">
							<td colspan="4" width="407"></td>
						</tr>

						<tr height="10"></tr>

						<table width="100%">
							<tr height="1" bgcolor="#82B5DF">
								<td colspan="4" width="100%"></td>
							</tr>
							<tr height="1">
								<td colspan="4" width="100%"></td>
							</tr>
							<%
								for (int i = 0; i < commentList.size(); i++) {
									Comment comment = commentList.get(i);
									String commentUser = commentUserList.get(i);
							%>
							<tr>
								<td align="center" width=160><%=commentUser%></td>
								<td width="1000">: <%=comment.getComment_content()%></td>
							</tr>
							<tr height="1">
								<td colspan="4" width="100%"></td>
							</tr>
							<%
								}
							%>
						</table>
						<table width="100%">
							<tr height="1" bgcolor="#dddddd">
								<td colspan="4" width="100%"></td>
							</tr>
							<tr height="1">
								<td colspan="4" width="100%"></td>
							</tr>
							<form name=commentform method=post
								action="comment?action=write<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>"
								enctype="multipart/form-data">
								<tr>
									<td align="center" width=160>
										<!-- �ڽ��� �̸� -->
									</td>
									<td width=1000>: <textarea name=comment_content rows="1"></textarea></td>
									<td><button type="button" OnClick="checkComment()">���
											�ޱ�</button></td>
								</tr>
							</form>
							<tr height="1">
								<td colspan="4" width="100%"></td>
							</tr>
							<tr height="1" bgcolor="#dddddd">
								<td colspan="4" width="100%"></td>
							</tr>
							<tr height="1" bgcolor="#82B5DF">
								<td colspan="4" width="100%"></td>
							</tr>
						</table>

						<table align="right">
							<tr height="10"></tr>
							<tr>
								<td width="0">&nbsp;</td>
								<td colspan="2"><input type=button value="�۾���" class="button_style2"
									OnClick="location.href='post?action=show_write<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>'">
									<input type=button value="���" class="button_style2"
									OnClick="location.href='post?action=list<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>'">
									<input type=button value="����" class="button_style2"
									OnClick="location.href='post?action=show_modify<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>'">
									<input type=button value="����" class="button_style2"
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