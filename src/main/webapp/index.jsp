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
#wel_text {
     text-align: center;
	  margin-top: 70px;
}
#hotel_text {
  font-size:60px;
  color:  rgb(23, 135, 224);
  text-shadow: 5px 5px 0 #666, 7px 7px 0 rgb(48, 157, 242);
}
#welcome {
font-family:华文琥珀;
  font-size:50px;
/*   华文新魏 */
  color: palegreen;
  -webkit-box-reflect:below 10px;
}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/view/nav.jsp"></jsp:include>
    <div class="container">
    	<div class="row ">
			<div class="col-md-6" >
				<div id="carousel-example-generic" class="carousel slide"
					data-ride="carousel">
					<!-- 轮播（Carousel）指标 -->
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-generic" data-slide-to="0"
							class="active"></li>
						<li data-target="#carousel-example-generic" data-slide-to="1"></li>
						<li data-target="#carousel-example-generic" data-slide-to="2"></li>
						<li data-target="#carousel-example-generic" data-slide-to="3"></li>
					</ol>
					<!-- 轮播（Carousel）项目内容 -->
					<div class="carousel-inner" role="listbox">
						<!-- 默认显示图片 -->
						<div class="item active">
							<img src="${APP_PATH}/static/picture/1.jpg" alt="天蓝碧水">
							<!-- 图片描述内容 -->
<!-- 							<div class="carousel-caption">天蓝碧水</div> -->
						</div>
						<div class="item">
							<img src="${APP_PATH}/static/picture/2.jpg" alt="阳光海岸">
							
						</div>
						<div class="item">
							<img src="${APP_PATH}/static/picture/3.jpg" alt="柔和夜色">
						</div>
                        <div class="item">
							<img src="${APP_PATH}/static/picture/4.jpg" alt="温馨家居">
						</div>
					</div>
					<!-- 轮播（Carousel）导航(控制左右移动) -->
					<a class="left carousel-control" href="#carousel-example-generic"
						role="button" data-slide="prev"> 
						<span class="glyphicon glyphicon-chevron-left"></span> 
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#carousel-example-generic"
						role="button" data-slide="next"> 
						<span class="glyphicon glyphicon-chevron-right"></span> 
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
            <div class=" col-md-6" id="wel_text">
            	<div id="welcome">Welcome To</div>
            	<div id="hotel_text">Zhenbo Hotel</div>
              
             </div>
		</div>
    </div>
</body>
</html>