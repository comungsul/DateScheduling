<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>web site</title>
</head>

<body>

	<%
	session.removeAttribute("userId");
	session.invalidate();
	%>
	<script>
		location.href='main.jsp';
	</script>
</body>
</html>
