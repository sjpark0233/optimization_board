<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원정보확인</title>
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
		margin: 0;
        padding: 5% 20% 15% 20%;
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

</head>
<body>

<div align=right>
<br>
<font class="font2"> <a href="list_in.jsp">LogOut</a> | <a href="userInfo.jsp">회원정보확인</a> </font>
</div>

<div>
	<font class="font1"> 최적화팀 게시판 </font>
	<br><br>
</div>

<div id="tabsF">
    <ul>
		<b>
		<li><a href="list_in.jsp"><span>Home</span></a></li>
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
      <td width="1000"></td>
      <td width="0">&nbsp;</td>
    </tr>
	<tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="140">이름</td>
      <td width="1000"></td>
      <td width="0">&nbsp;</td>
    </tr>
	<tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="140">소속</td>
      <td width="1000"></td>
      <td width="0">&nbsp;</td>
    </tr>
	<tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="140">전화번호</td>
      <td width="1000"></td>
      <td width="0">&nbsp;</td>
    </tr>
    <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="140">이메일</td>
      <td width="1000"></td>
      <td width="0">&nbsp;</td>
    </tr>
    <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>

    <tr height="1" bgcolor="#82B5DF"><td colspan="4" width="407"></td></tr>
    
    <tr align="center">
  
      <td width="0">&nbsp;</td>
      <td colspan="2" width="399"><input type=button value="회원정보수정" OnClick="location.href='userInfoModify.jsp'">
	<input type=button value="회원탈퇴" OnClick="location.href='userWithdraw.jsp'">
      <td width="0">&nbsp;</td>
     </tr>
   </table>
    
   </td>
  </tr>
 </table>
 </div>
 
 </body>
</html>