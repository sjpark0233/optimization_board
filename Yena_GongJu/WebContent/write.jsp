<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
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

	// 게시물 리스트 객체
	List<Board> boardList = (List<Board>) request.getAttribute("board_list");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="main.css" type="text/css"/>
<link rel="stylesheet" href="global.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글 작성</title>

<script language="javascript">
	function writeCheck() {
		var form = document.writeform;

		if (!form.post_title.value) {
			alert("제목을 적어주세요");
			form.title.focus();
			return;
		}

		if (!form.post_content.value) {
			alert("내용을 적어주세요");
			form.memo.focus();
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
	 
	function fileEdited() {
		<!--
		var filepath = document.writeform.post_filepath;
		if (filepath.files[0].size > 5 * 1024 * 1024) {
			alert("파일 용량은 5 Megabytes를 초과할 수 없습니다.");
			filepath[0].select();
			document.selection.clear();
		}
		-->
	}
</script>
<script language="javascript">
var clientId = '666549714055-v7mucvmk1pdauag4gcs87fch0hpd09tr.apps.googleusercontent.com';
var apiKey = 'AIzaSyD107wCYZeUaKFi1chEE9d1X3uHDFtQI-M';
var scopes = 'https://www.googleapis.com/auth/calendar';

	function handleClientLoad() {
	  gapi.client.setApiKey(apiKey);
	  window.setTimeout(checkAuth,1);
	  checkAuth();
	}

	function checkAuth() {
	  gapi.auth.authorize({client_id: clientId, scope: scopes, immediate: true},
	      handleAuthResult);
	}

	function handleAuthResult(authResult) {
	  var authorizeButton = document.getElementById('authorize-button');
	  if (authResult) {
		  loadCalendarApi();
	  } else {
	    authorizeButton.style.visibility = '';
	    authorizeButton.onclick = handleAuthClick;
	   }
	}

	function handleAuthClick(event) {
	  gapi.auth.authorize(
	      {client_id: clientId, scope: scopes, immediate: false},
	      handleAuthResult);
	  return false;
	}
	
	function loadCalendarApi(){
		gapi.client.load('calendar','v3', makeApiCall);
	}
	
	function makeApiCall() {
		var resource = {
				  "summary": "Appointment",
				  "location": "Somewhere",
				  "start": {
				    "dateTime": "2016-12-16T10:00:00.000-07:00"
				  },
				  "end": {
				    "dateTime": "2016-12-16T10:25:00.000-07:00"
				  }
				};

		var request = gapi.client.calendar.events.insert({
			  'calendarId': 'u9rjd2p8l2hbmc5lnd24015um0@group.calendar.google.com',
			  'resource': resource
			});
			request.execute(function(resp) {
			  console.log(resp);
			});
		}
	
</script>
    <script src="https://apis.google.com/js/client.js?onload=checkAuth"></script>

</head>
<body>
 <a href='#' id='authorize-button' onclick='handleAuthClick(event)'>Login</a>
	<div align=right>
		<br> <font class="font2">
			<%
				if (loggedIn) {
			%><input type="button" value="LogOut" onClick="location.href='user?action=logout'" class="button_style">
			<%
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
	<input type="button" value="최적화팀 게시판" onClick="location.href='user?action=showCalendar'" id="main_button">
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
		<form name=writeform method=post
				action="post?action=write<%=tabCode != 0 ? "&tab_code=" + tabCode : ""%>"
				enctype="multipart/form-data">
			<table align="center">
				<tr>
					<td>&nbsp;</td>
					<td align="center">분류</td>
					<td><select name="board_code" size="1">
							<%
								for (int i = 0; i < boardList.size(); i++) {
							%>
							<option value=<%=i + 1%> <%if (i + 1 == tabCode) {%>
								selected="selected" <%}%>><%=boardList.get(i).getBoard_name()%></option>
							<%
								}
							%>
					</select>
					<td>&nbsp;</td>
				</tr>
				<tr height="1" bgcolor="#dddddd">
					<td colspan="4"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">제목</td>
					<td><input name="post_title" size="100%" maxlength="80" onkeyup="chkword(this, 80)"></td>
					<td>&nbsp;</td>
				</tr>
				<tr height="1" bgcolor="#dddddd">
					<td colspan="4"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">게시물타입</td>
					<td><input type="radio" name="post_type" value=0>공지 <input
						type="radio" name="post_type" value=1 checked="checked">일반</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="1" bgcolor="#dddddd">
					<td colspan="4"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">파일업로드</td>
					<td><input type="file" name="post_filepath" onchange="fileEdited()"></td>
					<td>&nbsp;</td>
				</tr>
				<tr height="1" bgcolor="#dddddd">
					<td colspan="4"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">내용</td>
					<td><textarea name="post_content" cols="100%" rows="20%" onkeyup="chkword(this, 3000)" ></textarea></td>
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
					<td colspan="2"><input type=button value="등록" class="button_style2"
						OnClick="jsp:writeCheck()"> <input type=button value="취소" class="button_style2"
						OnClick="jsp:history.back(-1)">
					<td>&nbsp;</td>
				</tr>
			</table>
		</form>



	</div>

</body>
</html>