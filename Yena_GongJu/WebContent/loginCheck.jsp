<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>loginCheck</title>
</head>
<body>
<%
	String myID = "aaaa";
	String myPW = "1111";
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	if(myID.equals(id)){
		if(myPW.equals(pw)){
			//�α��� ����
			response.sendRedirect("list_in.jsp"); // ID PW ��ġ�ϸ� Ȩ ��� ȭ������ ���ư� -> �������ʿ�(����ȭ������ ���ư���)
		}else{
			//��й�ȣ Ʋ��
			%>
			<script>
				alert('��й�ȣ�� Ʋ�Ƚ��ϴ�.');
				history.go(-1);
			</script>
			<%
		}
	}else{
			//���̵� �������� ����
			%>
			<script>
				alert('���̵� Ʋ�Ƚ��ϴ�.');
				history.go(-1);
			</script>
		}
		<%
	}
%>


</body>
</html>