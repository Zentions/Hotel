<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ZhenBo Hotel</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<style type="text/css">
body {
	background:url("${APP_PATH}/static/picture/1.jpg") no-repeat center;
       background-size:contain;
}
html, body {
	width: 100%;
	height: 100%;
}

#logo {
	margin-top: 10px;
}

.navbar {
    color: white;
	margin-top: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
    filter:Alpha(opacity=50)
}

#nav-parent {
	margin-left: 20px;
}

.li-hover:hover { 
	background: rgb(48, 157, 242);
	font-weight:800;
}


</style>
</head>

<body>
	<jsp:include page="/WEB-INF/view/nav.jsp"></jsp:include>

	<div class="container">


	</div>
</body>
</html>