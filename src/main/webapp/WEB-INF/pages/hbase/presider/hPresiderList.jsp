<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<t:base_layout>
    <jsp:attribute name="title">
       HBase项目人员管理
    </jsp:attribute>
  <jsp:body>
    <div class="page-header">
      <h1>HBase项目人员管理</h1>
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
                <h4 class="widget-title">项目人员列表</h4>
                
                <div class="widget-toolbar">
                  <a href="${ctx}/hpresider/synchronize" class="btn btn-primary btn-xs" title="同步项目人员" data-toggle="tooltip">
                    <i class="ace-icon fa bigger-125 fa-refresh"></i>
                  </a>
<%--					<a href="${ctx}/hpresider/save" class="btn btn-primary btn-xs" title="添加项目人员" data-toggle="tooltip">
						<i class="ace-icon fa bigger-125 fa-plus"></i>
					</a>--%>
                </div>
                
              </div>
              <div class="widget-body">
                <table class="table table-striped table-bordered table-hover" id="table">
                  <thead>
                  <tr>
                   <tr>
					<th>人员名称</th>
					<th>人员工号</th>
					<th>统一权限编号</th>
					<th>邮箱</th>
				    <th>所属部门</th>
					<th>系统角色</th>
					<th>操作</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${presiders}" var="presider">
					<tr>
						<td>${presider.name}</td>
						<td>${presider.jobNumber}</td>
						<td>${presider.authorityId}</td>
						<td>${presider.email}</td>
						<td>${presider.deptName}</td>
						<td>${presider.role}</td>
						<td>
							<c:if test="${fn:contains(authorities,'presider_delete')}">
								<a href="javascript" data-toggle="modal" onclick="deleteConfirm('${presider.id}')" class="btn btn-danger btn-sm">删除</a>
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
    
    
     <!-- 删除确认 -->
    <div class="modal fade" id="deleteConfirm" data-backdrop="static" tabindex="-1" >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
          	<h4 class="modal-title">确认</h4>
          </div>
          <div class="modal-body">
            	确认删除该人员吗！
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
        $("#table").dataTable({
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
	    function deleteConfirm(presiderId){
    	  $('#deleteConfirm').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
	        $("#deleteSure").on("click",function(){
	        	 $.ajax({
		    		    url:"${ctx}/hpresider/delete",
		    		    type:"post",
		    		    data: "presiderId="+presiderId,  
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
