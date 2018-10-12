<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Check In</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"  rel="stylesheet">
<link href="${APP_PATH}/static/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
<style type="text/css">
#time_select1 {
	background:white;
}
#time_select2 {
	background:white;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/view/nav.jsp"></jsp:include>
	<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<form >

					<fieldset>
						<div class="form-group">
							<label class="control-label">phone_number</label>
							<div >
								<input type="text" name="pNum" class="form-control "
									id="user_phone_input" placeholder="17806236255"
									ajax-val="failure"> 
									<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label">room type</label>
							<select class="form-control" id="room_tpye_input">
                            </select>
						</div>
						<div class="form-group">
							<label class="control-label">room</label>
							<select class="form-control" name="rId" id="room_id_input">
                            </select>
						</div>
						
						<!-- calendar -->
						<div class="form-group">
							<label >start date</label>
							<div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd">
								<input id="time_select1"  class="form-control" value="" readonly="" 
								   type="text" placeholder="2018-10-03" name="startDate" ajax-val="failure" > 
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-remove"></span>
									</span> 
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
							</div>
						</div>
						<div class="form-group">
							<label>end date</label>
							<div class="input-group date form_date" data-date=""
								data-date-format="yyyy-mm-dd" >
								<input id="time_select2"  class="form-control"  value="" readonly=""
								    type="text" placeholder="2018-10-04" name="endDate" ajax-val="failure"> 
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-remove"></span>
									</span> 
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
							</div>
						</div>
						

						<div class="form-group">
							<div class="col-md-2 col-md-offset-5">
								<button type="button" class="btn btn-primary" id="user_save_btn">
								<span class="glyphicon glyphicon-book" aria-hidden="true"> </span> 入住</button>
							</div>
						</div>
					</fieldset>


				</form>
			</div>
		</div>
	</div>
	<div class="modal fade" id="checkin_resultTip" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">温馨提示</h4>
            </div>
            <div class="modal-body" id="checkin_tipMsg"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div>
   </div>
	<script type="text/javascript">
		$("form")[0].reset();
		$(function() {
			getRoomTypes();
		});
		$("#user_phone_input").change(function() {
			var phone = this.value;
			$.ajax({
				url : "${APP_PATH}/checkUser",
				data : "phone=" + phone,
				type : "POST",
				success : function(result) {
					if (result.extend.exit==true) {
						validate_show("#user_phone_input", 1,
								"The member is "+result.extend.name+", "+result.extend.level+" member");
						$("#user_phone_input").attr("ajax-val","success");
					} else {
						validate_show("#user_phone_input", 2,
								"The member don't exit,register please");
						$("#user_phone_input").attr("ajax-val","failure");
					}
				}
			});		
		});
		function getRoomByType(room_type){
			$("#room_id_input").empty();
			$.ajax({
				url : "${APP_PATH}/room/"+room_type,
				type : "GET",
				success : function(result) {
					var rooms = result.extend.room;
					$.each(rooms,function(index, item) {
						var opt = $("<option></option>").append(item.roomId);
						opt.appendTo("#room_id_input");
					});
				}
			});		
		}
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
		$("#room_tpye_input").change(function() {
			var room_type = this.value;
			getRoomByType(room_type);			
		});
		$("#time_select1").change(function() {
			if($("#time_select1").val()==""){
				$("#time_select1").attr("ajax-val","failure");
			}else{
				$("#time_select1").attr("ajax-val","success");
			}
				
		});
		$("#time_select2").change(function() {
			if($("#time_select2").val()==""){
				$("#time_select2").attr("ajax-val","failure");
			}else{
				$("#time_select2").attr("ajax-val","success");
			}
				
		});
		

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
		
		$("#user_save_btn").click(function() {
			alert($("form").serialize());
			if ($("#user_phone_input").attr("ajax-val") == "failure"
				|| $("#time_select1").attr("ajax-val") == "failure"
				|| $("#time_select2").attr("ajax-val") == "failure") {
			    return;
		    }
			$.ajax({
				url : "${APP_PATH}/checkin",
				type : "POST",
				data : $("form").serialize(),
				success : function(result) {
					//alert(result.msg);
					if (result.code == 100) {
						$("#checkin_tipMsg").empty();
						$("#checkin_tipMsg").append("一天需花费"+result.extend.price+"元, 总费用为 "+result.extend.total_price+" 元.");
					} else {
						$("#checkin_tipMsg").empty();
						$("#checkin_tipMsg").append("请正确填写住房日期！");
					}
					$('#checkin_resultTip').modal({
	                       keyboard: false
	                });
					$("form")[0].reset();
					$("form").find("*").removeClass("has-success has-error");
					$("form").find(".help-block").text("");
				}
			});

	});
	$('#resultTip').on('hide.bs.modal', function() {
		if (isSuccess) {
			window.location.href = "${APP_PATH}/";
		}	
	})	
	</script>
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/static/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
	<script type="text/javascript" src="${APP_PATH}/static/js/locales/bootstrap-datetimepicker.fr.js" charset="UTF-8"></script>
	<script type="text/javascript">
		$('.form_date').datetimepicker({
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			minView : 2,
			forceParse : 0
		});
	</script>
	<div
		class="datetimepicker datetimepicker-dropdown-bottom-right dropdown-menu"
		style="left: 678px; z-index: 1020;">
	</div>
</body>
</html>