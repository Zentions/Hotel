<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Price Management</title>
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
.margin_btn {
	margin-top: 30px;
}

</style>
</head>
<body>

	<jsp:include page="/WEB-INF/view/nav.jsp"></jsp:include>
    <div class="container">
    	<div class="row">
    		<div class="col-md-2 col-md-offset-1" id="fun_btn">
	            <div class="margin_btn">
	    	       <button type="button" class="btn btn-success" id="modify_button">
	    	       <span class="glyphicon glyphicon-pencil" aria-hidden="true"> </span> 修改价目</button>
	            </div>
		        <div class="margin_btn">
			       <button type="button" class="btn btn-primary" id="add_button">
			       <span class="glyphicon glyphicon-plus" aria-hidden="true"> </span> 新增价目</button>
		        </div>   
		        <div class="margin_btn">
			       <button type="button" class="btn btn-warning" id="del_button">
			       <span class="glyphicon glyphicon-remove" aria-hidden="true"> </span> 删除价目</button>
		        </div>  
	       </div>
          <div class="col-md-2 col-md-offset-2" id="array_button">    
	      </div>
    	</div>
    </div>

	
	<script>
		$(function() {
			$("[data-toggle='popover']").popover();
		});
	</script>


	<div class="modal fade" tabindex="-1" role="dialog"
		id="price_modify_modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">修改客房价格</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label class="control-label">type</label>
							<select class="form-control" name="hTpye" id="modify_room_type_input">
                            </select>
						</div>
                        <div class="form-group">
							<label class="control-label">price</label>
							<div >
								<input type="text" name="price" class="form-control "
									id="modify_room_price_input" placeholder="100"
									ajax-val="failure"> 
									<span class="help-block"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="room_price_change_bth">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
   <!-- 删除模态框 -->
   <div class="modal fade" tabindex="-1" role="dialog"
		id="price_delete_modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">删除客房价格</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label class="control-label">type</label>
							<select class="form-control" name="hTpye" id="del_room_type_input">
                            </select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="room_price_del_bth">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

    <div class="modal fade" tabindex="-1" role="dialog"
		id="price_add_modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">添加客房价目</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label class="control-label">type</label>
							<div >
								<input type="text" name="hTpye" class="form-control "
									id="add_room_price_input" placeholder="Standard"
									ajax-val="failure"> 
									<span class="help-block"></span>
							</div>
						</div>
                        <div class="form-group">
							<label class="control-label">price</label>
							<div >
								<input type="text" name="price" class="form-control "
									id="add_room_price_input" placeholder="100"
									ajax-val="failure"> 
									<span class="help-block"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="room_price_save_bth">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<script type="text/javascript">
		$(function() {
			getTypeAndPrice();
		});
		// 		roominfo/0?pn=1&room_id=n
		function getTypeAndPrice() {
			$("#array_button").empty();
			$.ajax({
				url : "${APP_PATH}/tp",
				type : "GET",
				success : function(result) {
					buile_Array_Button(result);
				}
			});
		}
		function buile_Array_Button(result) {
			
			var prices = result.extend.list;
			$.each(prices, function(index, item) {
				var divblock = $("<div></div>").addClass("margin_btn");
				var price_button = $("<button></button>");
				if (index % 3 == 2) {
					price_button.addClass("btn btn-primary");
				} else if (index % 3 == 1) {
					price_button.addClass("btn btn-success");
				} else {
					price_button.addClass("btn btn-warning");
				}
				price_button.attr("type", "button");
				price_button.attr("data-container", "body");
				price_button.attr("data-toggle", "popover");
				price_button.attr("data-placement", "right");
				price_button.attr("data-content", item.hTpye + "型客房每天"
						+ item.price + "元");
				price_button.append(item.hTpye);
				price_button.popover();
				divblock.append(price_button).appendTo("#array_button");
			});
			
		}
		$("#modify_button").click(function(){
			$("#price_modify_modal form")[0].reset();
			$("#price_modify_modal form").find("*").removeClass("has-success has-error");
			$("#price_modify_modal form").find(".help-block").text("");
			getRoomTypes("#modify_room_type_input");
			$("#price_modify_modal").modal({
                keyboard: false
            });
		})
		function getRoomTypes(ele){
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/htype",
				type : "GET",
				success : function(result) {
					var types = result.extend.type;
					$.each(types,function(index, item) {
						var opt = $("<option></option>").append(item.hTpye);
						$(ele).append(opt);
					});
					var current_type = $(ele).val();
					getRoomPrice(current_type);	
				}
			});		
		}
		function getRoomPrice(type){
			$.ajax({
				url : "${APP_PATH}/price/"+type,
				type : "GET",
				success : function(result) {
					var price = result.extend.price;
					$("#modify_room_price_input").attr("value",price);	
				}
			});	
		}
		$("#modify_room_type_input").change(function(){
			var current_type = $("#modify_room_type_input").val();
			getRoomPrice(current_type);	
		})
		$("#room_price_change_bth").click(function(){
			$.ajax({
				url : "${APP_PATH}/tp",
				type : "PUT",
				data : $("#price_modify_modal form").serialize(),
				success : function(result) {
					if(result.code==100){
						$("#price_modify_modal").modal("hide");
						getTypeAndPrice();
					}
					
				}
			});
		})
		$("#add_button").click(function(){
			$("#price_add_modal form")[0].reset();
			$("#price_add_modal form").find("*").removeClass("has-success has-error");
			$("#price_add_modal form").find(".help-block").text("");
			$("#price_add_modal").modal({
                keyboard: false
            });
		})
		$("#room_price_save_bth").click(function(){
			$.ajax({
				url : "${APP_PATH}/tp",
				type : "POST",
				data : $("#price_add_modal form").serialize(),
				success : function(result) {
					if(result.code==100){
						$("#price_add_modal").modal("hide");
						getTypeAndPrice();
					}
					
				}
			});
		})
		$("#del_button").click(function(){
			getRoomTypes("#del_room_type_input");
			$("#price_delete_modal").modal({
                keyboard: false
            });
		})
		$("#room_price_del_bth").click(function(){
			var current_type = $("#del_room_type_input").val();
			alert(current_type);
			$.ajax({
				url : "${APP_PATH}/tp/"+current_type,
				type : "DELETE",
				success : function(result) {
					if(result.code==100){
						$("#price_delete_modal").modal("hide");
						getTypeAndPrice();
					}
					
				}
			});
		})
		

	</script>
</body>
</html>