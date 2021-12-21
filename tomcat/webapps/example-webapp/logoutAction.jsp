<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>web site</title>
</head>

<body>
<%-- 할당된 세션을 해제해주고 메인으로 이동시킴 --%>
	<%
	session.invalidate();//할당된 세션 free
	%>
	<script>
		location.href='main.jsp';
	</script>
</body>
</html>