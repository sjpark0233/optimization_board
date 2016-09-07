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

<script language = "javascript">
	function joinCheck(){
		
		var form = document.joinform;
		
		if( !form.id.value ){
			alert("아이디를 입력하세요");
			form.id.focus();
			return false;
		}
			
		if( !form.pw1.value ){
			alert("비밀번호를 입력하세요");
			form.pw1.focus();
			return false;		
		}
		
		if( !form.pw2.value ){
			alert("비밀번호를 다시한번 입력해주세요");
			form.pw2.focus();
			return false;		
		}
		
		if( form.pw1.value != form.pw2.value){
			alert("비밀번호가 다릅니다.");
			form.pw1.value="";
			form.pw2.value="";
			form.pw.focus();
			return false;		
		}
		
		if( !form.name.value ){
			alert("이름을 입력하세요");
			form.name.focus();
			return false;
		}
		
		if( !form.team.value ){
			alert("부서명을 입력하세요");
			form.team.focus();
			return false;	
		}	
		
		if( !form.tel1.value ){
			alert("전화번호를 입력하세요");
			form.tel1.focus();
			return false;		
			}
		if( !form.tel2.value ){
			alert("전화번호를 입력하세요");
			form.tel2.focus();
			return false;		
			}	
		if( !form.tel3.value ){
			alert("전화번호를 입력하세요");
			form.tel3.focus();
			return false;		
			}
		
		if( !form.email.value ){
			alert("이메일 주소를 입력하세요");
			form.email.focus();
			return false;		
			}
		form.submit();
	}
	
	function winOpen(){
		window.open("idCheck.jsp","w","width=300, height=100, resizable=yes");
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
<form name="joinform" method="get" action="join_ok.jsp">
    <table border="3">
        <tr>
            <td width="200">&nbsp;아이디</td>
            <td width="450">
                    &nbsp;&nbsp;<input type="text" name="id" autofocus required>
                    &nbsp;&nbsp;&nbsp;<input type="button" value="아이디 중복확인" onClick="winOpen()" size="15" maxlength="12">          
            </td>
        </tr>
        <tr>
            <td>&nbsp;비밀번호</td>
            <td>
                &nbsp;&nbsp;<input type="password" name="pw1" size="15" maxlength="12">
            </td>
        </tr>
        
         <tr>
            <td>&nbsp;비밀번호  중복확인</td>
            <td>
                &nbsp;&nbsp;<input type="password" name="pw2" size="15" maxlength="12">
            </td>
        </tr>
               
        <tr>
            <td>&nbsp;이름</td>
            <td>
                &nbsp;&nbsp;<input type="text" name="name" size="15" maxlength="12">
            </td>
        </tr>
       
       <tr>
            <td>&nbsp;소속</td>
            <td>
                &nbsp;&nbsp;<input type="text" name="team" size="15" maxlength="12"> 팀
            </td>
        </tr>
       
        <tr>
            <td>&nbsp;전화번호</td>
            <td>&nbsp;
                <select name="tel1">
  					<option value="010"> 010 </option>
 					<option value="011"> 011 </option>
   					<option value="016"> 016 </option>
   					<option value="017"> 017 </option>
  	 				<option value="018"> 018 </option>
   					<option value="019"> 019 </option>
   				</select> - 
   				<input type="text" name="tel2" size="5" maxlength="4"> - 
   				<input type="text" name="tel3" size="5" maxlength="4"> 
  			</td> 
        </tr>

        <tr>
            <td>&nbsp;E-Mail</td>
            <td>
                &nbsp;&nbsp;<input type="text" name="email">
            </td> 
        </tr>
    </table>

   <br>
        <input type="button" name="join" value="회원가입" Onclick="joinCheck()">&nbsp;
        <input type="reset" value="다시입력">&nbsp;
        <input type="button" name="cancel" value="취소" onClick="jsp:history.back(-1)">
    </form> 
    
</div>

</body>
</html>