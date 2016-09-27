<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="ldcc.board.api.*"%>
<%@ page import="ldcc.board.vo.*"%>
<%
	// �α��� ����
	Object userObj = request.getSession().getAttribute("user");
	boolean loggedIn = userObj != null && userObj instanceof User;
	
	// ���� ���丮 id
	String dirId = "";
	if (request.getAttribute("dir_id") != null) {
		dirId = (String) request.getAttribute("dir_id");
	}
	
	// ���� ���丮�� �θ�id
	String parentId = "";
	if (request.getAttribute("parent_id") != null) {
		parentId = (String) request.getAttribute("parent_id");
	}
	
	// ���� ���丮 ���� ���� ����Ʈ
	List<GoogleFile> googleFileList = (List<GoogleFile>) request.getAttribute("file_list");
	
	// ���� ���丮 ���� ����/���丮 ���� �� ���� �뷮
	int totalCount = (Integer) request.getAttribute("total_count");
	long totalSize = (Long) request.getAttribute("total_size");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���� �ý���</title>
<script language="javascript">
	function mkdir(dirPath) {		
		
	}
</script>
<link rel="stylesheet" href="main.css" type="text/css" />
<link rel="stylesheet" href="file.css" type="text/css" />

</head>
<body>
	<!-- ��� -->
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
			onClick="location.href='login.jsp'" class="button_style">&nbsp;|
			<input type="button" value="ȸ������" onClick="location.href='join.jsp'"
			class="button_style"> <%
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

	<!-- �ٵ� ���� -->
	<!--ui object -->
	<table width=90% height=50 align=center>
		<tr>
			<td align=right><input type=button onclick="mkdir()" value="���� ����"></td>
		</tr>
	</table>
	<table class="tbl_type" border="1" cellspacing="0" align="center">
		<colgroup>
			<col>
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">���ϸ�</th>
				<th scope="col">ũ��</th>
				<th scope="col">���δ�</th>
				<th scope="col">���ε� �Ͻ�</th>
				<th scope="col"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td>�� ũ�� : <%=totalSize %>, �� ���� �� : <%=totalCount %></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</tfoot>
		<tbody>
			<%
				if (!"".equals(parentId)) {
			%>
			<tr>
				<td class="ranking" scope="row"><a href="file?action=list">/</a></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td class="ranking" scope="row"><a href="file?action=list<%= !"".equals(parentId) ? "&dir_id=" + parentId : "" %>">..</a></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<%
				}
				
				for (GoogleFile googleFile : googleFileList) {
			%>
			<tr>
				<td class="ranking" scope="row">
				<% if (!googleFile.isFile()) { %>
				<a href="file?action=list&dir_id=<%=googleFile.getId() %>"><%=googleFile.getName() %></a>
				<% } else { %>
				<a href="https://www.googleapis.com/drive/v2/files/<%=googleFile.getId() %>"><%=googleFile.getName() %></a>
				<% } %>
				</td>
				<td><%=googleFile.isFile() ? googleFile.getSize() : "" %></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
</body>
</html>