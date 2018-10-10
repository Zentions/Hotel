<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" >
<link href="${APP_PATH}/static/css/navigate.css" rel="stylesheet">

<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>


<div>
	<img id="logo" src="${APP_PATH}/static/picture/logo.png">
</div>
<!-- navigation -->
<div>
	<nav class="navbar navbar-default " role="navigation">
		<div class="container-fluid">
			<div class="navbar-header" id="nav-parent">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#example-navbar-collapse">
					<span class="sr-only"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="${APP_PATH}/" style="color: white;">Home</a>
			</div>
			<div class="collapse navbar-collapse" id="example-navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="li-hover"><a style="color: white;"
						href="${APP_PATH}/userAdd">注册会员</a></li>
                    <li class="li-hover"><a style="color: white;"
						href="${APP_PATH}/recordAdd">入住</a></li>
					<li class="li-hover"><a style="color: white;"
						href="${APP_PATH}/checkOut">退房</a></li>
					<li class="li-hover"><a style="color: white;"
						href="${APP_PATH}/view">历史订单</a></li>
					<li class="li-hover"><a style="color: white;"
						href="${APP_PATH}/mr">客房管理</a></li>
					<li class="li-hover"><a style="color: white;"
						href="${APP_PATH}/mm">会员管理</a></li>
					<li class="li-hover"><a style="color: white;"
						href="${APP_PATH}/mp">价目管理</a></li>
				</ul>
			</div>
		</div>
	</nav>

</div>
