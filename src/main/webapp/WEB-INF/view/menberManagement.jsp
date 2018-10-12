<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Member Management</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<style type="text/css">
#array_btn {
	margin-top: 80px;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/view/nav.jsp"></jsp:include>
	<div class="container">
		<!-- button -->
		<div class="row">
			<div class="col-md-8 col-md-offset-6">
				<input type="text" class="form-control" id="search_member_input"
					placeholder="17806236254" style="width: 160px; display: inline;">
				<button class="btn btn-primary" id="search_member_btn"
					style="display: inline">
					<span class="glyphicon glyphicon-search" aria-hidden="true"> </span> 搜索</button>
				<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<a class="btn btn-primary" id="add_btn" style="display: inline" href="${APP_PATH}/userAdd">
				<span class="glyphicon glyphicon-plus" aria-hidden="true"> </span> 注册会员</a>
			</div>
		</div>
		<!-- table -->
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<table class="table table-hover " id="member_table">
					<thead>
						<tr>
							<th>phone</th>
							<th>name</th>
							<th>identification</th>
							<th>level</th>
							<th>operation</th>
						</tr>
					</thead>
					<tbody>

					</tbody>

				</table>
			</div>
		</div>
		<!-- navigate -->
		<div class="row">
			<div class="col-md-3 col-md-offset-2" id="page_info"></div>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	
	<div class="modal fade" tabindex="-1" role="dialog" id="member_modify_modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">修改会员级别</h4>
				</div>
				<div class="modal-body">
				    <form>
				    	<div class="form-group">
						   <label class="col-sm-3 control-label">phone_number</label>
						   <div class="col-sm-9">
							   <p class="form-control-static"></p>
						   </div>
					    </div>
					    <div class="form-group">
						   <label class="col-sm-3 control-label">level</label>
						   <div class="col-sm-9">
							  <div class="radio">
								<label class="radio-inline"> <input type="radio"
									name="level" id="level1_input" value="Ordinary"
									checked="checked">Ordinary
								</label> <label class="radio-inline"> <input type="radio"
									name="level" id="level2_input" value="Silver">Silver
								</label> <label class="radio-inline"> <input type="radio"
									name="level" id="level3_input" value="Gold">Gold
								</label>
							</div>
						  </div>
					    </div>
				    </form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="save_change_bth">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->


	<script type="text/javascript">
	    var search_text = "n";
		$(function() {
			to_page(current,search_text);
		});
		// 		roominfo/0?pn=1&room_id=n
		function to_page(pn,phone) {
			$.ajax({
				url : "${APP_PATH}/member/",
				data : "pn=" + pn+"&phone="+phone,
				type : "get",
				success : function(result) {
					//console.log(result);
					build_room_table(result);
					build_page_info(result);
					build_page_nav(result);
				}
			});
		}
		var current = 1;
		function build_room_table(result) {
			$("#member_table tbody").empty();
			var members = result.extend.pageInfo.list;
			$.each(members,function(index, item) {
				var phone = $("<td></td>").append(item.phoneNum);
				var name = $("<td></td>").append(item.name);
				var identification = $("<td></td>").append(item.identification);
				var level = $("<td></td>").append(item.level);
				var edit_btn = $("<button></button>").addClass(
		         "btn btn-primary btn-sm edit-btn").append(
		         $("<span></span>").addClass(
				 "glyphicon glyphicon-pencil"))
		         .append("修改");
		        edit_btn.attr("btn-id",item.phoneNum);
				var del_btn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete-btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-remove")).append(
						"删除");
				del_btn.attr("btn-id", item.phoneNum);
				var button = $("<td></td>").append(edit_btn).append(" ").append(del_btn);
				$("<tr></tr>").append(phone).append(name).append(identification).append(level).append(button).appendTo(
						"#member_table tbody");		
			});

		}
		function build_page_info(result) {
			current = result.extend.pageInfo.pageNum;
			$("#page_info").empty();
			$("#page_info").append(
					"第 " + result.extend.pageInfo.pageNum + " 页"
							+ ", 共 " + result.extend.pageInfo.total
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

		$(document).on("click", ".delete-btn", function() {
			var phone = $(this).attr("btn-id");
			// 			$(this).parents("tr").find("td:eq(1)").text()
			if (confirm("Sure to delete this record?")) {
				$.ajax({
					url : "${APP_PATH}/member/" + phone,
					type : "DELETE",
					success : function(result) {
						to_page(current,search_text);
					}

				});
			}
		});
		$(document).on("click", ".edit-btn", function() {
			$("form")[0].reset();
			$("form").find("p").text("");
			var phone = $(this).attr("btn-id");
			$("form p").append(phone);
			$("#member_modify_modal").modal({
                keyboard: false
            });
		});
		
		$("#search_member_btn").click(function() {
			search_text = $("#search_member_input").val();
			if (search_text == "") {
				search_text = "n";
			}
			to_page(1, search_text);
		});



		$("#save_change_bth").click(function(){
			var text = $("form p").text();
			$.ajax({
				url : "${APP_PATH}/member/"+text,
				type : "PUT",
				data : $("form").serialize(),
				success : function(result) {
					if(result.code==100){
						$("#member_modify_modal").modal("hide");
						to_page(current,search_text);
					}
					
				}
			});
		});
	</script>
</body>
</html>