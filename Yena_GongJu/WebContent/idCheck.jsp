<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���̵� �ߺ� Ȯ��</title>

 <script>
	function idChkClose() 
	{ // �������� �˻��� ���̵� ǥ��
		opener.document.joinform.value="myID"		
	  // ����â �ݱ�
		window.close();
		//self.close();
	}
 </script>

</head>
<body>
<!-- �����ʿ�(�ߺ������� ���� �ߺ��Ǵ� ���̵��� ������) -->
	<div align="center"> </div>����� �Է��� ���̵�� ��밡���� <br>���̵� �Դϴ�.<p>
  <div align="right">
  <input type="button" value="Close" onClick="idChkClose()">
  </div>
</body>

</body>
</html>