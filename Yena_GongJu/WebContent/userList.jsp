<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����� ����Ʈ_�����ڿ�</title>
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

<!-- ��� -->
<div align=right>
<br>
<font class="font2"> <a href="logout.jsp">LogOut</a> | <a href="userInfo.jsp">ȸ������Ȯ��</a> </font>
</div>

<div>
	<font class="font1"> ����ȭ�� �Խ��� </font>
	<br><br>
</div>

<!-- �� -->
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

<!-- ��� -->
<div class="font2">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr height="5"><td width="5"></td></tr>
	<tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
 		<td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
   		<td width="58">��ȣ</td>
   		<td width="140">������</td>
   		<td width="140">���̵�</td>
   		<td width="130">�Ҽ�</td>
	 	<td width="139">������</td>
	 	<td width="140">�ֱ� ���� �ð�</td>	
   		<td width="5"><img src="img/table_right.gif" width="5" height="30" /></td>
    </tr>

<!-- ����κ� -->    
   
	<tr height="25" align="center">
		
	</tr>
    
	<tr height="25" align="center"></tr>
  	<tr height="1" bgcolor="#D2D2D2"><td colspan="7"></td></tr>
 	<tr height="1" bgcolor="#82B5DF"><td colspan="7" width="752"></td></tr>
</table>
 
<!--  <table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr><td colspan="4" height="5"></td></tr>
  	<tr align="right">
   		<td><input type=button value="�۾���" onClick="location.href='write.jsp'"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  	</tr>
</table> -->
</div>

</body>
</html>