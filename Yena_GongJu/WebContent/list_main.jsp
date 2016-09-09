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

	// �Խù� ����Ʈ ��ü
	List<Post> postList = (List<Post>) request.getAttribute("post_list");

	// �ϴ��� �Խù� ������ ǥ�ø� ���� ����
	int listAllCount = ((Integer) request.getAttribute("list_all_count")).intValue();
	int nowPage = ((Integer) request.getAttribute("page")).intValue();
	int maxPage = ((Integer) request.getAttribute("max_page")).intValue();
	int startPage = ((Integer) request.getAttribute("start_page")).intValue();
	int endPage = ((Integer) request.getAttribute("end_page")).intValue();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ��� Main</title>

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

	<!-- ��� -->
	<div align=right>
		<br> <font class="font2">
			<%
				if (loggedIn) {
			%><a href="user?action=logout">LogOut</a>
			<%
				if (((User) userObj).getUser_accept() == 3) {
			%> | <a href="user?action=user_list">ȸ������</a>
			<%
				} else {
			%> | <a href="user?action=user_info">ȸ������Ȯ��</a>
			<%
				}
				} else {
			%><a href="login.jsp">LogIn</a> | <a href="join.jsp">ȸ������</a>
			<%
				}
			%>
		</font>
	</div>

	<div>
		<font class="font1"> ����ȭ�� �Խ��� </font> <br> <br>
	</div>

	<!-- �� -->
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

	<!-- ��� -->
	<div class="font2">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr height="5">
				<td width="5"></td>
			</tr>
			<tr
				style="background: url('img/table_mid.gif') repeat-x; text-align: center;">
				<td width="5"><img src="img/table_left.gif" width="5"
					height="30" /></td>
				<td width="73">��ȣ</td>
				<td width="379">����</td>
				<td width="73">�ۼ���</td>
				<td width="164">�ۼ���</td>
				<td width="58">��ȸ��</td>
				<td width="7"><img src="img/table_right.gif" width="5"
					height="30" /></td>
			</tr>

			<!-- ����κ� -->

			<tr height="10" align="center">
			</tr>
			<%
				for (int i = 0; i < postList.size(); i++) {
					Post post = (Post) postList.get(i);
			%>
			<tr height="5" align="center"></tr>
			<tr style="text-align: center;">
				<td width="5"></td>
				<td width="103"><%=post.getPost_code()%></td>
				<td width="349" align="center"><a
					href="post?action=read<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&post_code=<%=post.getPost_code()%>"><%=post.getPost_title()%></a></td>
				<td width="73"><%=post.getUser_id()%></td>
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
					%> [����]&nbsp; <%
 	} else {
 %> <a
					href="post?action=list<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&page=<%=nowPage - 1%>">[����]</a>&nbsp;
					<%
						}
					%> <%
 	for (int i = startPage; i <= endPage; i++) {
 		if (i == nowPage) {
 %> [<%=i%>] <%
 	} else {
 %> <a
					href="post?action=list<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&page=<%=i%>">[<%=i%>]
				</a>&nbsp; <%
 	}
 %> <%
 	}
 %> <%
 	if (nowPage >= maxPage) {
 %> [����] <%
 	} else {
 %> <a
					href="post?action=list<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>&page=<%=nowPage + 1%>">[����]</a>&nbsp;
					<%
						}
					%>
				</td>
				<td width="20%" align="right"><input type=button value="�۾���"
					onClick="location.href='post?action=show_write<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>'">&nbsp;&nbsp;</td>
			</tr>
		</table>
	</div>

</body>
</html>