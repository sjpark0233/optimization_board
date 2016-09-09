<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ldcc.board.vo.*" %>
<% String phone = ((User)request.getAttribute("result")).getUser_phone().split("-")[0];%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원정보 수정 페이지</title>
<style type="text/css">
<!--
    body {
        margin:0;
        padding:0;
        font: 11px/1.5em Verdana;
	}
	.font1 {
		font: bold 30px Verdana,sans-serif;
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
	.font3 {
		font: 20px Verdana, sans-serif;
		color: #000;
		}
	.font4 {
		font: bold 30px Verdana,sans-serif;
		color: #000;
		margin: 0px;
        padding: 5px 20px 5px 20px;
		}	
	h2 {
        font: bold 14px Verdana, Arial, Helvetica, sans-serif;
        color: #000;
        margin: 0px;
        padding: 0px 0px 0px 15px;
	}

/*- Menu Tabs F--------------------------- */

    #tabsF {
      float:left;
      width:100%;
      background:#fff;
      font-size:93%;
      line-height:normal;
      border-bottom:1px solid #666;
      }
    #tabsF ul {
       margin:0;
       padding:10px 10px 0 50px;
       list-style:none;
      }
    #tabsF li {
      display:inline;
      margin:0;
      padding:0;
      }
    #tabsF a {
      float:left;
      background:url(http://pds7.egloos.com/pds/200803/09/83/b0050083_47d2b60bb22d2.gif) no-repeat left top;
      margin:0;
      padding:0 0 0 4px;
      text-decoration:none;
      }
    #tabsF a span {
      float:left;
      display:block;
      background:url(http://pds8.egloos.com/pds/200803/09/83/b0050083_47d2b60d5f78a.gif) no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#666;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsF a span {float:none;}
    /* End IE5-Mac hack */
    #tabsF a:hover span {
      color:#FFF;
      }
    #tabsF a:hover {
      background-position:0% -42px;
      }
    #tabsF a:hover span {
      background-position:100% -42px;
      }

	#tabsF #current a {
      background-position:0% -42px;
      }
    #tabsF #current a span {
      background-position:100% -42px;
      }
-->

	
</style>


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
<script language = "javascript">
function InfoCheck(){
	var user_pw0 = document.getElementById('user_pw0');
	var user_pw = document.getElementById('user_pw');
	var user_pw2 = document.getElementById('user_pw2');
	var user_name = document.getElementById('user_name');
	var team_name = document.getElementById('team_name');
	var tel1 = document.getElementById('tel1'); 
	var tel2 = document.getElementById('tel2'); 
	var tel3 = document.getElementById('tel3'); 
	var user_email = document.getElementById('user_email');
	
	if (user_pw0.value == '' || user_pw0.value == null) {
		alert('비밀번호를 입력하세요');
		focus.user_pw;
		return false;
	}
	
	if (user_pw.value != '' && user_pw.value != null) {
		focus.user_pw;
		if (user_pw2.value == '' || user_pw2.value == null) {
			alert('비밀번호확인란을 입력하세요');
			focus.user_pw2;
			return false;
		}
		else
		{
			/*비밀번호와 비밀번호확인란 같은지 확인*/
			if (user_pw.value != user_pw2.value){
				alert("새 비밀번호와 새 비밀번호 확인란이 다릅니다");
				focus.user_pw;
				return false;
			}

			/*비밀번호 길이 확인*/
			if (user_pw.value.length <5){
				alert("비밀번호는 5자 이상으로 입력해주세요");
				focus.user_pw;
				return false;
			}
		}
	}
	
	if (user_name.value == '' || user_name.value == null) {
		alert('이름을 입력하세요');
		focus.user_name;
		return false;
	}
	
	if (team_name.value == '' || team_name.value == null) {
		alert('팀을 입력하세요');
		focus.team_name;
		return false;
	}
	
	/*핸드폰 번호 길이 체크*/
	if(tel2.value.length<=2 || tel3.value.length!=4){
		alert("휴대폰번호를 제대로 입력해주세요");
		focus.tel2;
		return false;
	}
		
		/*핸드폰이 숫자만 들어가는지 체크*/
	if(isNaN(tel2.value) || isNaN(tel3.value)){
		alert("휴대폰번호는 숫자만 들어갈 수 있습니다");
		return false;
	}
		/**/
	if (tel2.value.length > 2 || tel3.value.length==4){
		document.getElementById("user_phone").value = tel1.value + "-" + tel2.value + "-" + tel3.value;;
	}
		
	if (user_email.value == '' || user_email.value == null){
		alert('메일을 입력하세요');
		focus.user_email;
		return false;
	}
	
	else{
		save();
	}
	
}


function save() {
	var param = "user_pw0" + "=" + $("#user_pw0").val() + "&" +"user_pw" + "="+ $("#user_pw").val() + "&" +"user_name" + "="+ $("#user_name").val() + "&" +"team_name" + "="+ $("#team_name").val() + "&" +"user_phone" + "="+ $("#user_phone").val() + "&" +"user_email" + "="+ $("#user_email").val();
	
	$.ajax({
		url : "user?action=user_info_modify",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",

		success : function(responseData) {
			var data = JSON.parse(responseData);
		if(data.success == 1)
		{
			alert("수정되었습니다.");
			location.replace("user?action=user_info");	
		}
		else if(data.success == 0)
		{
			alert("비밀번호가 맞지 않습니다.");	
			location.reload();
		}
		else
		{
			alert("수정을 실패했습니다.");
			location.replace("user?action=user_info");				
		}						
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : "
						+ request.reponseText + "\r\nerror : " + error);
			}
		}

	});
}

		
</script>

</head>

<body>

<!-- 상단 -->

<div align=right>
<br>
<font class="font2"> <a href="user?action=logout">LogOut</a> | <a href="user?action=user_info">회원정보확인</a> </font>
</div>


<div>
	<font class="font1"> 최적화팀 게시판 </font>
	<br><br>
</div>

<!-- 탭 -->
<div id="tabsF">
    <ul>
		<b>
		<li id="current"><a href="post?action=list"><span>Home</span></a></li>
		<li><a href="post?action=list&tab_code=1"><span>Windows</span></a></li>
		<li><a href="post?action=list&tab_code=2"><span>MS SQL</span></a></li>
		<li><a href="post?action=list&tab_code=3"><span>Oracle</span></a></li>
		<li><a href="post?action=list&tab_code=4"><span>Network</span></a></li>
		<li><a href="post?action=list&tab_code=5"><span>SAP</span></a></li>
		</b>
	</ul>
</div>

<div class="font4">
    <center><br>
    <H4>회원정보수정</H4>
	</center>
</div>

<div class="font3" align ="center">
<form name="modify" method="post" action="user" id="user_info_modify">
    <table border="3">
    <tr>
      <td>&nbsp;아이디&nbsp;</td>
      <td width="1000">&nbsp;&nbsp;${result.user_id}</td>
    </tr>
    <tr>
            <td>&nbsp;이전 비밀번호&nbsp;</td>
            <td>
                &nbsp;&nbsp;<input type="password" name="user_pw0" size="15" maxlength="12" id ="user_pw0">
            </td>
        </tr>
        <tr>
            <td>&nbsp;새 비밀번호&nbsp;</td>
            <td>
                &nbsp;&nbsp;<input type="password" name="user_pw" size="15" maxlength="12" id ="user_pw">
            </td>
        </tr>
        
         <tr>
            <td>&nbsp;새 비밀번호 확인&nbsp;</td>
            <td>
                &nbsp;&nbsp;<input type="password" name="user_pw2" size="15" maxlength="12" id ="user_pw2">
            </td>
        </tr>
               
        <tr>
            <td>&nbsp;이름&nbsp;</td>
            <td>
                &nbsp;&nbsp;<input type="text" name="user_name" size="15" maxlength="12" id ="user_name" value = ${result.user_name}>
            </td>
        </tr>
       
       <tr>
            <td>&nbsp;소속&nbsp;</td>
            <td>
                &nbsp;&nbsp;<input type="text" name="team_name" size="15" maxlength="12" id = "team_name" value = ${result.team_name}>팀
            </td>
            
        </tr>
         <tr>
            <td>&nbsp;전화번호</td>
            <td>&nbsp;
                <select name="tel1" id ="tel1">
  					<option value="010" <% if(phone.equals("010")){%>selected="selected" <%}%>> 010 </option>
 					<option value="011" <% if(phone.equals("011")){%>selected="selected" <%}%>> 011 </option>
   					<option value="016" <% if(phone.equals("016")){%>selected="selected" <%}%>> 016 </option>
   					<option value="017" <% if(phone.equals("017")){%>selected="selected" <%}%>> 017 </option>
  	 				<option value="018" <% if(phone.equals("018")){%>selected="selected" <%}%>> 018 </option>
   					<option value="019" <% if(phone.equals("019")){%>selected="selected" <%}%>> 019 </option>
   				</select> - 
   				<input type="text" name="tel2" size="5" maxlength="4" id ="tel2" value = ${result.user_phone.split('-')[1]}> - 
   				<input type="text" name="tel3" size="5" maxlength="4" id ="tel3" value = ${result.user_phone.split('-')[2]}>   
   				<input type=hidden id ="user_phone" name = "user_phone">
  			</td> 
        </tr>

        <tr>
            <td>&nbsp;E-Mail&nbsp;</td>
            <td>
                &nbsp;&nbsp;<input type="text" name="user_email" value = ${result.user_email} id ="user_email">
            </td> 
        </tr>
    </table>

   <br>
        <input type="button" value="수정하기" Onclick="InfoCheck()"> 
        <input type="button" name="cancel" value="취소" onClick="jsp:history.back(-1)">
    </form> 
    
</div>

</body>
</html>