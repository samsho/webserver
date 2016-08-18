<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:base_layout>
    <jsp:attribute name="title">
        HBase集群管理
    </jsp:attribute>
  <jsp:body>
    <div class="page-header">
      <h1>HBase集群管理</h1>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <div class="row">
          <div class="col-xs-12 widget-container-col ui-sortable">
            <div class="widget-box widget-color-blue2 ui-sortable-handle">
              <div class="widget-header">
                <h4 class="widget-title">HBase集群新增</h4>
              </div>
              <div class="widget-body">
              	<form class="form-horizontal" action="${ctx}/hcolony/save" method="post"  enctype="multipart/form-data" id="registerForm">

					<div class="form-group" id="div1">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" > 集群名称 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="name"  required data-bv-notempty-message="表名不可为空" maxlength="50"/>
						</div>
						<div class="space-4"></div>
					</div>

					<div class="form-group" id="div2">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" > 集群编号 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="code"  required data-bv-notempty-message="表名不可为空" maxlength="20"/>
						</div>
						<div class="space-4"></div>
					</div>

					<div class="form-group" id="div3">
						<label class="col-sm-4 control-label no-padding-right" > 集群角色 </label>
						<div class="radio">
							<label>
								<input name="isMaster" class="ace" type="radio" checked value="true">
								<span class="lbl"> 主</span>
							</label>
							<label>
								<input name="isMaster" class="ace" type="radio" value="false">
								<span class="lbl"> 备</span>
							</label>
						</div>
						<div class="space-4"></div>
					</div>


					<div class="form-group" id="div4" style="display: none">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right"> 对应主集群 </label>
						<div class="col-sm-7">
							<select id="masterColony" name="masterColony"  class="js-example-basic-single"  data-bv-notempty-message="请选择集群">
								<option value="">选择对应主集群</option>
								<c:forEach items="${colonys}" var="colony">
									<option value="${colony.id}">${colony.code}</option>
								</c:forEach>
							</select>
						</div>
						<div class="space-4"></div>
					</div>
					
					
					<div class="form-group" id="div9">
						<label class="col-sm-4 control-label no-padding-right" > 配置文件 <small style="color: red">*</small></label>
						<div class="ace-file-input col-sm-7" id="fileinput">
							<input type="file" id="id-input-file-1" name="file" required data-bv-notempty-message="配置文件不可为空"/>
							<small id="small1" style="display:none" class="help-block"  data-bv-result="INVALID">&nbsp;&nbsp;只能上传xml类型文件！</small>
						</div>
						<div class="space-4"></div>
					</div>
					<div class="form-actions center">
						<button class="btn btn-primary" type="submit" id="bt1">
								提交
						<i class="icon-arrow-right icon-on-right bigger-110"></i>
						</button>
						<button class="btn btn-primary" type="reset" onclick="javascript:history.back()">
								返回
						<i class="icon-arrow-right icon-on-right bigger-110"></i>
						</button>
					</div>
              	</form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="${ctx}/component/ace/assets/js/jquery.dataTables.min.js"></script>
    <script src="${ctx}/component/ace/assets/js/jquery.dataTables.bootstrap.min.js"></script>
    <script src="${ctx}/js/zh_CN.js"></script>
	<link rel="stylesheet" href="${ctx}/component/bootstrapValidator/dist/css/bootstrapValidator.min.css"/>
    <script src="${ctx}/component/bootstrapValidator/dist/js/bootstrapValidator.min.js"></script>
    <link rel="stylesheet" href="${ctx}/component/scojs/css/sco.message.css"/>
    <script src="${ctx}/component/scojs/js/sco.message.js"></script>

  	<script src="${ctx}/component/select2/select2.js"></script>
    <link rel="stylesheet" href="${ctx}/component/select2/select2.css" />

	<script>
	    $('#table').DataTable( {
	    	"language": language(),
	        paging: false
	    } );
    </script>
    <script type="text/javascript">
		$(function () {
			<c:if test="${not empty error}">
      			$.scojs_message("${error}", $.scojs_message.TYPE_ERROR);
	      	</c:if>
	      	<c:if test="${not empty success}">
	  			$.scojs_message("${success}", $.scojs_message.TYPE_OK);
	  		</c:if>

			 $('#id-input-file-1 , #id-input-file-2').ace_file_input({
					no_file:'未选择上传文件 ...',
					btn_choose:'选择上传文件',
					btn_change:'Change',
					droppable:false,
					onchange:null,
					thumbnail:false ,//| true | large
					whitelist:'xml',
					blacklist:'exe|php'
					//onchange:''
					//
				}).on('change', function () {
					var inputFile = $('#id-input-file-1').val().toLowerCase();
					if(inputFile.match(/.xml$/) != '.xml') {//java
						$('#small1').show();//显示提示消息
						//显示错误图标
						$('#fileinput').find("i").removeClass('glyphicon-ok');
						$('#fileinput').find("i").addClass('glyphicon-remove');
						//设置错误字体
						$("#div9").addClass("has-error");
						//设置表单为不可提交状态
	 					$("#bt1").attr('disabled','disabled');	
					} else {
						$("#div9").removeClass("has-error");
						$("#div9").addClass("has-success");
						$("#fileinput > .form-control-feedback").show();
						$("#fileinput > .form-control-feedback").removeClass("glyphicon-remove");
						$("#fileinput > .form-control-feedback").addClass("glyphicon glyphicon-ok");
						$("#bt1").removeAttr("disabled");
						$('#small1').hide();//
					}
					
	            });
			 $($("#fileinput").find("label")[0]).addClass("col-xs-7");



			$("#masterColony").select2({
				width : "455px"
			});


			$("input[name='isMaster']").click(function() {
				var category = this.value;
				if(category=="true") {//主集群
					$('#div4').hide();
					$('#masterColony').val(null).removeAttr("required");//删除必填属性
				} else {
					$('#div4').show();
					$('#masterColony').attr("required",true);//增加必填属性
				}
			});
		});
	</script>
  </jsp:body>
</t:base_layout>
