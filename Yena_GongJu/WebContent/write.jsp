<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글 작성</title>

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

<script language="javascript">
	function writeCheck()
		{
			var form = document.writeform;
 
	if( !form.title.value )
 	{
  	  alert( "제목을 적어주세요" );
 	  form.title.focus();
	return;
 	}

	if( !form.memo.value )
 	{
  	  alert( "내용을 적어주세요" );
  	  form.memo.focus();
  	return;
 	}

	form.submit();
	}
</script>


</head>
<body>

<div align=right>
<br>
<font class="font2"> <a href="">LogOut</a> | <a href="">회원정보확인</a> </font>
</div>

<div>
	<font class="font1"> 최적화팀 게시판 </font>
	<br><br>
</div>

<div id="tabsF">
    <ul>
		<b>
		<li><a href="list_main.jsp"><span>Home</span></a></li>
		<li><a href=""><span>Windows</span></a></li>
		<li><a href="" target="_blank"><span>MS SQL</span></a></li>
		<li><a href=""><span>Oracle</span></a></li>
		<li><a href=""><span>Network</span></a></li>
		<li><a href=""><span>SAP</span></a></li>
		</b>
	</ul>
</div>

<div class="font3">
   	<table align="center">
   	<form name=writeform method=post action="write_ok.jsp">
   	<br>
   	<tr>
      <td>&nbsp;</td>
      <td align="center">분류</td>
      <td>
      <select name="selections" size="1">
      	<option> Windows </option>
      	<option> MS SQL </option> 
      	<option> Oracle </option>
      	<option> Network </option>
      	<option> SAP </option>
      </select>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">제목</td>
      <td><input name="title" size="100%" maxlength="100"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">게시물타입</td>
      <td><input type="radio" name="type" value="alert">공지 <input type="radio" name="type" value="norm" checked="checked">일반</td>
      <td>&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">파일업로드</td>
      <td><input type="file" name="fileup"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">내용</td>
      <br>
      <td><textarea name="memo" cols="100%" rows="20%"></textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr>
     <tr align="center">
      <td>&nbsp;</td>
      <td colspan="2"><input type=button value="등록" OnClick="jsp:writeCheck()">
       <input type=button value="취소" OnClick="jsp:history.back(-1)">
      <td>&nbsp;</td>
     </tr>
     </form>
 	</table>
	</td>
	</tr>
</table>

</div>

</body>
</html>