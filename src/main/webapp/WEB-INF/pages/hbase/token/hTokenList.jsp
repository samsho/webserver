<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<t:base_layout>
    <jsp:attribute name="title">
       HBase Token管理
    </jsp:attribute>
  <jsp:body>
    <div class="page-header">
      <h1>HBase Token管理</h1>
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
                <h4 class="widget-title">Token列表</h4>
                
               	<div class="widget-toolbar">
					<c:if test="${fn:contains(authorities,'token_add')}">
						  <a href="${ctx}/htoken/add" class="btn btn-primary btn-xs" title="新增Token" data-toggle="tooltip">
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
					<th>Token编号</th>
					<th class="hidden-480">Token标识码</th>
					<th><i class="icon-time bigger-110 hidden-480"></i>
						项目代码</th>
					<th>项目名称</th>
				    <%--<th>操作</th>--%>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${tokens}" var="token">
					<tr>
						<td>${token.id}</td>
						<td>${token.token}</td>
						<td>${token.project.projectCode}</td>
						<td>${token.project.projectName}</td>
						<%--<td>
							<a href="${ctx}/htoken/distribute?token=${token.id}" data-toggle="modal" class="btn btn-info btn-sm">分配表</a>
						</td>--%>
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
        $("#table").dataTable({
			"aoColumns": [{ "bSortable":false,"sWidth": "120px"},{"sWidth": "360px"},null,null] ,
			"lengthChange": false,
          	"language": language(),
          	"bFilter": true,                       //不使用过滤功能   
          	paging: true,
          	iDisplayLength:10,
          	"bAutoWidth": true//自动宽度
        });
      });
      

      /**
	     * 删除确认
	     * @param id
	     */
	    function deleteConfirm(projectId,projectCode){
    	  $('#deleteConfirm').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
	        $("#deleteSure").on("click",function(){
	        	 $.ajax({
		    		    url:"${ctx}/hproject/delete",
		    		    type:"post",
		    		    data: "projectId="+projectId + "&projectCode="+projectCode,
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
