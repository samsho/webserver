<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    			<div class="col-xs-12">
			<div class="space-6"></div>
		</div>
      </div>
        <div class="row">
          <div class="col-xs-12 widget-container-col ui-sortable">
            <div class="widget-box widget-color-blue2 ui-sortable-handle">
              <div class="widget-header">
                <h4 class="widget-title">集群列表</h4>
                
               	<div class="widget-toolbar">
					<c:if test="${fn:contains(authorities,'colony_add')}">
						<a href="${ctx}/hcolony/add" class="btn btn-primary btn-xs" title="新增集群" data-toggle="tooltip">
							<i class="ace-icon fa bigger-125 fa-plus"></i>
						</a>
					</c:if>
                </div>
              </div>
              <div class="widget-body">
                <table class="table table-striped table-bordered table-hover" id="table">
                  <thead>
                  <tr>
                   <tr>
					<th>集群ID</th>
					<th>集群编号</th>
					<th>集群名称</th>
					<th>是否主集群</th>
					<th>对应主集群</th>
					<th>集群状态</th>
					<th>操作</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${colonys}" var="colony">
					<tr>
						<td>${colony.id}</td>
						<td>${colony.code}</td>
						<td>${colony.name}</td>
						<td>${colony.isMaster}</td>
						<td>${colony.masterName}</td>
						<td>
							<c:if test="${colony.status eq '0'}">
								<span class="label label-lg label-success">启用中</span>
							</c:if>
							
							<c:if test="${colony.status eq '2'}">
								<span class="label label-lg label-inverse arrowed-in">未启用</span>
							</c:if>
						</td>
						<td>
							<a data-toggle="modal" onclick="downConfig('${colony.id}')" class="btn btn-primary btn-xs">查看配置文件</a>

							<c:if test="${fn:contains(authorities,'colony_line')}">
								<c:if test="${colony.status eq '2'}">
									<a href="javascript" data-toggle="modal"  onclick="operateLineConfirm('${colony.id}','onLine')" class="btn btn-success btn-sm">启用</a>
								</c:if>
								
								<c:if test="${colony.status eq '0'}">
									<a href="javascript" data-toggle="modal"  onclick="operateLineConfirm('${colony.id}','offLine')" class="btn btn-danger btn-sm">停止</a>
								</c:if>
								
							</c:if> 
							<c:if test="${fn:contains(authorities,'colony_update')}">
								<a href="javascript" data-toggle="modal"  onclick="updateConfirm('${colony.id}','${colony.name}','${colony.code}')" class="btn btn-info btn-sm">修改</a>
							</c:if>
							<c:if test="${fn:contains(authorities,'colony_delete')}">
								<a href="javascript" data-toggle="modal"  onclick="deleteConfirm('${colony.id}')" class="btn btn-danger btn-sm">删除</a>
							</c:if>
						</td>
					</tr>
					</c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    
     <!-- 操作确认 -->
    <div class="modal fade" id="operateLineConfirm" data-backdrop="static" tabindex="-1" >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
          	<h4 class="modal-title">确认</h4>
          </div>
          <div class="modal-body">
            	请确认操作！
          </div>
          <div class="modal-footer">
          	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-danger" id="operateLineSure">确定</button>
          </div>
        </div>
      </div>
    </div>
	  <%--集群修改--%>
    <div class="modal fade" id="updateConfirm" data-backdrop="static" tabindex="-1" >
      <div class="modal-dialog" style="width:800px;">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
          	<h4 class="modal-title">集群修改</h4>
          </div>
          	<div class="modal-body">	
          		<div class="widget-body">
            	 	<form class="form-horizontal"  method="post"  enctype="multipart/form-data" id="updateForm">
					
						<div class="form-group" id="div1">
							<div class="space-4"></div>
							<label class="col-sm-4 control-label no-padding-right" > 集群ID </label>
							<div class="col-sm-7">
								<input type="text" placeholder="" class="col-xs-7" id="colonyId" name="id" required readonly="readonly" maxlength="50"/>
							</div>
							<div class="space-4"></div>
						</div>

						<div class="form-group" id="div2">
							<div class="space-4"></div>
							<label class="col-sm-4 control-label no-padding-right" > 集群编号 </label>
							<div class="col-sm-7">
								<input type="text" placeholder="" class="col-xs-7" id="colonyCode" name="code" required readonly="readonly" maxlength="50"/>
							</div>
							<div class="space-4"></div>
						</div>
						
						<div class="form-group" id="div3">
							<div class="space-4"></div>
							<label class="col-sm-4 control-label no-padding-right" > 集群名称 </label>
							<div class="col-sm-7">
								<input type="text" placeholder="" class="col-xs-7" id="colonyName" name="name" required data-bv-notempty-message="表名不可为空" maxlength="50"/>
							</div>
							<div class="space-4"></div>
						</div>
					
					
					<div class="form-group" id="div9">
						<label class="col-sm-4 control-label no-padding-right" > 配置文件 </label>
						<div class="ace-file-input col-sm-7" id="fileinput">
							<input type="file" id="id-input-file-1" name="file" required data-bv-notempty-message="配置文件不可为空"/>
							<small id="small1" style="display:none" class="help-block"  data-bv-result="INVALID">&nbsp;&nbsp;只能上传xml类型文件！</small>
						</div>
						<div class="space-4"></div>
					</div>
					
					
					<div class="form-actions center">
						<button class="btn btn-primary" type="submit" id="bt1">
								修改
						<i class="icon-arrow-right icon-on-right bigger-110"></i>
						</button>
					</div>
              	</form>
              	</div>
          </div>

          <div class="modal-footer">
          </div>
        </div>
      </div>
    </div>

	  <!-- 删除确认 -->
	  <div class="modal fade" id="deleteConfirm" data-backdrop="static" tabindex="-1" >
		  <div class="modal-dialog">
			  <div class="modal-content">
				  <div class="modal-header">
					  <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
					  <h4 class="modal-title">确认</h4>
				  </div>
				  <div class="modal-body">
					  删除集群，暂不会操作任何表信息，确认删除该集群吗？
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

    <link rel="stylesheet" href="${ctx}/component/scojs/css/sco.message.css"/>
	<link rel="stylesheet" href="${ctx}/component/font-awesome/css/font-awesome.min.css">

    <script src="${ctx}/component/ace/assets/js/jquery.dataTables.min.js"></script>
    <script src="${ctx}/component/ace/assets/js/jquery.dataTables.bootstrap.min.js"></script>
    <script src="${ctx}/js/zh_CN.js"></script>
    <link rel="stylesheet" href="${ctx}/component/scojs/css/sco.message.css"/>
    <script src="${ctx}/component/scojs/js/sco.message.js"></script>
 

    <script>
      $(function () {
        var table = $("#table").dataTable({
        	"lengthChange": false,
          	"language": language(),
          	"bFilter": true,                       //使用过滤功能
          	paging: true,
          	iDisplayLength:10,
          	"bAutoWidth": true//自动宽度
        }).api();
        
        
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
     
      });

	  /**
	   * 查看集群配置文件
	   * @param colonyId
	   */
	  function downConfig(colonyId){
		  location.href = "${ctx}/hcolony/downConfig?colonyId="+colonyId;
	  }



      /**
	     * 集群操作确认
	     * @param id
	     */
	    function operateLineConfirm(colonyId,operate){
    	  $('#operateLineConfirm').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
    		  $("#operateLineSure").on("click",function(){
	        	 $.ajax({
		    		    url:"${ctx}/hcolony/operateLine",
		    		    type:"post",
		    		    data: "colonyId="+colonyId + "&operate="+operate,  
		    		    beforeSend:function(){
		    		        //这里是开始执行方法，显示效果，效果自己写
		    		        $('#operateLineConfirm').modal('hide');
		    		    	$('#waiting').modal('show');
		    		    },
		    		    complete:function(){
		    		        //方法执行完毕，效果自己可以关闭，或者隐藏效果
		    		        $('#waiting').modal('hide');
		    		    },
		    		    success:function(data){
		    		        //数据加载成功
		                    if("0" == data.isSuccess){
		                      $.scojs_message('操作成功！', $.scojs_message.TYPE_OK);
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
	    }


	  /**
	   * 删除确认
	   * @param id
	   */
	  function deleteConfirm(colonyId){
		  $('#deleteConfirm').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
			  $("#deleteSure").on("click",function(){
				  $.ajax({
					  url:"${ctx}/hcolony/delete",
					  type:"post",
					  data: "colonyId="+colonyId,
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
							  $.scojs_message('删除成功！', $.scojs_message.TYPE_OK);
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
	  }
      
      	// 集群修改操作
	    function updateConfirm(colonyId,colonyName,colonyCode) {
	    	$("#colonyName").val(colonyName);
	    	$("#colonyId").val(colonyId);
	    	$("#colonyCode").val(colonyCode);
	    	$("#updateConfirm").modal('show').on('shown.bs.modal',function(){
	    		
	    		$("#bt1").on("click",function(){
	    			 $('#updateConfirm').modal('hide');
	    		     $('#waiting').modal('show');
	    		     $("#updateForm").attr('action','${ctx}/hcolony/update').submit();
	    		     
	    		})
	    		
	    	})
	    }
      
      
      
	$(function () {
		<c:if test="${not empty error}">
       		$.scojs_message("${error}", $.scojs_message.TYPE_ERROR);
       	</c:if>
       	<c:if test="${not empty success}">
   			$.scojs_message("${success}", $.scojs_message.TYPE_OK);
   		</c:if>
   		
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
