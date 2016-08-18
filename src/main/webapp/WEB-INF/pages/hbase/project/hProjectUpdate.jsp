<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:base_layout>
    <jsp:attribute name="title">
        HBase项目管理
    </jsp:attribute>
  <jsp:body>
    <div class="page-header">
      <h1>HBase项目管理</h1>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <div class="row">
          <div class="col-xs-12 widget-container-col ui-sortable">
            <div class="widget-box widget-color-blue2 ui-sortable-handle">
              <div class="widget-header">
                <h4 class="widget-title">HBase项目新增</h4>
              </div>
              <div class="widget-body">
              	<form class="form-horizontal" action="${ctx}/hproject/updateData" method="post">
              		<input name="id" id="projectId" value="${projectId }" hidden="true"/>
              		<div class="form-group" id="div0">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" > 项目名称 </label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="projectName" value="${project.projectName }" required data-bv-notempty-message="项目名称不可为空" maxlength="50"/>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group" id="div1">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" > 项目代码 </label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="projectCode" value="${project.projectCode }" readonly required data-bv-notempty-message="项目代码不可为空" maxlength="50"/>
						</div>
						<div class="space-4"></div>
					</div>
              		<div class="form-group" id="div2">
						<div class="space-4"></div>
						
						<label class="col-sm-4 control-label no-padding-right"> 项目主负责 </label>
						<div class="col-sm-7">
							<select id="mainPresiderId" name="mainPresiderId" class="js-example-basic-single" required data-bv-notempty-message="请选择项目主负责">
						    	<c:forEach items="${presiders}" var="presider">
						    		<c:choose>
						    			<c:when test="${project.mainPresider.id == presider.id}">
					                    	<option value="${presider.id}" selected>${presider.name}</option>
					                    </c:when>
					                    <c:otherwise>
					                    	<option value="${presider.id}">${presider.name}</option>
					                    </c:otherwise>
	            					</c:choose>
								</c:forEach>
							</select>
						</div>
						<div class="space-4"></div>
					</div>
					<div class="form-group" id="div3">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right"> 项目从负责 </label>
						<div class="col-sm-7">
							<select id="deputyPresiderIds" name="deputyPresiderIds"  class="js-example-basic-multiple" multiple="multiple" >
						    	<c:forEach items="${presiders}" var="presider">
					            	<option value="${presider.id}">${presider.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="space-4"></div>
					</div>
					
										
					<div class="form-group" id="div4">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" > 项目描述 </label>
						<div class="col-sm-7">
							<textarea class="col-xs-7" name="projectDescription"  required data-bv-notempty-message="表名不可为空" maxlength="50">${project.projectDescription } </textarea>
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
	  		
	  		$("#deputyPresiderIds").select2({
	  			width : "455px",
	  		});
	  		$(".js-example-basic-single").select2({
	  			width : "455px"
	  		});
	  		
	  		
			/**
			* 下拉多选框自动选中
			*/
			var fillMuiltSelect = function(){
				var selectedArray = [];
				var presiderIds = ${presiderIds};
 				$.each(presiderIds,function(index,item){
					selectedArray.push(item);
				}); 
				$("#deputyPresiderIds").val(selectedArray).trigger("change");
				
			}
			
			fillMuiltSelect();
		});
	</script>
  </jsp:body>
</t:base_layout>
