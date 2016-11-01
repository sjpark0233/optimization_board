<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="ldcc.board.vo.*"%>
<%
	// 로그인 여부
	Object userObj = request.getSession().getAttribute("user");
	boolean loggedIn = userObj != null && userObj instanceof User;
	
	// 현재 폴더 코드
	int dirCode = 0;
	if (request.getAttribute("dir_code") != null) {
		dirCode = (Integer) request.getAttribute("dir_code");
	}
	
	// 현재 폴더의 부모코드
	int parentCode = 0;
	if (request.getAttribute("parent_code") != null) {
		parentCode = (Integer) request.getAttribute("parent_code");
	}
	
	// 현재 폴더 내의 파일 리스트
	List<FileEntry> fileEntryList = (List<FileEntry>) request.getAttribute("file_entry_list");
	
	// 현재 디렉토리 내의 파일/디렉토리 수와 총 파일 용량
	int totalCount = (Integer) request.getAttribute("total_count");
	long totalSize = (Long) request.getAttribute("total_size");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>파일 시스템</title>
<script language="javascript">
	function mkdir(dirCode) {
		var obj = new Object();
		obj.message = "";
		window.showModalDialog("popup_input.jsp",obj,"dialogWidth:255px;dialogHeight:250px");
		
		if(obj.message != "") {
			alert("file?action=mkdir&name="+obj.message+(dirCode!=0?"&dir_code="+dirCode:""));
		}
	}
</script>
<link rel="stylesheet" href="main.css" type="text/css" />
<link rel="stylesheet" href="file.css" type="text/css" />

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
			onClick="location.href='login.jsp'" class="button_style">&nbsp;|
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

	<!-- 바디 시작 -->
	<!--ui object -->
	<table width=90% height=50 align=center>
		<tr>
			<td align=right><input type=button onclick="mkdir(<%=dirCode %>)" value="폴더 생성"></td>
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
				<th scope="col">파일명</th>
				<th scope="col">크기</th>
				<th scope="col">업로더</th>
				<th scope="col">업로드 일시</th>
				<th scope="col"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td>총 크기 : <%=totalSize %>, 총 파일 수 : <%=totalCount %></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</tfoot>
		<tbody>
			<%
				if (dirCode != 0) {
			%>
			<tr>
				<td class="ranking" scope="row"><a href="file?action=list">/</a></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td class="ranking" scope="row"><a href="file?action=list<%= parentCode != 0 ? "&dir_code=" + parentCode : "" %>">..</a></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<%
				}
				
				for (FileEntry fileEntry : fileEntryList) {
			%>
			<tr>
				<td class="ranking" scope="row">
				<% if (!fileEntry.isFile()) { %>
				<a href="file?action=list&dir_code=<%=fileEntry.getFile_entry_code() %>"><%=fileEntry.getFile_entry_name() %></a>
				<% } else { %>
				<%=fileEntry.getFile_entry_name() %>
				<% } %>
				</td>
				<td><%=fileEntry.isFile() ? fileEntry.getFile_entry_size() : "" %></td>
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