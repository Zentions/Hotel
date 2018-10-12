<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>House Management</title>
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
				<input type="text" class="form-control" id="search_input"
					placeholder="102" style="width: 160px; display: inline;">
				<button class="btn btn-primary" id="search_btn"
					style="display: inline">
					<span class="glyphicon glyphicon-search" aria-hidden="true"> </span> 搜索客房</button>
				<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<button class="btn btn-primary" id="add_btn" style="display: inline">
				<span class="glyphicon glyphicon-plus" aria-hidden="true"> </span> 添加客房</button>
			</div>
		</div>
		<!-- table -->
		<div class="row">
			<div class="col-md-1" id="array_btn">
				<div class="btn-group-vertical">
					<button type="button" class="btn btn-primary" id="select_all_btn">所有客房</button>
					<button type="button" class="btn btn-primary" id="select_u_btn"> 可租客房</button>
					<button type="button" class="btn btn-primary" id="select_n_btn">已租客房</button>
				</div>

			</div>
			<div class="col-md-8 col-md-offset-1">
				<table class="table table-hover " id="room_table">
					<thead>
						<tr>
							<th>room</th>
							<th>type</th>
							<th>usable</th>
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
	
	<div class="modal fade" tabindex="-1" role="dialog" id="room_add_modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">添加客房</h4>
				</div>
				<div class="modal-body">
				    <form>
				    	<div class="form-group">
							<label class="control-label">room_number</label>
							<div >
								<input type="text" name="roomId" class="form-control "
									id="room_num_input" placeholder="102"
									ajax-val="failure"> 
									<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label">room_type</label>
							<select class="form-control" id="room_tpye_input" name="type">
                            </select>
						</div>
				    </form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="save_room_bth">保存客房信息</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->


	<script type="text/javascript">
		var mode = 0;
		$(function() {
			to_page(mode, current, "n");
		});
		// 		roominfo/0?pn=1&room_id=n
		function to_page(status, pn, room_id) {
			$.ajax({
				url : "${APP_PATH}/roominfo/" + status,
				data : "pn=" + pn + "&room_id=" + room_id,
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
			$("#room_table tbody").empty();
			var rooms = result.extend.pageInfo.list;
			$.each(rooms,function(index, item) {
				var roomId = $("<td></td>").append(item.roomId);
				var type = $("<td></td>").append(item.type);
				var usable = $("<td></td>").append(item.usable);
				var del_btn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete-btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-remove")).append(
						"删除");
				del_btn.attr("btn-id", item.roomId);
				var button = $("<td></td>").append(del_btn);
				$("<tr></tr>").append(roomId).append(type).append(
						usable).append(button).appendTo(
						"#room_table tbody");		
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
					to_page(mode, 1, "n");
				});
				previousPage.click(function() {
					to_page(mode, result.extend.pageInfo.pageNum - 1, "n");
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
					to_page(mode, item, "n");
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
					to_page(mode, result.extend.pageInfo.pages, "n");
				});
				nextPage.click(function() {
					to_page(mode, result.extend.pageInfo.pageNum + 1, "n");
				});
			}
			ul.append(nextPage).append(last);
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}

		$(document).on("click", ".delete-btn", function() {
			var id = $(this).attr("btn-id");
			// 			$(this).parents("tr").find("td:eq(1)").text()
			if (confirm("Sure to delete this record?")) {
				$.ajax({
					url : "${APP_PATH}/roominfo/" + id,
					type : "DELETE",
					success : function(result) {
						to_page(mode, current, "n");
					}

				});
			}
		});
		$("#select_all_btn").click(function() {
			mode = 0;
			to_page(mode, current, "n");
		});
		$("#select_u_btn").click(function() {
			mode = 1;
			to_page(mode, current, "n");
		});
		$("#select_n_btn").click(function() {
			mode = 2;
			to_page(mode, current, "n");
		});

		$("#search_btn").click(function() {
			var search_text = "n";
			var text = $("#search_input").val();
			if (text == "") {
				search_text = "n";
			} else {
				search_text = text;
			}
			to_page(0, 1, search_text);
		});
		$("#add_btn").click(function(){
			$("form")[0].reset();
			$("form").find("*").removeClass("has-success has-error");
			$("form").find(".help-block").text("");
			getRoomTypes();
			$("#room_add_modal").modal({
                keyboard: false
            });
		});
		function getRoomTypes(){
			$("#room_tpye_input").empty();
			$.ajax({
				url : "${APP_PATH}/htype",
				type : "GET",
				success : function(result) {
					var types = result.extend.type;
					$.each(types,function(index, item) {
						var opt = $("<option></option>").append(item.hTpye);
						opt.appendTo("#room_tpye_input");
					});
					var current_type = $("#room_tpye_input").val();
					getRoomByType(current_type);	
				}
			});		
		}
		function validate_show(ele, code, msg) {
			//$(ele).parent().removeClass("has-error");
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			//$(ele).next("span").text("");
			if (code == 1) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		$("#room_num_input").change(function() {
			var num = this.value;
			$.ajax({
				url : "${APP_PATH}/checkRoom/"+num,
				type : "GET",
				success : function(result) {
					if (result.extend.usable==true) {
						validate_show("#room_num_input", 1,
								"The room number is usable");
						$("#room_num_input").attr("ajax-val","success");
					} else {
						validate_show("#room_num_input", 2,
								"The room number exits,please change");
						$("#room_num_input").attr("ajax-val","failure");
					}
				}
			});		
		});
		$("#save_room_bth").click(function(){
			if ($("#room_num_input").attr("ajax-val") == "failure") {
			    return;
		    }
			alert($("form").serialize());
			$.ajax({
				url : "${APP_PATH}/roominfo",
				type : "POST",
				data : $("form").serialize(),
				success : function(result) {
					if(result.code==100){
						$("#room_add_modal").modal("hide");
					}
					
				}
			});
		});
	</script>
</body>
</html>