<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원정보확인</title>

</head>
<body>

	<div align=right>
		<font class = "font2"><br>
		<input type="button" value="LogOut" onClick="location.href='user?action=logout'" class="button_style">&nbsp| 
		<input type="button" value="회원정보" onClick="location.href='user?action=user_info'" class="button_style">
		</font>
	</div>

	<div>
		<font class="font1"> 최적화팀 게시판 </font> <br>
		<br>
	</div>

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

	<div class="font4">
		<center>
			<br>
			<H4>회원정보확인</H4>
		</center>
	</div>

	<div class="font3">
		<table align="center">
			<tr>
				<td>
					<table align="center">
						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">아이디</td>
							<td width="1000">${result.user_id}</td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">이름</td>
							<td width="1000">${result.user_name}</td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">소속</td>
							<td width="1000">${result.team_name}</td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">전화번호</td>
							<td width="1000">${result.user_phone}</td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>

						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="140">이메일</td>
							<td width="1000">${result.user_email}</td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>

						<tr height="1" bgcolor="#82B5DF">
							<td colspan="4" width="407"></td>
						</tr>
						
						<tr align="center">
							<td width="0">&nbsp;</td>
							<td colspan="2" width="399"><br><input type=button
								value="회원정보수정" OnClick="location.href='user?action=user_info2'" class="button_style2">
								<input type=button value="회원탈퇴"
								OnClick="location.href='userWithdraw.jsp'" class="button_style2">
							<td width="0">&nbsp;</td>
						</tr>
					</table>

				</td>
			</tr>
		</table>
	</div>

</body>
</html>