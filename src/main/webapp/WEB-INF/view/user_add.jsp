<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register Member</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/view/nav.jsp"></jsp:include>
	<div class="container">
		<!-- button -->
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<form class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-3 control-label">phone_number</label>
						<div class="col-sm-9">
							<input type="text" name="phoneNum" class="form-control"
								id="user_phone_input" placeholder="17806236255" ajax-val="failure"> <span
								class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">name</label>
						<div class="col-sm-9">
							<input type="text" name="name" class="form-control"
								id="user_name_input" placeholder="Zhang San" ajax-val="failure"> <span
								class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">identification</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" name="identification"
								id="user_identification_input" placeholder="370725199610094611" ajax-val="failure">
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">password</label>
						<div class="col-sm-9">
							<input type="password" class="form-control" name="pass"
								id="user_pass_input" placeholder="password" ajax-val="failure"> <span
								class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">password_again</label>
						<div class="col-sm-9">
							<input type="password" class="form-control"
								id="user_pass_again_input" placeholder="password" ajax-val="failure"> <span
								class="help-block"></span>
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
					<div class="form-group">
						<div class="col-md-2 col-md-offset-5">
							<button type="button" class="btn btn-primary" id="user_save_btn" >
							<span class="glyphicon glyphicon-send" aria-hidden="true"> </span> 立即注册</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="modal fade" id="resultTip" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">温馨提示</h4>
            </div>
            <div class="modal-body" id="tipMsg">注册成功</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div>
   </div>
	<script type="text/javascript">
	    $("form")[0].reset();
		$("#user_phone_input").change(function() {
			var phone = this.value;
			var regPhone = /^[0-9]{11}$/;
			if (!regPhone.test(phone)) {
				validate_show("#user_phone_input", 2,
						"The length of phone number should be 11");
				$("#user_phone_input").attr("ajax-val","failure");
				return;
			}
			//alert(phone);
			$.ajax({
				url : "${APP_PATH}/checkUser",
				data : "phone=" + phone,
				type : "POST",
				success : function(result) {
					if (result.extend.exit == false) {
						validate_show("#user_phone_input", 1,
								"phone number is available");
						$("#user_phone_input").attr("ajax-val","success");
					} else {
						validate_show("#user_phone_input", 2,
								"phone number is not available");
						$("#user_phone_input").attr("ajax-val","failure");
					}
				}
			});			
		});
		$("#user_name_input").change(function() {
			var name = this.value;
			//var regName = /(^[a-zA-Z0-9_-]{5,15}$)|(^[\u2E80-\u9FFF]{2,9})/;
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,9})/;
			if (!regName.test(name)) {
				validate_show("#user_name_input", 2,
						"The name should be 6 to 16 English characters or 2 to 9 Chinese characters.");
				$("#user_name_input").attr("ajax-val","failure");
			} else {
				validate_show("#user_name_input", 1, "name is available");
				$("#user_name_input").attr("ajax-val","success");
			}		
		});
		$("#user_identification_input").change(function() {
			var id = this.value;
			var regId = /^[0-9]{18}$/;
			if (!regId.test(id)) {
				validate_show("#user_identification_input", 2,
						"The length of identification should be 18.");
				$("#user_identification_input").attr("ajax-val","failure");
			} else {
				validate_show("#user_identification_input", 1,
						"identification is available");
				$("#user_identification_input").attr("ajax-val","success");
			}
		});
		$("#user_pass_input").change(function() {
			var pass1 = $("#user_pass_input").val();
			var regPass = /^[a-zA-Z0-9_-]{6,18}$/;
			if (!regPass.test(pass1)) {
				validate_show("#user_pass_input", 2,
						"The length of password should be 6 to 18");
				$("#user_pass_input").attr("ajax-val","failure");
			} else {
				validate_show("#user_pass_input", 1, "password is available");
				$("#user_pass_input").attr("ajax-val","success");
			}
		});
		$("#user_pass_again_input").change(function() {
			var pass1 = $("#user_pass_input").val();
			var pass2 = $("#user_pass_again_input").val();
			if (pass1 != pass2) {
				validate_show("#user_pass_again_input", 2,
						"The password entered two times is inconsistent.");
				$("#user_pass_again_input").attr("ajax-val","failure");
			}else{
				validate_show("#user_pass_again_input", 1, "The password entered two times is consistent.");
				$("#user_pass_again_input").attr("ajax-val","success");
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
			;
		}
		var isSuccess = false;
		$("#user_save_btn").click(function() {
			if($("#user_phone_input").attr("ajax-val")=="failure" ||
					$("#user_name_input").attr("ajax-val")=="failure" ||
					$("#user_identification_input").attr("ajax-val")=="failure" ||
					$("#user_pass_input").attr("ajax-val")=="failure" ||
					$("#user_pass_again_input").attr("ajax-val")=="failure"){
				return;
			}
			$.ajax({
				url : "${APP_PATH}/user",
				type : "POST",
				data : $("form").serialize(),
				success : function(result) {
					//alert(result.msg);
					if(result.code==100){
						isSuccess= true;
					}else{
						$("#tipMsg").empty();
						$("#tipMsg").append("注册失败!");
					}
					$('#resultTip').modal({
	                       keyboard: false
	                });
				}
			});
		});
		$('#resultTip').on('hide.bs.modal',function() {
			if(isSuccess){
				window.location.href = "${APP_PATH}/";
			}		
		})
	</script>
</body>
</html>