<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<t:base_layout>
    <jsp:attribute name="title">
       HBase表管理
    </jsp:attribute>
  <jsp:body>
    <div class="page-header">
      <h1>HBase表管理</h1>
    </div>
    <div class="row">
      <div class="col-xs-12">
    		<div class="row">
    			<div class="col-xs-12">
			<div class="space-6"></div>
		</div>
      </div>

      <div class="row">
    			<div class="col-xs-12">
			<div class="space-6"></div>
			<div class="widget-box">
				<div class="widget-body">
					<div class="widget-main">
						<form class="form-inline" name="form" action="${ctx}/htable/initTables" method="post" id="form">

							<div class="form-group">
								<label class="col-xs-12  col-sm-12 la">集&nbsp;&nbsp;群：</label>
								<select id="colony" class="select2style" style="width: 250px" name="colony" required oninvalid="setCustomValidity('请选择要查询的集群')" oninput="setCustomValidity('')" >
									<c:forEach items="${colonys}" var="colo">
										<c:choose>
											<c:when test="${colony == colo.id}">
												<option value="${colo.id}" selected>${colo.name}</option>
											</c:when>
											<c:otherwise>
												<option value="${colo.id}">${colo.name}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</div>
							&nbsp;
							<div class="checkbox">
								<label>
									<input type="checkbox" id='onlyHBM' class="ace ace-checkbox-2" name="onlyHBM" value="true"/>
									<span class="lbl"> 仅显示平台</span>
								</label>
							</div>

							&nbsp;
							<div class="form-group">
								<button class="btn btn-purple btn-sm" type="submit" id="submit">
									查询
									<i class="icon-search icon-on-right bigger-110"></i>
								</button>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
      </div>

        <div class="row">
          <div class="col-xs-12 widget-container-col ui-sortable">
            <div class="widget-box widget-color-blue2 ui-sortable-handle">
              <div class="widget-header">
                <h4 class="widget-title">集群列表</h4>
              </div>
              <div class="widget-body">
                <table class="table table-striped table-bordered table-hover" id="table">
                  <thead>
                  <tr>
                   <tr>
					<th>表名</th>
					<th>别名</th>
					<th>所属项目</th>
					<th>列族</th>
					<th>是否分割</th>
					<th>是否MD5加密</th>
					<th>开始分隔符</th>
					<th>结束分隔符</th>
					<th>分割数量</th>
					<th>表状态</th>
					<th>是否灾备</th>
					<th>操作</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${datas}" var="data">
					<tr>
						<td>${data.value.tableName}</td>
						<td>${data.value.alias}</td>
						<td>${data.value.projectNames}</td>
						<td>${data.value.family}</td>
						<td>${data.value.isSplit}</td>
						<td>${data.value.isMd5}</td>
						<td>${data.value.startKey}</td>
						<td>${data.value.endKey}</td>
						<td>${data.value.splitNum}</td>
						<td>
						<c:if test="${not empty  data.value.state}">
							<c:choose>
								<c:when test="${data.value.state==1}">
									<span class="label label-lg label-inverse arrowed-in">未审核</span>
								</c:when>
								<c:when test="${data.value.state==0}">
									<span class="label label-lg label-success">已审核</span>
								</c:when>
								<c:when test="${data.value.state==3}">
									<span class="label label-lg label-warning">回收站</span>
								</c:when>
							</c:choose>
						</c:if>

						</td>
						<td>${data.value.isBackUp}</td>
						<td>
							<div class="btn-toolbar">
								<div class="btn-group">

									<c:if test="${fn:contains(data.value.funIds,1)}">
										<a class="btn btn-sm btn-primary" onclick="viewDescriptor('${data.value.tableName}','${data.value.colony}')" id="viewDescriptor">查看表结构</a>
									</c:if>
									<button data-toggle="dropdown" class="btn btn-sm btn-purple dropdown-toggle">
										其他操作
										<span class="ace-icon fa fa-caret-down icon-on-right"></span>
									</button>

									<ul class="dropdown-menu dropdown-default">

										<c:choose>
											<c:when test="${data.value.state==3}"><%--在回收站--%>
												<li>
													<c:if test="${fn:contains(data.value.funIds,2)}">
														<a onclick="renewFromTrashConfirm('${data.value.tableName}','${data.value.colony}','${data.value.id}','${data.value.state}')">恢复表</a>
													</c:if>
												</li>
												<li>
													<c:if test="${fn:contains(data.value.funIds,2)}">
														<a onclick="deleteConfirm('${data.value.tableName}','${data.value.colony}','${data.value.id}','${data.value.state}')">彻底删除</a>
													</c:if>
												</li>

											</c:when>
											<c:otherwise >
												<li>
													<c:if test="${fn:contains(data.value.funIds,2)}">
														<a onclick="deleteConfirm('${data.value.tableName}','${data.value.colony}','${data.value.id}','${data.value.state}','${onlyHBM}')">删除</a>
													</c:if>
												</li>
												<li>
													<c:if test="${fn:contains(data.value.funIds,3) && data.value.isAbled}">
														<a onclick="disableConfirm('${data.value.tableName}','${data.value.colony}')">禁用</a>
													</c:if>
												</li>
												<li>
													<c:if test="${fn:contains(data.value.funIds,4) && !data.value.isAbled}">
														<a onclick="enableConfirm('${data.value.tableName}','${data.value.colony}')">启用</a>
													</c:if>
												</li>
												<li>
													<c:if test="${fn:contains(data.value.funIds,7) && data.value.state!=0}">
														<a onclick="approvalTable('${data.value.tableName}','${data.value.colony}')">审核</a>
													</c:if>
												</li>
												<li>
													<c:if test="${fn:contains(authorities,'table_backup') && !data.value.isBackUp && colonyObj.character==1}">
														<a onclick="backUpTable('${data.value.tableName}','${data.value.colony}')">灾备</a>
													</c:if>
												</li>
												<li>
													<c:if test="${fn:contains(authorities,'table_clear')}">
														<a onclick="clearData('${data.value.tableName}','${data.value.colony}')">清除表数据</a>
													</c:if>
												</li>
												<li>
													<a onclick="rowCount('${data.value.tableName}','${data.value.colony}')">行健统计</a>
												</li>
												<li>
													<a onclick="updateTableDesc('${data.value.tableName}','${data.value.colony}')">修改表结构</a>
												</li>
											</c:otherwise>

										</c:choose>
									</ul>
								</div>
							</div>

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
            	确认删除该表吗！
          </div>
          <div class="modal-footer">
          	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-danger" id="deleteSure">确定</button>
          </div>
        </div>
      </div>
    </div>

     <!-- 启用确认 -->
    <div class="modal fade" id="enableConfirm" data-backdrop="static" tabindex="-1" >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
          	<h4 class="modal-title">确认</h4>
          </div>
          <div class="modal-body">
            	确认启用该表吗！
          </div>
          <div class="modal-footer">
          	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-danger" id="enableSure">确定</button>
          </div>
        </div>
      </div>
    </div>

     <!-- 禁用确认 -->
    <div class="modal fade" id="disableConfirm" data-backdrop="static" tabindex="-1" >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
          	<h4 class="modal-title">确认</h4>
          </div>
          <div class="modal-body">
            	确认禁用该表吗！
          </div>
          <div class="modal-footer">
          	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-danger" id="disableSure">确定</button>
          </div>
        </div>
      </div>
    </div>

     <!-- 表结构查看 -->
    <div class="modal fade" id="view" data-backdrop="static" tabindex="-1" >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
          	<h4 class="modal-title">表结构查看</h4>
          </div>
          <div class="modal-body">
            	表结构文件为空！
          </div>
          <div class="modal-footer">
          	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-danger"  data-dismiss="modal">确定</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 审核确认 -->
    <div class="modal fade" id="approvalTable" data-backdrop="static" tabindex="-1" >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
          	<h4 class="modal-title">确认</h4>
          </div>
          <div class="modal-body">
            	确认审核该表吗！
          </div>
          <div class="modal-footer">
          	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-danger" id="approvalSure">确定</button>
          </div>
        </div>
      </div>
    </div>

	  <!-- 表灾备 -->
	  <div class="modal fade" id="backUpTable" data-backdrop="static" tabindex="-1" >
		  <div class="modal-dialog">
			  <div class="modal-content">
				  <div class="modal-header">
					  <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
					  <h4 class="modal-title">灾备</h4>
				  </div>
				  <div class="modal-body">
					  确认备份该表吗！
				  </div>
				  <div class="modal-footer">
					  <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					  <button type="button" class="btn btn-danger" id="backUpSure">确定</button>
				  </div>
			  </div>
		  </div>
	  </div>

	  <div class="modal fade" id="clearData" data-backdrop="static" tabindex="-1" >
		  <div class="modal-dialog">
			  <div class="modal-content">
				  <div class="modal-header">
					  <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
					  <h4 class="modal-title">清除表数据</h4>
				  </div>
				  <div class="modal-body">
					  确认清除该表数据吗！
				  </div>
				  <div class="modal-footer">
					  <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					  <button type="button" class="btn btn-danger" id="clearDataSure">确定</button>
				  </div>
			  </div>
		  </div>
	  </div>

	  <%--表恢复--%>
	  <div class="modal fade" id="renewFromTrashConfirm" data-backdrop="static" tabindex="-1" >
		  <div class="modal-dialog">
			  <div class="modal-content">
				  <div class="modal-header">
					  <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
					  <h4 class="modal-title">恢复表</h4>
				  </div>
				  <div class="modal-body">
					  确认恢复该表吗?
				  </div>
				  <div class="modal-footer">
					  <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					  <button type="button" class="btn btn-danger" id="renewFromTrashSure">确定</button>
				  </div>
			  </div>
		  </div>
	  </div>

	  <!--修改表结构文档-->
	  <div class="modal fade" id="updateTableDesc" data-backdrop="static" tabindex="-1" >
		  <div class="modal-dialog" style="width: 768px">
			  <div class="modal-content">
				  <div class="modal-header">
					  <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
					  <h4 class="modal-title">修改表描述文档</h4>
				  </div>


					  <div class="modal-body">
						  <form class="form-horizontal" id="desc_form" method="post"  enctype="multipart/form-data">
							  <input type="text" id="tableName" name="tableName"  hidden >
							  <input type="text" id="colonyId" name="colonyId"  hidden >
							  <div class="form-group" id="div9">
								  <label class="col-sm-4 control-label no-padding-right" > 选择表结构描述文件 </label>
								  <div class="ace-file-input col-sm-7" name="fileinput" id="fileinput" required>
									  <input type="file" id="inputfile" name="file" required/>
									  <small id="small1" style="display:none" class="help-block"  data-bv-result="INVALID">&nbsp;&nbsp;只能上传word类型文件！</small>
									  <small id="small2" style="display:none" class="help-block"  data-bv-result="INVALID">&nbsp;&nbsp;表描述文件不能为空！</small>
								  </div>
								  <div class="space-4"></div>
							  </div>
						  </form>
					  </div>
					  <br>
					  <div class="modal-footer">
						  <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						  <button type="button" class="btn btn-danger" id="updateTableDescSure">确定</button>
					  </div>

			  </div>
		  </div>
	  </div>

	  <%--行健统计--%>
	  <div class="modal fade" id="rowCount" data-backdrop="static" tabindex="-1" >
		  <div class="modal-dialog" style="width: 768px">
			  <div class="modal-content">
				  <div class="modal-header">
					  <button type="button" class="close" data-dismiss="modal" ><span>&times;</span></button>
					  <h4 class="modal-title">行健统计</h4>
				  </div>
				  <div class="modal-body">
					  <form class="form-horizontal" id="rowCount_form" method="post">

						  <div class="form-group">
							  <label class="col-sm-4 control-label no-padding-right"> 表名 </label>
							  <div class="col-sm-7">
								  <input type="text" class="col-xs-7" name="tableName"  readonly maxlength="50"/>
							  </div>
							  <div class="space-4"></div>
						  </div>
						  <div class="form-group">
							  <label class="col-sm-4 control-label no-padding-right"> 列族 </label>
							  <div class="col-sm-7">
								  <input type="text" placeholder="f" class="col-xs-7" name="family"  maxlength="50"/>
							  </div>
							  <div class="space-4"></div>
						  </div>

						  <div class="form-group">
							  <div class="space-4"></div>
							  <label class="col-sm-4 control-label no-padding-right"> 开始行健 </label>
							  <div class="col-sm-7">
								  <input type="text" placeholder="" class="col-xs-7" name="startRowKey" maxlength="100"/>
								  <span class="help-button" data-rel="popover" data-trigger="hover" data-placement="right"
										data-content="不输入行健，即可统计整个行健数" title="行健统计">?</span>
							  </div>
							  <div class="space-4"></div>
						  </div>

						  <div class="form-group">
							  <div class="space-4"></div>
							  <label class="col-sm-4 control-label no-padding-right"> 结束行健 </label>
							  <div class="col-sm-7">
								  <input type="text" placeholder="" class="col-xs-7" name="endRowKey" maxlength="100"/>
							  </div>
							  <div class="space-4"></div>
						  </div>

						  <div class="form-group" id="rowNumDiv" style="display: none">
							  <div class="space-4"></div>
							  <label class="col-sm-4 control-label no-padding-right"> 行健计数 </label>
							  <div class="col-sm-7">
								  <input type="text" placeholder="" class="col-xs-7" name="rowNum" readonly  style="color: red"/>
							  </div>
							  <div class="space-4"></div>
						  </div>
					  </form>
				  </div>
				  <br>
				  <div class="modal-footer">
					  <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					  <button type="button" class="btn btn-danger" id="rowCountSure">行健统计</button>
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
    <script src="${ctx}/component/select2/select2.js"></script>
    <link rel="stylesheet" href="${ctx}/component/select2/select2.css" />

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

		  //回显checkbox的值
		  var showChecked = function (){
			  if("${onlyHBM}"){
				  $("#onlyHBM").prop('checked',true);
			  }
		  }();
      });


	  $("#colony").select2();

	  /*提示格式化*/
	  $('[data-rel=tooltip]').tooltip({container:'body'});
	  $('[data-rel=popover]').popover({container:'body'});

	  $('#inputfile').ace_file_input({
		  no_file:'未选择上传文件 ...',
		  btn_choose:'选择上传文件',
		  btn_change:'Change',
		  droppable:false,
		  onchange:null,
		  thumbnail:false ,//| true | large
		  whitelist:'doc|docx',
		  blacklist:'exe|php'
		  //onchange:''
		  //
	  }).on('change', function () {
		  var inputFile = $('#inputfile').val().toLowerCase();
		  $('#small2').hide();
		  if(inputFile.match(/.doc$/) != '.doc' && inputFile.match(/.docx$/) != '.docx') {//java
			  $('#small1').show();//显示提示消息
			  //显示错误图标
			  $('#fileinput').find("i").removeClass('glyphicon-ok');
			  $('#fileinput').find("i").addClass('glyphicon-remove');
			  //设置错误字体
			  $("#div9").addClass("has-error");
			  //设置表单为不可提交状态
			  $("#updateTableDescSure").attr('disabled','disabled');
		  } else {
			  $("#div9").removeClass("has-error");
			  $("#div9").addClass("has-success");
			  $("#fileinput > .form-control-feedback").show();
			  $("#fileinput > .form-control-feedback").removeClass("glyphicon-remove");
			  $("#fileinput > .form-control-feedback").addClass("glyphicon glyphicon-ok");
			  $("#updateTableDescSure").removeAttr("disabled");
			  $('#small1').hide();//
		  }

	  });
	  $($("#fileinput").find("label")[0]).addClass("col-xs-7");


      /**
	     * 删除确认
	     * @param id
	     */
	    function deleteConfirm(tableName, colony, id, status, onlyHBM){
	      $('#deleteConfirm').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
	        $("#deleteSure").on("click",function(){
	        	 $.ajax({
		    		    url:"${ctx}/htable/delete",
		    		    type:"post",
		    		    data: "tableName="+tableName+"&colony="+colony+"&id="+id+"&status="+status+"&onlyHBM="+ onlyHBM,
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

	  /**
	   * 从垃圾桶恢复
	   * @param id
	   */
	  function renewFromTrashConfirm(tableName, colony, id, status){
		  $('#renewFromTrashConfirm').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
			  $("#renewFromTrashSure").on("click",function(){
				  $.ajax({
					  url:"${ctx}/htable/renewFromTrash",
					  type:"post",
					  data: "tableName="+tableName+"&colony="+colony+"&id="+id+"&status="+status,
					  beforeSend:function(){
						  //这里是开始执行方法，显示效果，效果自己写
						  $('#renewFromTrashConfirm').modal('hide');
						  $('#waiting').modal('show');
					  },
					  complete:function(){
						  //方法执行完毕，效果自己可以关闭，或者隐藏效果
						  $('#waiting').modal('hide');
					  },
					  success:function(data){
						  //数据加载成功
						  if("0" == data.isSuccess){
							  $.scojs_message('恢复成功！', $.scojs_message.TYPE_OK);
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
	     * 启用确认
	     * @param id
	     */
	    function enableConfirm(tableName, colony){
	      $('#enableConfirm').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
	        $("#enableSure").on("click",function(){
	        	 $.ajax({
		    		    url:"${ctx}/htable/enable",
		    		    type:"post",
		    		    data: "tableName="+tableName+"&colony="+colony,
		    		    beforeSend:function(){
		    		        //这里是开始执行方法，显示效果，效果自己写
		    		        $('#enableConfirm').modal('hide');
		    		    	$('#waiting').modal('show');
		    		    },
		    		    complete:function(){
		    		        //方法执行完毕，效果自己可以关闭，或者隐藏效果
		    		        $('#waiting').modal('hide');
		    		    },
		    		    success:function(data){
		    		        //数据加载成功
		                    if("0" == data.isSuccess){
		                      $.scojs_message('启用成功！', $.scojs_message.TYPE_OK);
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
   	     * 查看表结构
   	     * @param id
   	     */
   	    function viewDescriptor(tableName, colony){
   	    	$.post("${ctx}/htable/isEmpty",
   	             {
   	    			tableName:tableName,
   	    			colony:colony
   	             },
   	             function(data,status){
   	               if("1" == data.isSuccess){
   	            	   $('#view').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
   	   	    			});
   	               }else{
   	            		location.href = "${ctx}/htable/downDescriptor?tableName="+tableName+"&colony="+colony;
   	               }
   	             });

   	    }
	    /**
	     * 停用确认
	     * @param id
	     */
	    function disableConfirm(tableName, colony){
	      $('#disableConfirm').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
	        $("#disableSure").on("click",function(){
	        	 $.ajax({
		    		    url:"${ctx}/htable/disable",
		    		    type:"post",
		    		    data:{"tableName":tableName,
		    		    	colony:colony},
		    		    beforeSend:function(){
		    		        //这里是开始执行方法，显示效果，效果自己写
		    		        $('#disableConfirm').modal('hide');
		    		    	$('#waiting').modal('show');
		    		    },
		    		    complete:function(){
		    		        //方法执行完毕，效果自己可以关闭，或者隐藏效果
		    		        $('#waiting').modal('hide');
		    		    },
		    		    success:function(data){
		    		        //数据加载成功
		                    if("0" == data.isSuccess){
		                      $.scojs_message('禁用成功！', $.scojs_message.TYPE_OK);
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
	     * 审核
	     * @param id
	     */
	    function approvalTable(tableName, colony){
	      $('#approvalTable').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
	        $("#approvalSure").on("click",function(){
	        	 $.ajax({
		    		    url:"${ctx}/htable/approval",
		    		    type:"post",
		    		    data:{"tableName":tableName,
		    		    	colony:colony},
		    		    beforeSend:function(){
		    		        //这里是开始执行方法，显示效果，效果自己写
		    		        $('#approvalTable').modal('hide');
		    		    	$('#waiting').modal('show');
		    		    },
		    		    complete:function(){
		    		        //方法执行完毕，效果自己可以关闭，或者隐藏效果
		    		        $('#waiting').modal('hide');
		    		    },
		    		    success:function(data){
		    		        //数据加载成功
		                    if("0" == data.isSuccess){
		                      $.scojs_message('审核成功！', $.scojs_message.TYPE_OK);
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
		 * 灾备
		 **/
	  function backUpTable(tableName, colony){
		  $('#backUpTable').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
			  $("#backUpSure").on("click",function(){
				  $.ajax({
					  url:"${ctx}/htable/backUpTable",
					  type:"post",
					  data:{"tableName":tableName,
						  colony:colony},
					  beforeSend:function(){
						  //这里是开始执行方法，显示效果，效果自己写
						  $('#backUpTable').modal('hide');
						  $('#waiting').modal('show');
					  },
					  complete:function(){
						  //方法执行完毕，效果自己可以关闭，或者隐藏效果
						  $('#waiting').modal('hide');
					  },
					  success:function(data){
						  //数据加载成功
						  if("0" == data.isSuccess){
							  $.scojs_message('灾备成功！', $.scojs_message.TYPE_OK);
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
		 *清除表数据
		 **/
	  function clearData(tableName, colony){
		  $('#clearData').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
			  $("#clearDataSure").on("click",function(){
				  $.ajax({
					  url:"${ctx}/htable/clearTableData",
					  type:"post",
					  data:{"tableName":tableName,
						  colony:colony},
					  beforeSend:function(){
						  //这里是开始执行方法，显示效果，效果自己写
						  $('#clearData').modal('hide');
						  $('#waiting').modal('show');
					  },
					  complete:function(){
						  //方法执行完毕，效果自己可以关闭，或者隐藏效果
						  $('#waiting').modal('hide');
					  },
					  success:function(data){
						  //数据加载成功
						  if("0" == data.isSuccess){
							  $.scojs_message('清除表数据成功！', $.scojs_message.TYPE_OK);
						  }else{
							  $.scojs_message(data.error, $.scojs_message.TYPE_ERROR);
						  }
					  },
					  error:function(){
						  //数据加载失败
					  }
				  });
			  });
		  });
	  }

		/**
		 * 行健统计
		 * */
	  function rowCount(tableName, colony){

		  //页面显示数据
		  var rw_tableName = $("#rowCount_form").find("input[name='tableName']");
		  rw_tableName.val(tableName);
		  var rowNumDiv = $("#rowNumDiv");
		  rowNumDiv.hide();
		  $('#rowCount').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作
			  $("#rowCountSure").unbind("click").bind("click",function(){
				  //获取数据
				  var family = $("input[name='family']").val();
				  var startRowKey = $("input[name='startRowKey']").val();
				  var endRowKey = $("input[name='endRowKey']").val();
				  var rowNum = $("input[name='rowNum']");
				  $.ajax({
					  url:"${ctx}/htable/rowCount",
					  type:"post",
					  data:{"tableName":tableName,colonyId:colony, family:family, startRowKey:startRowKey, endRowKey:endRowKey},
					  beforeSend:function(){
						  //这里是开始执行方法，显示效果，效果自己写
						  $('#waiting').modal('show');
					  },
					  complete:function(){
						  //方法执行完毕，效果自己可以关闭，或者隐藏效果
						  $('#waiting').modal('hide');
					  },
					  success:function(data){
						  rowNum.val(data);
						  rowNumDiv.show();
					  },
					  error:function(){
						  //数据加载失败
					  }
				  });
			  });
		  });
	  }

	  /**
	  *
	   * @param tableName
	   * @param colony
	   */
	  function updateTableDesc(tableName, colony){
		  $('#updateTableDesc').modal('show').on('shown.bs.modal',function(){//绑定监听事件，当模态框显示后，执行相应的动作

			  $("#tableName").val(tableName);
			  $("#colonyId").val(colony);
			  $("#updateTableDescSure").on("click",function(){
				  var inputfile = $('#inputfile').val();
				  if(!inputfile){
					  $('#small2').show();//显示提示消息
					  //显示错误图标
					  $('#fileinput').find("i").removeClass('glyphicon-ok');
					  $('#fileinput').find("i").addClass('glyphicon-remove');
					  //设置错误字体
					  $("#div9").addClass("has-error");
					  //设置表单为不可提交状态
					  $("#updateTableDescSure").attr('disabled','disabled');
					  return;
				  }
				  $("#updateTableDescSure").attr('disabled','disabled');//修改按钮状态
				  $("#desc_form").attr("action","${ctx}/htable/updateTableDesc").submit();
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
