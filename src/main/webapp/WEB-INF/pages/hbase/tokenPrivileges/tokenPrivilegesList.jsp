<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<t:base_layout>
	<jsp:attribute name="title">
       	 权限分配
    </jsp:attribute>

	<jsp:body>
	 	<div class="page-header">
	      <h1>Token权限操作</h1>
	    </div>
	    <div class="row">
	      <div class="col-xs-12">
	      	<div class="row">
    			<div class="col-xs-12">
					<div class="space-6"></div>
					<div class="widget-box">
						<div class="widget-body">
							<div class="widget-main">
								<form class="form-inline" name="form" action="${ctx}/tokenPrivileges/listData" id="form" method="POST">
									<div class="form-group">
										<label>Token：</label>
										<select id="tokenId" class="select2style" name="tokenId" required oninvalid="setCustomValidity('请选择Token')" oninput="setCustomValidity('')">
											<c:forEach items="${tokens}" var="token">
												<c:choose>
													<c:when test="${tokenId == token.id}">
														<option value="${token.id}" selected>${token.token}</option>
													</c:when>
													<c:otherwise>
														<option value="${token.id}">${token.token}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>

									<div class="form-group">
										<label>项&nbsp;&nbsp;目：</label>
										<input type="text" placeholder="" class="form-control" name="projectCode" required data-bv-notempty-message="項目不可为空" maxlength="50" readonly="readonly" />
									</div>

									<div class="form-group">
										<label>集&nbsp;&nbsp;群：</label>
										<select id="colonyId" class="select2style" name="colonyId" required oninvalid="setCustomValidity('请选择集群')" oninput="setCustomValidity('')">
											<c:forEach items="${colonys}" var="colony">
												<c:choose>
													<c:when test="${colonyId == colony.id}">
														<option value="${colony.id}" selected>${colony.name}</option>
													</c:when>
													<c:otherwise>
														<option value="${colony.id}">${colony.name}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>

									<button class="btn btn-purple btn-sm" id="submit" type="submit">
										查询
										<i class="icon-search icon-on-right bigger-110"></i>
									</button>

								<%--	<div class="checkbox">
										<label>
											<input type="checkbox" id='batchAuthorize' class="ace ace-checkbox-2" name="form-field-checkbox"  />
											<span class="lbl"> 批量分配</span>
										</label>
									</div>--%>
								</form>

							<%--	<form class="form-search" name="form" action="${ctx}/tokenPrivileges/initData" id="form" method="POST">
									<div class="row">
										<div class="col-xs-12  col-sm-12">
											<div class="input-group col-xs-12  col-sm-12">
												<label class="col-xs-12  col-sm-12 la">Token：</label>
												<select id="tokenId" class="select2style" name="tokenId" required oninvalid="setCustomValidity('请选择Token')" oninput="setCustomValidity('')">
											    	<c:forEach items="${tokens}" var="token">
								                   		<c:choose>
										                    <c:when test="${tokenId == token.id}">
										                   		<option value="${token.id}" selected>${token.token}</option>
										                    </c:when>
										                    <c:otherwise>
										                    	<option value="${token.id}">${token.token}</option>
										                    </c:otherwise>
					            						</c:choose>
													</c:forEach>
												</select>&nbsp;
												<label class="col-xs-6  col-sm-6 la">项&nbsp;&nbsp;目：</label>
												<input type="text" placeholder="" class="col-xs-2" name="projectCode" required data-bv-notempty-message="項目不可为空" maxlength="50" readonly="readonly" />
												
												<label class="col-xs-8  col-sm-8 la">集&nbsp;&nbsp;群：</label>
												<select id="colonyId" class="select2style" name="colonyId" required oninvalid="setCustomValidity('请选择集群')" oninput="setCustomValidity('')">
											    	<c:forEach items="${colonys}" var="colony">
												    	<c:choose>
										                    <c:when test="${colonyId == colony.id}">
										                    	<option value="${colony.id}" selected>${colony.name}</option>
										                    </c:when>
									                    	<c:otherwise>
									                    		<option value="${colony.id}">${colony.name}</option>
									                    	</c:otherwise>
					            						</c:choose>
													</c:forEach>
												</select>&nbsp;
									
												
												<button class="btn btn-purple btn-sm" id="submit" type="submit">
													查询
													<i class="icon-search icon-on-right bigger-110"></i>
												</button>&nbsp;
															
										&lt;%&ndash;		<label>
								                    <input type="checkbox" id='batchAuthorize' class="ace ace-checkbox-2" name="form-field-checkbox"  />
													<span class="lbl"> 批量分配</span>
												</label>&ndash;%&gt;
											</div>
										</div>
									</div>
								</form>--%>



							</div>
						</div>
					</div>
				</div>
      		</div>
      		<div class="space-8"></div>
	      	<div class="row">
				<div class="col-xs-12 widget-container-col ui-sortable">
	            <div class="widget-box widget-color-blue2 ui-sortable-handle">
	              <div class="widget-header">
	                <h4 class="widget-title">数据列表</h4>
	              </div>
	             <div class="widget-body">
	                <table class="table table-striped table-bordered table-hover" id="table">
	                  <thead>
	                  <tr>
	                   <tr>
						<th>表名</th>
						<th>操作</th>
	                  </tr>
	                  </thead>
	                  <tbody id="table_div">
	                  <c:forEach items="${priModels}" var="table">
						<tr>
							<td>${table.tableName}</td>
							<td>
								<div class="control-group">
									<c:forEach items="${functions}" var="fun">
										<label>
											<c:choose>
						                    <c:when test="${fn:contains(table.checkedIds,fun.id)}">
						                    <input id="tableFunction" type="checkbox" class="ace ace-checkbox-2" name="form-field-checkbox" value="${fun.id}" checked />
						                    </c:when>
						                    <c:otherwise>
						                    <input id="tableFunction" type="checkbox" class="ace ace-checkbox-2" name="form-field-checkbox" value="${fun.id}"  />
						                    </c:otherwise>
			            					</c:choose>
										<span class="lbl"> ${fun.name}</span>
										</label>
									</c:forEach>
								</div>
							</td>
						</tr>
					  </c:forEach>
	                  </tbody>
	                  
	                  <tbody style="display:none" id="batchTable_div">
							<tr>
								<td>${batchTables}</td>
								<td>
									<div class="control-group">
										<c:if test="${!empty batchTables}">
											<c:forEach items="${functions}" var="fun">
												<label>
								                    <input id="batchTableFunction" type="checkbox" class="ace ace-checkbox-2" name="form-field-checkbox" value="${fun.id}"  />
													<span class="lbl"> ${fun.name}</span>
												</label>
											</c:forEach>
											&nbsp;
											<a data-toggle="modal" id="batchTableButton" class="btn btn-danger btn-sm">批量分配</a>
										</c:if>
									</div>
								</td>
							</tr>
	                  </tbody>
	                  
	                </table>
	              </div>
	            </div>
	          </div>
			</div>
			
	      </div>
      	</div>
    
    <!-- 批量分配确认 -->
<%--    <div class="modal fade" id="deleteConfirm" data-backdrop="static" tabindex="-1" >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
          	<h4 class="modal-title">确认</h4>
          </div>
          <div class="modal-body">
            	确认给Token管理下所有表，批量分配权限？
          </div>
          <div class="modal-footer">
          	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-danger" id="deleteSure">确定</button>
          </div>
        </div>
      </div>
    </div>--%>
    
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

	<link rel="stylesheet" href="${ctx}/component/scojs/css/sco.message.css"/>
	<link rel="stylesheet" href="${ctx}/component/font-awesome/css/font-awesome.min.css">

    <script src="${ctx}/component/ace/assets/js/jquery.dataTables.min.js"></script>
    <script src="${ctx}/component/ace/assets/js/jquery.dataTables.bootstrap.min.js"></script>
    <script src="${ctx}/js/zh_CN.js"></script>
    <link rel="stylesheet" href="${ctx}/component/scojs/css/sco.message.css"/>
    <script src="${ctx}/component/scojs/js/sco.message.js"></script>

		<script src="${ctx}/component/select2/select2.js"></script>
		<link rel="stylesheet" href="${ctx}/component/select2/select2.css" />
		<script type="text/javascript">
			$(function () {

				$("#tokenId").select2({
					width:"320px"
				});

				$("#colonyId").select2({
					width:"180px"
				});

				$("#table").DataTable({
		        	"lengthChange": false,
		          	"bFilter": true,                       //不使用过滤功能   
		          	paging: true,
		          	iDisplayLength:10,
		          	"bAutoWidth": true,//自动宽度
		          	 "language": language()
		        });


			 	//单一分配权限 
			 	$("body").delegate('#table input[id="tableFunction"]', 'click', function () { 
			 		var tokenId = $("select[name='tokenId']").val();//Token
			 		var colonyId = $("select[name='colonyId']").val();//Token
			 		var tableName=$(this).parent().parent().parent().prev().text();//表名
			 		
			 		var functionId = $(this).val();//操作：添加、删除...
			 		var isAdd = $(this).is(':checked');//是否选中

			 		 $.ajax({
	                        url: "${ctx}/tokenPrivileges/authorize",
	                        type: "post",
	                        data: "tokenId="+tokenId+"&colonyId="+colonyId+"&tableName="+tableName+"&isAdd="+isAdd+"&functionId="+functionId,
							 success:function(data){
								 //数据加载成功
								 if("1" == data.isSuccess){
									 $.scojs_message(data.error, $.scojs_message.TYPE_ERROR);
								 }
							 }
	                 });
			 	});
			 	
			 	//动态显示
/*			 	$("#batchAuthorize").on('click',function(){
			 		var isSelected = $(this).is(':checked');//是否选中批量 
			 		if(isSelected){
			 			$("#table_div").css("display","none"); 
			 			$("#batchTable_div").css("display","");
			 		}else{
			 			$("#table_div").css("display",""); 
			 			$("#batchTable_div").css("display","none"); 
			 		}
			 	});*/
			 
			 	//根据Token显示项目名称 
			 	showProjectName();
			 	$("#tokenId").on("change",function(){
			 		showProjectName();
			 	})
				function showProjectName (){
					var tokenId = $("#tokenId").val();
			 		var projectName = $("input[name='projectCode']");
				 	if(tokenId){
					 	 $.ajax({
			    		    url:"${ctx}/tokenPrivileges/getProjectByToken",
			    		    type:"get",
			    		    data: "tokenId="+tokenId,
			    		    success:function(data){
			    		    	projectName.val(data);
			    		    }
				    	 });
				 	}else{
				 		projectName.val('');
				 	}
				 };
				 
/*				 $("#batchTableButton").on("click",function(){
					 
					 var tokenId = $("select[name='tokenId']").val();//Token
				     var colonyId = $("select[name='colonyId']").val();//集群 
				     var batchFunctions=""; 
					 $("input[id=batchTableFunction]").each(function() {  
				         if ($(this).is(':checked')) {  
				        	 batchFunctions += $(this).val()+",";  
				            }  
				     });  
					 batchFunctions = batchFunctions.substring(0,batchFunctions.length-1); 
					 
					 
					 $('#deleteConfirm').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
					        $("#deleteSure").on("click",function(){
					        	 $.ajax({
						    		    url:"${ctx}/tokenPrivileges/batchAuthorize",
						    		    type:"post",
						    		    data: "batchFunctions="+batchFunctions+"&tokenId="+tokenId+"&colonyId="+colonyId,  
						    		    beforeSend:function(){
						    		        //这里是开始执行方法，显示效果，效果自己写
						    		        $('#deleteConfirm').modal('hide');
						    		    	$('#waiting').modal('show');
						    		    },
						    		    complete:function(){
						    		        //方法执行完毕，效果自己可以关闭，或者隐藏效果
						    		        $('#waiting').modal('hide');
						    		    },
						    		    success:function(data){
						    		        //数据加载成功
						                    if("0" == data.isSuccess){
						                      $.scojs_message('批量配置成功！', $.scojs_message.TYPE_OK);
						                    }else{
						                      	$.scojs_message(data.error, $.scojs_message.TYPE_ERROR);
						                    }
						                    window.setTimeout(function(){
						                      location.reload();
						                    },1000);
						    		    },
						    		    error:function(){
						    		      //数据加载失败
						    		   }
						    		});
					        });
					      });
					
				 })*/
				 
			 	
			});
			
		</script>
	   <style type="text/css">
		.la {
			width:100px;
			line-height:31px;
		}
	</style>
  </jsp:body>
</t:base_layout>
