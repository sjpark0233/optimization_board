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
	function checkModifyComment(commentCode) {
		var text = document.getElementById("comment_input_"+commentCode);		
		if (!text.value) {
			alert("��� ������ �����ּ���");
			text.focus();
			return;			
		}
		document.getElementById("comment_code").value = commentCode;
		document.modifyform.submit();
	}
	function checkDeleteComment(tabCode, commentCode) {
		if(confirm("�����Ͻðڽ��ϱ�?")) {
			location.href="comment?action=delete" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "&comment_code=" + commentCode;
		}
	}
	function checkDeletePost(tabCode, postCode) {
		if(confirm("�����Ͻðڽ��ϱ�?")) {
			location.href="post?action=delete" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "&post_code=" + postCode;
		}		
	}
	function setEnableModifyComment(commentCode, bool) {
		<%
		for(Comment comment : commentList) {
			User user = (User) userObj;
			if(!(comment.getUser_id().equals(user.getUser_id()) || user.getUser_accept() == 3)) {
				continue;	
			}
			int code = comment.getComment_code();
			%>			
			document.getElementById("modify_comment_"+<%=code%>).style.display= bool && <%=code%>==commentCode ? 'none' : 'block';
			document.getElementById("delete_comment_"+<%=code%>).style.display= bool && <%=code%>==commentCode ? 'none' : 'block';
			document.getElementById("comment_label_"+<%=code%>).style.display= bool && <%=code%>==commentCode ? 'none' : 'block';
			document.getElementById("comment_input_"+<%=code%>).style.display= bool && <%=code%>==commentCode ? 'block' : 'none';
			document.getElementById("modify_comment_ok_"+<%=code%>).style.display= bool && <%=code%>==commentCode ? 'block' : 'none';
			document.getElementById("modify_comment_cancel_"+<%=code%>).style.display= bool && <%=code%>==commentCode ? 'block' : 'none';
			<%
		}
		%>
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
	 
	            // �Է��� ���� ���̺��� ��ġ�� �߶󳻱� ���� ����
	            if (totalByte <= maxByte) {
	                len = i + 1;
	            }
	        }
	 
	        // �Ѿ�� ���ڴ� �ڸ���.
	        if (totalByte > maxByte) {
	            alert(maxByte + "�ڸ� �ʰ��� �� �����ϴ�.");
	            str2 = strValue.substr(0, len);
	            obj.value = str2;
	            chkword(obj, 4000);
	        }
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
		<table align="center">
			<tr>
				<td>
					<table align="center">
						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">�۹�ȣ</td>
							<td align="center" width="1000"><%=post.getPost_code()%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">�з�</td>
							<td align="center" width="1000"><%=boardName%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">��ȸ��</td>
							<td align="center" width="1000"><%=post.getPost_view()%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">�Խù�Ÿ��</td>
							<td align="center" width="1000"><%=post.getPost_type() == 0 ? "����" : "�Ϲ�"%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">�ۼ���</td>
							<td align="center" width="1000"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(post.getPost_date())%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">����</td>
							<td align="center" width="1000"><%=post.getPost_title()%></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">÷������</td>
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
							<td align="center" width="140">����</td>
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
								<td align="center" width=10%><%=commentUser%> :</td>
								<td width="900"><input type="text" maxlength=150
									id="comment_input_<%=comment.getComment_code()%>"
									name="comment_input_<%=comment.getComment_code()%>" type="text"
									style="display: none; width: 98%; "
									value="<%=comment.getComment_content()%>"><label
									id="comment_label_<%=comment.getComment_code()%>" > 
									
									<% if(comment.getComment_content().length()>75){%>
										<%=comment.getComment_content().substring(0,75)%><br>
										<%=comment.getComment_content().substring(75)%><%
									}
									else
									{
										%><%=comment.getComment_content()%><%
									}%>
									
									<font style="font-size: 50%;">(<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(comment.getComment_date())%>)
									</font>
									</label>
									</td>
								<%
									if (((User) userObj).getUser_accept() == 3
												|| ((User) userObj).getUser_id().equals(comment.getUser_id())) {
								%>
								<td width="50"><input type="button"
										id="modify_comment_<%=comment.getComment_code()%>"
										OnClick="setEnableModifyComment(<%=comment.getComment_code()%>, true)" class="button_style3" value="����">
									<input type="button"
										id="modify_comment_ok_<%=comment.getComment_code()%>"
										OnClick="checkModifyComment(<%=comment.getComment_code()%>)"
										style="display: none;" class="button_style3" value="Ȯ��"></td>
								<td width="50"><input type="button"
										id="delete_comment_<%=comment.getComment_code()%>"
										OnClick="checkDeleteComment(<%=tabCode %>, <%=comment.getComment_code()%>)" class="button_style3" value="����">
										
									<input type="button"
										id="modify_comment_cancel_<%=comment.getComment_code()%>"
										OnClick="setEnableModifyComment(<%=comment.getComment_code()%>, false)"
										style="display: none;" class="button_style3" value="���"></td>
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
									<%=((User) userObj).getUser_name() %> :
								</td>
								<td width=1000>
								<input type="text" id="comment_conetent" name="comment_content" size="15" style="width:98%;"  onkeyup="chkword(this, 150)">
								</td>
								<td><input type="button" OnClick="checkComment()" class="button_style3" value="��� �ޱ�"></td>
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
							<td colspan="2"><input type=button value="�۾���"
								class="button_style2"
								OnClick="location.href='post?action=show_write<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>'">
								<input type=button value="���" class="button_style2"
								OnClick="location.href='post?action=list<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>'">
								<input type=button value="����" class="button_style2"
								OnClick="location.href='post?action=show_modify<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>'">
								<input type=button value="����" class="button_style2"
								OnClick="checkDeletePost(<%=tabCode%>, <%=post.getPost_code()%>)">
							<td width="0">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>