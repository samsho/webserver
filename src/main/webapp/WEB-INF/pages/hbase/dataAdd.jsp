<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:base_layout>
    <jsp:attribute name="title">
       	 数据操作
    </jsp:attribute>
  <jsp:body>
    <div class="page-header">
      <h1>数据操作</h1>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <div class="row">
          <div class="col-xs-12 widget-container-col ui-sortable">
            <div class="widget-box widget-color-blue2 ui-sortable-handle">
              <div class="widget-header">
                <h4 class="widget-title">添加数据</h4>
              </div>
              <div class="widget-body">
              	<form class="form-horizontal" action="${ctx}/htable/saveData" method="post">
					<div class="form-group">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1"   data-bv-notempty-message="请选择集群"> 集群 </label>
						<div class="col-sm-7">
							<select id="colony" class="select2style" required name="colony" >
						    	<c:forEach items="${colonys}" var="colo">
							    	<option value="${colo.id}">${colo.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1"> 表名 </label>
						<div class="col-sm-7">
							<select id="tableName" class="select2style" name="tableName"  required data-bv-notempty-message="请选择表名">
								<c:forEach items="${tables}" var="table">
							    	<option value="${table.tableName}">${table.tableName}</option>
								</c:forEach>
							</select>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-2"> 列族 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="f" class="col-xs-7" name="family"  maxlength="50"/>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1" > 行健 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="rowKey"  required data-bv-notempty-message="请输入行健" maxlength="100"/>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-2"> 列名 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="qualifier"  required data-bv-notempty-message="请输入列名"  maxlength="50"/>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-2"> 值 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="value"  required data-bv-notempty-message="请输入值"/>
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
     <script src="${ctx}/component/ace/assets/js/chosen.jquery.min.js"></script>
     <link href="${ctx}/component/ace/assets/css/chosen.css" rel="stylesheet">

	  <script src="${ctx}/component/select2/select2.js"></script>
	  <link rel="stylesheet" href="${ctx}/component/select2/select2.css" />
 
	<script>
		$(".chosen-select").chosen();
	    $('#table').DataTable( {
	    	"language": language(),
	        paging: false
	    } );
    </script>
    <script type="text/javascript">
		$(function () {

			$("#colony,#tableName").select2({
				width : "58.5%"
			});

			$("#colony").on("change",function(data){
				var colonyId = $(this).children('option:selected').val();//选中的集群id
				if(colony) {
					$.ajax({
	                    url: "${ctx}/hsearch/tables",
	                    type: "GET",
	                    data: "colonyId="+colonyId
	                }).done(function (response) {
						$('#tableName').empty();
						$("#tableName").select2("val", "");//清空选中的数据
	                	for(var i=0;i<response.length;i++){
	                		if(i==0) {
	                			$("#tableName").append("<option value='"+response[i].tableName+"' selected>"+response[i].tableName+"</option>");
	                		} else {
	                			$("#tableName").append("<option value='"+response[i].tableName+"'>"+response[i].tableName+"</option>");	
	                		}
	               		}; 
						$('#tableName').change();
	                }).fail(function (jqXHR) {
	                    $.scojs_message("加载表失败：<em>" + getError(jqXHR) + "</em>", $.scojs_message.TYPE_ERROR);
	                });
				} 
			});
			<c:if test="${not empty error}">
      			$.scojs_message("${error}", $.scojs_message.TYPE_ERROR);
	      	</c:if>
	      	<c:if test="${not empty success}">
	  			$.scojs_message("${success}", $.scojs_message.TYPE_OK);
	  		</c:if>
			
			 $('.form-horizontal').bootstrapValidator({
		    });
			 
			 
		});
	</script>
  	<style  type="text/css">
		.chosen-container-single .chosen-single {
			height: 31px;
		}
    </style>
  </jsp:body>
</t:base_layout>
