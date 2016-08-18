<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<t:base_layout>
    <jsp:attribute name="title">
       HBase综合查询
    </jsp:attribute>
  <jsp:body>
    <div class="page-header">
      <h1>HBase综合查询</h1>
    </div>
    <div class="row">
      <div class="col-xs-12">
    		<div class="row">
    			<div class="col-xs-12">
			<div class="space-6"></div>
			<div class="widget-box">
				<div class="widget-body">
					<div class="widget-main">
						<form class="form-inline" name="form" action="${ctx}/hsearch/initSearch" method="post" id="form">
							<div class="form-group">
								<label>集群：</label>
								<select id="colony" class="select2style" name="colony" required oninvalid="setCustomValidity('请选择要查询的集群')" oninput="setCustomValidity('')" >
									<c:forEach items="${colonys}" var="colo">
										<c:choose>
											<c:when test="${searchModel.colony == colo.id}">
												<option value="${colo.id}" selected>${colo.name}</option>
											</c:when>
											<c:otherwise>
												<option value="${colo.id}">${colo.name}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</div>

							<div class="form-group">
								<label>表名：</label>
								<select id="tableName"  name="tableName" class="select2style">
									<c:forEach items="${tables}" var="table">
										<c:choose>
											<c:when test="${table.tableName == searchModel.tableName}">
												<option value="${table.tableName}" selected>${table.tableName}</option>
											</c:when>
											<c:otherwise>
												<option value="${table.tableName}">${table.tableName}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label>行健：</label>
								<input type="text" class="form-control" name="startRowKey" value="${searchModel.startRowKey}" placeholder="开始行健">
							</div>
							-
							<div class="form-group">
								<input type="text" class="form-control" name="endRowKey" value="${searchModel.endRowKey}" placeholder="结束行健">
							</div>
							<br/><br/>
							<div class="form-group">
								<label> 列名：</label>
								<input type="text" class="form-control" name="column" value="${searchModel.column}" placeholder="列名">
							</div>
							<div class="form-group">
								<label> 值：</label>
								<input type="text" class="form-control" name="value" value="${searchModel.value}" placeholder="值">
							</div>
							&nbsp;&nbsp;&nbsp;
							<div class="checkbox">
								<label>
									<c:choose>
										<c:when test="${searchModel.encryptRow}">
											<input type="checkbox" id='encryptRow' class="ace ace-checkbox-2" name="encryptRow" checked/>
										</c:when>
										<c:otherwise>
											<input type="checkbox" id='encryptRow' class="ace ace-checkbox-2" name="encryptRow"/>
										</c:otherwise>
									</c:choose>
									<span class="lbl"> 行健加密</span>
								</label>
							</div>
							&nbsp;
							<div class="checkbox">
								<label>
									<c:choose>
										<c:when test="${searchModel.showVersion}">
											<input type="checkbox" id='showVersion' class="ace ace-checkbox-2" name="showVersion" checked/>
										</c:when>
										<c:otherwise>
											<input type="checkbox" id='showVersion' class="ace ace-checkbox-2" name="showVersion"/>
										</c:otherwise>
									</c:choose>
									<span class="lbl">显示版本数据</span>
								</label>
							</div>
							&nbsp;&nbsp;&nbsp;
							<input hidden id="action" name="action" />
							<div class="form-group">
								<button class="btn btn-purple btn-sm" data-action="search" id="search">
									查询
									<i class="icon-search icon-on-right bigger-110"></i>
								</button>

								<c:if test="${fn:contains(authorities,'data_downLoad')}">
									<button class="btn btn-primary btn-sm" data-action="downLoad" id="downLoad">
										下载
										<i class="icon-search icon-on-right bigger-110"></i>
									</button>
								</c:if>
							</div>
						</form>
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
					<th>行健</th>
					<th>列族</th>
					<th>列名</th>
					<th>值</th>
					<th>更新时间</th>
					<th>操作</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${datas}" var="data">
					<tr>
						<td>${data.rowKey}</td>
						<td>${data.family}</td>
						<td>${data.qualifier}</td>
						<td>${data.value}</td>
						<td>
						<fmt:formatDate value="${data.createTime}" type="both" pattern ="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td>
							<a href="javascript" data-toggle="modal"  onclick="deleteConfirm('${data.family}', '${data.rowKey}', '${data.qualifier}','${data.value}')" class="btn btn-danger btn-sm">删除</a>
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
					  确认删除该条数据吗！
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
    
    <script src="${ctx}/component/ace/assets/js/chosen.jquery.min.js"></script>
     <link href="${ctx}/component/ace/assets/css/chosen.css" rel="stylesheet">

	  <script src="${ctx}/component/select2/select2.js"></script>
	  <link rel="stylesheet" href="${ctx}/component/select2/select2.css" />
 
    <script>
      $(function () {
   	  	$(".chosen-select").chosen();
        $("#table").dataTable({
        	"lengthChange": false,
          	"language": language(),
          	"bFilter": false,                       //不使用过滤功能   
          	paging: true,
//          	iDisplayLength:10,
          	"bAutoWidth": true,
          	"bProcessing": true,
			"bLengthChange": true, //改变每页显示数据数量
			"lengthMenu": [[10, 50, -1], [10, 50, "All"]]
          		
        });



		  $("#search,#downLoad").click(function () {
			  $("#action").val($(this).data("action"));
		  });
      });

	  $("#colony,#tableName").select2({
		  width:"220px"

	  });

	  /**
	   * 删除确认
	   * @param id
	   */
	  function deleteConfirm(family, rowKey, qualifier, value){

		  var colony = $("#colony").val();
		  var tableName = $("#tableName").val();

		  $('#deleteConfirm').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
			  $("#deleteSure").on("click",function(){
				  $.ajax({
					  url:"${ctx}/htable/deleteData",
					  type:"post",
					  data: "tableName="+tableName+"&family="+family+"&rowKey="+rowKey+"&qualifier="+qualifier+"&value="+value+"&colony="+colony ,
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
		//查询参数验证
		$("#submit").on("click",function(data){
			var startRowKey = $("input[name='startRowKey']").val();//行健
			var endRowKey = $("input[name='endRowKey']").val();//行健
			var tableName = $("select[name='tableName']").val();//表名
			if(tableName) {
				$("select[name='tableName']").removeAttr("required");
			} else {
				$("select[name='tableName']").attr("required","required");
			}
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
   		
	});

    </script>
    <style  type="text/css">
		.chosen-container-single .chosen-single {
			height: 31px;
		}
		.la {
			width:100px;
			line-height:31px;
		}
			
    </style>
  </jsp:body>
</t:base_layout>
