<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:base_layout>
    <jsp:attribute name="title">
        HBase项目人员管理
    </jsp:attribute>
  <jsp:body>
    <div class="page-header">
      <h1>HBase人员管理</h1>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <div class="row">
          <div class="col-xs-12 widget-container-col ui-sortable">
            <div class="widget-box widget-color-blue2 ui-sortable-handle">
              <div class="widget-header">
                <h4 class="widget-title">HBase项目人员新增</h4>
              </div>
              <div class="widget-body">
              	<form class="form-horizontal" action="${ctx}/hpresider/save" method="post">
              		
              		<div class="form-group" id="div0">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" > 人员名称 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="name"  required data-bv-notempty-message="人员名称不可为空" maxlength="50"/>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group" id="div1">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" > 人员工号 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="jobNumber"  required data-bv-notempty-message="人员工号不可为空" maxlength="50"/>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group" id="div1">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" > 所属部门 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="deptName"  required data-bv-notempty-message="所属部门不可为空" maxlength="50"/>
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
		});
	</script>
  </jsp:body>
</t:base_layout>
