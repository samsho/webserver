<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    			<div class="col-xs-12">
			<div class="space-6"></div>
		</div>
      </div>
        <div class="row">
          <div class="col-xs-12 widget-container-col ui-sortable">
            <div class="widget-box widget-color-blue2 ui-sortable-handle">
              <div class="widget-header">
                <h4 class="widget-title">项目列表</h4>
                
               	<div class="widget-toolbar">
                  <a href="${ctx}/hproject/add" class="btn btn-primary btn-xs" title="新增项目" data-toggle="tooltip">
                    <i class="ace-icon fa bigger-125 fa-plus"></i>
                  </a>
                </div>
              </div>
              <div class="widget-body">
                <table class="table table-striped table-bordered table-hover" id="table">
                  <thead>
                  <tr>
                   <tr>
					<th>项目编号</th>
					<th>项目代码</th>
					<th>项目名称</th>
					<th>主负责人</th>
					<th>从负责人</th>
					<th>操作</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${projects}" var="project">
					<tr>
						<td>${project.id}</td>
						<td>${project.projectCode}</td>
						<td>${project.projectName}</td>
						<td>${project.mainPresiderName}</td>
						<td>${project.deputyPresiderName}</td>
						<td>
							<c:if test="${fn:contains(authorities,'project_delete')}">  
    							<a href="javascript" data-toggle="modal"  onclick="deleteConfirm('${project.id}','${project.projectCode}')" class="btn btn-danger btn-sm">删除</a>  
							</c:if> 
							<a href="${ctx}/hproject/update?projectId=${project.id}" data-toggle="modal"  class="btn btn-primary btn-sm">修改</a>
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
            	删除项目，会级联删除其对应的Token，确认删除该项目吗！
          </div>
          <div class="modal-footer">
          	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-danger" id="deleteSure">确定</button>
          </div>
        </div>
      </div>
    </div>
    
    
     <div class="modal fade" id="showTableConfirm" data-backdrop="static" tabindex="-1" >
      <div class="modal-dialog" style="width: 1000px">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
          	<h4 class="modal-title">表数据</h4>
          </div>
          <div class="modal-body">
				<table class="table table-striped table-bordered table-hover" id="colonyTable">
                  <thead>
                   <tr>
					<th>表名</th>
					<th>别名</th>
					<th>列族</th>
					<th>是否分割</th>
					<th>是否MD5加密</th>
					<th>开始分隔符</th>
					<th>结束分隔符</th>
					<th>分割数量</th>
                  </tr>
                  </thead>
                  <tbody>
                  </tbody>
                </table>


          </div>
          <div class="modal-footer">
          	<!-- <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
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
    	  
    	 //api方法，即可使用table对象封装好的 api方法 (DataTables jQuery constructor)
    	 // 或者 var table = new $.fn.dataTable.Api('#table'); 
    	  var table = $("#table").dataTable({
        	"lengthChange": false,
          	"language": language(),
          	"bFilter": true,                       //不使用过滤功能   
          	paging: true,
          	iDisplayLength:10,
          	"bAutoWidth": true//自动宽度
          }).api(); 
    	  
    	   $('#table tbody tr').on('click', 'td:lt(5)', function() {//点击前5列有效  
    		 var tr = $(this).closest('tr');
    	     var project = table.row(tr).data();//获取projectId

    	     $("#colonyTable tbody").remove();//清除表格的数据  
    	     $("#colonyTable").append('<tbody>');
    	     
    	     $("#showTableConfirm .modal-title").text(project[1] +" 项目表数据");
    		
    		  $.ajax({
		    		    url:"${ctx}/hproject/getTablesByProjectId",
		    		    type:"get",
		    		    data: "projectId="+project[0],  
		    		    beforeSend:function(){
		    		    },
		    		    complete:function(){
		    		    },
		    		    success:function(data){
		    		    	var tables = $.parseJSON(data);   

		    		    	if(!$.isEmptyObject(tables)){
								$.each(tables,function(index,table){
									$("#colonyTable tbody").append($('<tr>').append($('<td>').text(table.tableName))
																.append($('<td>').text(table.alias))
																.append($('<td>').text(table.family))
																.append($('<td>').text(table.isSplit))
																.append($('<td>').text(table.isMd5))
																.append($('<td>').text(table.startKey))
																.append($('<td>').text(table.endKey))
																.append($('<td>').text(table.splitNum))
									)
								})
		    		    	}			
			
							$("#colonyTable").dataTable({
								"lengthChange": false,
					          	"language": language(),
					          	"bFilter": true,                       //不使用过滤功能   
					          	paging: true,
					          	iDisplayLength:10,
					          	destroy:true,//防止多次初始化 ，参考http://datatables.net/manual/tech-notes/3 
					          	"bAutoWidth": true//自动宽度
					    	}); 

							$("#showTableConfirm").modal();

		    		    },
		    		    error:function(){
		    		   }
		    		});
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
      
      
  	  
		<c:if test="${not empty error}">
   			$.scojs_message("${error}", $.scojs_message.TYPE_ERROR);
   		</c:if>
   		<c:if test="${not empty success}">
				$.scojs_message("${success}", $.scojs_message.TYPE_OK);
		</c:if>
	
    </script>
    <style type="text/css">
		.la {
			width:100px;
			line-height:31px;
		}
	</style>
  </jsp:body>
</t:base_layout>
