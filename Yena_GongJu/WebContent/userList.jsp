<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="ldcc.board.vo.*"%>
<%
	List<User> userList = (List<User>)request.getAttribute("result");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����� ����Ʈ_�����ڿ�</title>
<script language="javascript">

function user_accept(){
	var str3 = document.getElementById('accept');
	str3.submit();
}
function team_accept(){
	var str3 = document.getElementById('team_accept');
	str3.submit();
}

</script>

</head>

<body>

	<!-- ��� -->
	<div align=right >
		<!-- <br> <font class="font2"> <a href="user?action=logout">LogOut</a>
			| <a href="user?action=user_list">ȸ������Ȯ��</a>
		</font> -->
		<font class = "font2"><br>
		<input type="button" value="LogOut" onClick="location.href='user?action=logout'" class="button_style">&nbsp| 
		<input type="button" value="ȸ������" onClick="location.href='user?action=user_list'" class="button_style">
		</font>
	</div>

	<div>
		<font class="font1"> ����ȭ�� �Խ��� </font> <br>
		<br>
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
				<td width="50">ȸ�� �̸�</td>
				<td width="50">ȸ�� ID</td>
				<td width="60">��</td>
				<td width="70">��ȭ ��ȣ</td>
				<td width="70">�̸���</td>
				<td width="40">���� �ڵ�</td>
				<td width="50">����</td>
				<td width="50">����ȭ�� ����</td>
				<td width="5"><img src="img/table_right.gif" width="5"
					height="30" /></td>
			</tr>

			<!-- ����κ� -->

			<%
				for (int i = 0; i < userList.size(); i++) {
					User user = (User) userList.get(i);
					if(user.getUser_accept()==3){continue;}
					else{
			%>
			<tr height="5" align="center"></tr>
			<tr style="text-align: center;">
				<td width="5"></td>
				<td width="50"><%=user.getUser_name()%></td>
				<td width="50"><%=user.getUser_id()%></td>
				<td width="60"><%=user.getTeam_name()%></td>
				<td width="70"><%=user.getUser_phone()%></td>
				<td width="70"><%=user.getUser_email() %></td>
				<td width="40">
				<% switch(user.getUser_accept()){
				case 0:
					%>�̽���<%
					break;
				case 1:
					%>����<%
					break;
				case 2:
					%>����ȭ��<%
					break;
				case 3:
					%>������<%
					break;
				default:
					%>�˼�����<%
					break;
				}%>
				</td>
				<td width="50">
					<form name="user_accept" method="post" action="user" id="accept">
						<input type="hidden" id="action" name="action" value="user_accept">
						<input type="hidden" id="user_id" name="user_id"
							value="<%=user.getUser_id()%>"> <input type="submit"
							value="����" Onclick='user_accept()' class="accept_button">
					</form>
				</td>
				<td width="50">
					<form name="user_accept" method="post" action="user"
						id="team_accept">
						<input type="hidden" id="action" name="action" value="team_accept">
						<input type="hidden" id="user_id" name="user_id"
							value="<%=user.getUser_id()%>"> <input type="submit"
							value="����" onClick="team_accept()" class="accept_button">
					</form>
				</td>
			</tr>
			<tr height="5" align="center"></tr>
			<%
					}}
			%>
			<tr height="10" align="center"></tr>
			<tr height="1" bgcolor="#D2D2D2">
				<td colspan="10"></td>
			</tr>
			<tr height="1" bgcolor="#82B5DF">
				<td colspan="10" width="752"></td>
			</tr>
		</table>
	</div>
</body>
</html>