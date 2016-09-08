<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입 페이지</title>
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
		//function winOpen(){
	//	window.open("user?action=user_check&user_id="+form.id.value,"w","width=300, height=100, resizable=yes");
	//}
		
	var count =0;

	function idCheck(){
		
		var text = $("#user_id").val();
		
        var regexp = /[0-9a-zA-Z]/; // 숫자,영문,특수문자
        // var regexp = /[0-9]/; // 숫자만
//         var regexp = /[a-zA-Z]/; // 영문만
        
        for(var i=0; i<text.length; i++){
            if(text.charAt(i) != " " && regexp.test(text.charAt(i)) == false ){
				alert("한글이나 특수문자는 입력불가능 합니다.");
				return false;
			}
            else if(text.length<4){
            	alert("아이디가 너무 짧습니다.");
				return false;
            }
        }
        overlapCheck();       
	}
	
	function overlapCheck(){
		var param = "user_id" + "=" + $("#user_id").val();
		if($("#user_id").val() == '' || $("#user_id").val()==null)
		{
			alert("아이디를 입력하세요");
			return false;
		}
		
		$.ajax({
			url : "user?action=user_check",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",

			success : function(responseData) {
				var data = JSON.parse(responseData);
				if(data != null)
				{
					count = 1;
					alert("사용 가능한 아이디입니다");
				}
				else
				{
					count = 0;
					alert("중복되는 아이디입니다");
					return false;
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
	
	function joinCheck(){
		var user_id = document.getElementById('user_id');
		var user_pw = document.getElementById('user_pw');
		var user_pw2 = document.getElementById('user_pw2');
		var user_name = document.getElementById('user_name');
		var team_name = document.getElementById('team_name');
		var tel1 = document.getElementById('tel1'); 
		var tel2 = document.getElementById('tel2'); 
		var tel3 = document.getElementById('tel3'); 
		var user_email = document.getElementById('user_email');

		if (user_id.value == '' || user_id.value == null) {
			alert('아이디를 입력하세요');
			focus.user_id;
			return false;
		}
		
		if(count == 0)
		{
			alert("아이디 중복을 확인하세요");
			return false;
		}
		
		if (user_pw.value == '' || user_pw.value == null) {
			alert('비밀번호를 입력하세요');
			focus.user_pw;
			return false;
		}

		if (user_pw2.value == '' || user_pw2.value == null) {
			alert('비밀번호확인란을 입력하세요');
			focus.user_pw2;
			return false;
		}
		
		/*비밀번호와 비밀번호확인란 같은지 확인*/
		if (user_pw.value != user_pw2.value){
			alert("비밀번호와 비밀번호 확인란이 다릅니다");
			focus.user_pw;
			return false;
		}
		
		/*비밀번호 길이 확인*/
		if (user_pw.value.length <5){
			alert("비밀번호는 5자 이상으로 입력해주세요");
			focus.user_pw;
			return false;
		}
		
		/*핸드폰 번호 길이 체크*/
		if(tel2.value.length<=2 || tel3.value.length!=4){
			alert("휴대폰번호를 제대로 입력해주세요");
			focus.hp2;
			return false;
		}
 		/*핸드폰이 숫자만 들어가는지 체크*/
 		if(isNaN(tel2.value) || isNaN(tel3.value))
		{
			alert("휴대폰번호는 숫자만 들어갈 수 있습니다.");
			return false;
		}
 		/**/
		if (tel2.value.length > 2 || tel3.value.length==4){
			document.getElementById("user_phone").value = tel1.value + "-" + tel2.value + "-" + tel3.value;;
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
		
 		
 		
 		if (user_email.value == '' || user_email.value == null) {
			alert('메일을 입력하세요');
			focus.user_email;
			return false;
		}
 		
		else{
			save();
		}
		
	}
	
	
	function init(){
		count=0;
	}
	
	function save() {
		var param = "user_id" + "=" + $("#user_id").val() + "&" +"user_pw" + "="+ $("#user_pw").val() + "&" +"user_name" + "="+ $("#user_name").val() + "&" +"team_name" + "="+ $("#team_name").val() + "&" +"user_phone" + "="+ $("#user_phone").val() + "&" +"user_email" + "="+ $("#user_email").val();
		$.ajax({
			url : "user?action=join",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",

			success : function(responseData) {
				var data = JSON.parse(responseData);
				if(data != null)
				{
					alert("회원가입 되었습니다.");
					location.replace("list_main.jsp");				
				}
				else
				{
					alert("회원가입에 실패했습니다.");
					location.replace("list_main.jsp");				
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
	
	function countCheck(){
		if(count==1){
			count=0;
		}
	}
</script>

</head>

<body>

<!-- 상단 -->
<div align=right>
<br>
<font class="font2"> <a href="login.jsp">LogIn</a> | <a href="join.jsp">회원가입</a> </font>
</div>

<div>
	<font class="font1"> 최적화팀 게시판 </font>
	<br><br>
</div>

<!-- 탭 -->
<div id="tabsF">
    <ul>
		<b>
		<li id="current"><a href="list_main.jsp"><span>Home</span></a></li>
		<li><a href=""><span>Windows</span></a></li>
		<li><a href="" target="_blank"><span>MS SQL</span></a></li>
		<li><a href=""><span>Oracle</span></a></li>
		<li><a href=""><span>Network</span></a></li>
		<li><a href=""><span>SAP</span></a></li>
		</b>
	</ul>
</div>

<div class="font4">
    <center><br>
    <H4>회원가입</H4>
	</center>
</div>
<div class="font3" align ="center">
<form name="joinform" method="post" action="user" id="join">
    <table border="3">
        <tr>
            <td width="200">&nbsp;아이디</td>
            <td width="450">
                    &nbsp;&nbsp;<input type="text" id="user_id" name="user_id" autofocus required>
                    
                    &nbsp;&nbsp;&nbsp;<input type="button" value="아이디 중복확인" onClick="idCheck()" size="15" maxlength="12">          
          		
         
            </td>
        </tr>
        <tr>
            <td>&nbsp;비밀번호</td>
            <td>
                &nbsp;&nbsp;<input type="password" id = "user_pw" name="user_pw" size="15" maxlength="12">
            </td>
        </tr>
        
         <tr>
            <td>&nbsp;비밀번호  중복확인</td>
            <td>
                &nbsp;&nbsp;<input type="password" id = "user_pw2" name="user_pw2" size="15" maxlength="12">
            </td>
        </tr>
               
        <tr>
            <td>&nbsp;이름</td>
            <td>
                &nbsp;&nbsp;<input type="text" id = "user_name" name="user_name" size="15" maxlength="12">
            </td>
        </tr>
       
       <tr>
            <td>&nbsp;소속</td>
            <td>
                &nbsp;&nbsp;<input type="text" id = "team_name" name="team_name" size="15" maxlength="12"> 팀
            </td>
        </tr>
       
        <tr>
            <td>&nbsp;전화번호</td>
            <td>&nbsp;
                <select id = "tel1" name="tel1">
  					<option value="010"> 010 </option>
 					<option value="011"> 011 </option>
   					<option value="016"> 016 </option>
   					<option value="017"> 017 </option>
  	 				<option value="018"> 018 </option>
   					<option value="019"> 019 </option>
   				</select> - 
   				<input type="text" id = "tel2" name="tel2" size="5" maxlength="4"> - 
   				<input type="text" id = "tel3" name="tel3" size="5" maxlength="4"> 
   				<input type=hidden id ="user_phone" name = "user_phone">
  			</td> 
        </tr>

        <tr>
            <td>&nbsp;E-Mail</td>
            <td>
                &nbsp;&nbsp;<input type="text" id = "user_email" name="user_email">
            </td> 
        </tr>
    </table>

   <br>
        <input type="button" name="join" value="회원가입" Onclick="joinCheck()">&nbsp;
        <input type="reset" value="다시입력" onclick='init()'>&nbsp;
        <input type="button" name="cancel" value="취소" onClick="jsp:history.back(-1)">
    </form> 
    
</div>

</body>
</html>