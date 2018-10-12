<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Check Out</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	
	<jsp:include page="/WEB-INF/view/nav.jsp"></jsp:include>
	<div class="container">
		<!-- button -->
		<div class="row">
		   <div class="col-md-4 col-md-offset-8">
		       <input type="text" class="form-control" id="search_input" placeholder="17806236254" style="width:160px;display:inline;">
	           <button class="btn btn-primary" id="search_btn" style="display:inline">
	           <span class="glyphicon glyphicon-search" aria-hidden="true"> </span> 搜索</button>
			</div>
		</div>
		<!-- table -->
		<div class="row ">
			<table class="table table-hover col-md-12" id="record_table">
				<!--     	r_id, p_num, status, start_date, end_date, total_price,name,identification,type -->
				<thead>
					<tr>
					    <th>
					    	<input type="checkbox" id="check_all"/>
					    </th>
						<th>room</th>
						<th>type</th>
						<th>phone_number</th>
						<th>name</th>
						<th>identification</th>
						<th>start_date</th>
						<th>end_date</th>
						<th>total_price</th>
						<th>operate</th>
					</tr>
				</thead>
				<tbody>

				</tbody>

			</table>
		</div>
		<!-- navigate -->
		<div class="row">
			<div class="col-md-6" id="page_info"></div>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
	    var search_text="n";
		$(function() {
			to_page(1,search_text);
		});
		function to_page(pn,phone) {
			$.ajax({
				url : "${APP_PATH}/record/1",
				data : "pn=" + pn+"&phone="+phone,
				type : "get",
				success : function(result) {
					//console.log(result);
					build_record_table(result);
					build_page_info(result);
					build_page_nav(result);
				}
			});
		}
		var current=1;
		function build_record_table(result) {
			$("#record_table tbody").empty();
			var records = result.extend.pageInfo.list;
			$.each(records,function(index, item) {
				var checkBox = $("<td><input type='checkbox' class='check_item'/></td>");
				checkBox.attr("rec_id",item.id);
				var roomId = $("<td></td>").append(item.rId);
				var tpye = $("<td></td>")
						.append(item.room.type);
				var phone = $("<td></td>").append(item.pNum);
				var name = $("<td></td>")
						.append(item.user.name);
				var id = $("<td></td>").append(
						item.user.identification);
				var startDate = $("<td></td>").append(
						timestampToTime(item.startDate));
				var endDate = $("<td></td>").append(
						timestampToTime(item.endDate));
				var totalPrice = $("<td></td>").append(
						item.totalPrice);
				var edit_btn = $("<button></button>").addClass(
				         "btn btn-primary btn-sm edit-btn").append(
				         $("<span></span>").addClass(
						 "glyphicon glyphicon-pencil"))
				         .append("退房");
				edit_btn.attr("btn-id",item.id);
				var del_btn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete-btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-remove"))
						.append("删除");
				del_btn.attr("btn-id",item.id);
				var button = $("<td></td>").append(edit_btn).append(" ").append(del_btn);
				$("<tr></tr>").append(checkBox).append(roomId).append(tpye)
						.append(phone).append(name).append(id)
						.append(startDate).append(endDate)
						.append(totalPrice).append(button)
						.appendTo("#record_table tbody");
			});
					
		}
		function build_page_info(result) {
			current = result.extend.pageInfo.pageNum;
			$("#page_info").empty();
			$("#page_info").append(
					"第 " + result.extend.pageInfo.pageNum
							+ " 页, 共 "
							+ result.extend.pageInfo.pages + " 页"
							+ ",共 " + result.extend.pageInfo.total
							+ " 条记录");
		}
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var first = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var previousPage = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href", "#"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				first.addClass("disabled");
				previousPage.addClass("disabled");
			} else {
				first.click(function() {
					to_page(1,search_text);
				});
				previousPage.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1,search_text);
				});
			}
			ul.append(first).append(previousPage);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", "#"));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item,search_text);
				});
				ul.append(numLi);
			});

			var nextPage = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href", "#"));
			var last = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPage.addClass("disabled");
				last.addClass("disabled");
			} else {
				last.click(function() {
					to_page(result.extend.pageInfo.pages,search_text);
				});
				nextPage.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1,search_text);
				});
			}
			ul.append(nextPage).append(last);
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		function timestampToTime(timestamp) {
			var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
			var Y = date.getFullYear() + '-';
			var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1)
					: date.getMonth() + 1)
					+ '-';
			var D = (date.getDate() < 10 ? '0' + (date.getDate()) : date
					.getDate());
			return Y + M + D;
		}
		$(document).on("click",".delete-btn",function(){
			var id = $(this).attr("btn-id");
// 			$(this).parents("tr").find("td:eq(1)").text()
			if(confirm("Sure to delete this record?")){
				$.ajax({
					url:"${APP_PATH}/record/"+id,
					type:"DELETE",
					success:function(result){
						to_page(current,search_text);
					}
					
				});
			}
		});
		
// 		.edit-btn
         $(document).on("click",".edit-btn",function(){
			var id = $(this).attr("btn-id");
// 			$(this).parents("tr").find("td:eq(1)").text()
			if(confirm("Sure to check out?")){
				$.ajax({
					url:"${APP_PATH}/record/"+id,
					type:"PUT",
					success:function(result){
						to_page(current,search_text);
					}
				});
			}
		});
		$("#check_all").click(function(){
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		$(document).on("click",".check_item",function(){
			var flag = ($(".check_item:checked").length==$(".check_item").length);
			$("#check_all").prop("checked",flag);
		})
		$("#delete_all_bth").click(function(){
			var del_ids = "";
			$.each($(".check_item:checked"),function(){
				del_ids += ($(this).parents("tr").find("td:eq(0)").attr("rec_id") +"&");
			});
			del_ids = del_ids.substring(0,del_ids.length-1);
			if(confirm("Sure to delete the records which are selected?")){
				$.ajax({
					url:"${APP_PATH}/record/"+del_ids,
					type:"DELETE",
					success:function(result){
						to_page(current,search_text);
					}
					
				});
			}
		});
		$("#search_btn").click(function(){
			var text = $("#search_input").val();
			if(text==""){
				search_text = "n";
			}else{
				search_text = text;
			}
			to_page(1,search_text);
		});
	</script>
</body>
</html>