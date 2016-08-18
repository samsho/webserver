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
                <h4 class="widget-title">删除数据</h4>
              </div>
              <div class="widget-body">
              	<form class="form-horizontal" method="post" id="deleteForm">
					<div class="form-group">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1"> 集群 </label>
						<div class="col-sm-7">
							<select id="colony" class="select2style" name="colony" required data-bv-notempty-message="请选择集群">
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
							<select id="tableName" class="select2style" name="tableName" required data-bv-notempty-message="请选择表名">
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
							<input type="text" placeholder="f" class="col-xs-7" name="family"  data-bv-notempty-message="请输入列族"/>
						</div>
						<div class="space-4"></div>
					</div>

					
					<div class="form-group">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right"> 行健 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="rowKey" required data-bv-notempty-message="行健不可为空"/>
							<span class="help-button" data-rel="popover" data-trigger="hover" data-placement="right"
								  data-content="不输入列名，即可删除整个行健的数据" title="整行删除">?</span>
								<label>
									<input type="checkbox" id='isEncryptRow' class="ace ace-checkbox-2" name="isEncryptRow"  value="true" />
									<span class="lbl"> 行健加密</span>
								</label>
						</div>
						<div class="space-4"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-2"> 列名 </label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="qualifier"  data-bv-notempty-message="请输入列名"/>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-actions center">
						<button class="btn btn-primary" type="button" id="bt1">
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
    
     <div class="modal fade" id="deleteComfirm" data-backdrop="static" tabindex="-1" >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
          	<h4 class="modal-title">确认</h4>
          </div>
          <div class="modal-body">
            	删除整个行健数据，请确认！
          </div>
          <div class="modal-footer">
          	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-danger" id="deleteSure">确定</button>
          </div>
        </div>
      </div>
    </div>
    
   	<!-- 页面等待 -->
    <div class="modal fade" id="waiting" data-backdrop="static" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-body">
           	<p>
				<i class="fa fa-spinner fa-pulse fa-5x fa-fw margin-bottom"></i>
				<strong>正在加速提交中</strong>
			</p>
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

			/*提示格式化*/
			$('[data-rel=tooltip]').tooltip({container:'body'});
			$('[data-rel=popover]').popover({container:'body'});

			$("#colony").on("change",function(data){
				var colonyId = $(this).children('option:selected').val();//选中的集群id
				if(colony) {
					$.ajax({
	                    url: "${ctx}/hsearch/tables",
	                    type: "GET",
	                    data: "colonyId="+colonyId
	                }).done(function (response) {
	                	$("#tableName").empty();
						$("#tableName").select2("val", "");//清空选中的数据
	                	for(var i=0;i<response.length;i++){
	                		if(i==0) {
	                			$("#tableName").append("<option value='"+response[i].tableName+"' selected>"+response[i].tableName+"</option>");
	                		} else {
	                			$("#tableName").append("<option value='"+response[i].tableName+"'>"+response[i].tableName+"</option>");	
	                		}
	               		}; 
	               		$("#tableName").change();
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
	  		
	  		$('.form-horizontal').bootstrapValidator({});
	  		
	  		$("#bt1").on("click",function(){
	  			var famify = $("input[name='family']").val();
	  			var rowKey = $("input[name='rowKey']").val();
	  			var qualifier = $("input[name='qualifier']").val();
	  			
				if(rowKey) {
					$("input[name='rowKey']").removeProp("required");
					
					if(!qualifier){
					    $('#deleteComfirm').modal('show');
					    
					    $('#deleteComfirm').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
					    	$("#deleteSure").off("click").on("click",function(){//先删除“click”方法 
					    		deleteTableData();
					        })
					    })
						
					}else{
						deleteTableData();
					}
				} else {
					$("input[name='rowKey']").prop("required",true);
					$("#deleteForm").prop("action","${ctx}/htable/deleteData").submit();//作为校验使用，不可能提交 
				}
	  		})
	  		
	  		//删除数据的方法 
	  		function deleteTableData(){
	  			 $.ajax({
		    		    url:"${ctx}/htable/deleteData",
		    		    type:"post",
		    		    data:$("#deleteForm").serialize(),//提交整个表单数据 
		    		    beforeSend:function(){
		    		    	//这里是开始执行方法，显示效果，效果自己写
		    		        $('#deleteComfirm').modal('hide');
		    		    	$('#waiting').modal('show');
		    		    },
		    		    complete:function(){
		    		        //方法执行完毕，效果自己可以关闭，或者隐藏效果
		    		        $('#waiting').modal('hide');
		    		    },
		    		    success:function(data){
		    		    	//数据加载成功
		                    if("0" == data.isSuccess){
		                      $.scojs_message('数据删除成功！', $.scojs_message.TYPE_OK);
		                    }else{
		                      	$.scojs_message(data.error, $.scojs_message.TYPE_ERROR);
		                    }
		    		    },
		    		    error:function(){
		    		      //数据加载失败
		    		   }
		    		});
	  		}
	  		
	  		
		});
	</script>
  </jsp:body>
</t:base_layout>
