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
			<h1>日志管理</h1>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<div class="row">
					<div class="col-xs-12">
						<div class="space-6"></div>
						<div class="widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<form class="form-search" name="form"  method="get" id="log_form">
										<div class="row">
											<div class="col-xs-12  col-sm-12">
												<div class="input-group col-xs-12  col-sm-12">
													<label class="col-xs-12  col-sm-12 la">日志类型：</label>
													<select id="logType" class="select2style" style="width: 250px" name="logType" required oninvalid="setCustomValidity('请选择要查询的集群')" oninput="setCustomValidity('')" >
														<option value="1">操作日志</option>

														<c:choose>
															<c:when test="${logType == 2}">
																<option value="2" selected>回收站日志</option>
															</c:when>
															<c:otherwise>
																<option value="2">回收站日志</option>
															</c:otherwise>
														</c:choose>

													</select>
													&nbsp;
													<button class="btn btn-purple btn-sm" type="submit" id="submit">
														查询
														<i class="icon-search icon-on-right bigger-110"></i>
													</button>
												</div>
											</div>
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
								<h4 class="widget-title">日志列表</h4>
							</div>
							<div class="widget-body" id="sysLog_div">
								<table class="table table-striped table-bordered table-hover" id="sysLog_table">
								<thead>
								<tr>
									<th>编号</th>
									<th>操作类型</th>
									<th>操作描述</th>
									<th>创建人</th>
									<th>创建时间</th>
									<th>访问IP</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${page.result}" var="log">
									<tr>
										<td>${log.id}</td>
										<td>${log.logType}</td>
										<td>${log.description}</td>
										<td>${log.createUser}</td>
										<td>${log.createTime}</td>
										<td>${log.ip}</td>
									</tr>
								</c:forEach>
								</tbody>
								</table>

								<c:if test="${page!=null}">
									<div style="height:80px">
										<span class="pull-left" style="margin-left: 20px; vertical-align: middle;line-height: 80px;">第 ${page.index} 页 | 共 ${page.pages} 页</span>

										<ul class="pagination pull-right" style="margin-right: 15px" >
											<li><a href="${ctx}/hlog/initData?logType=${logType}">首页</a></li>
											<c:choose>
												<c:when test="${page.index > 1}">
													<li><a href="${ctx}/hlog/initData?logType=${logType}&index=${page.index-1}">上页</a></li>
												</c:when>
												<c:otherwise>
													<li class="disabled"><a href="#">上页</a></li>
												</c:otherwise>
											</c:choose>

											<c:if test="${page.index gt 9}">
												<li><a href="javascript:void(0)">..</a></li>
											</c:if>

											<c:if test="${page.pages gt 0 && page.index <= page.pages}">
												<c:forEach var="index" begin="${page.index}" end="${page.index + 5}" step="1" varStatus="status">
													<c:if test="${status.current <= page.pages}">
														<c:choose>
															<c:when test="${page.index == index}">
																<li class="active"><a href="${ctx}/hlog/initData?logType=${logType}&index=${index}">${index}</a></li>
															</c:when>
															<c:otherwise>
																<li><a href="${ctx}/hlog/initData?logType=${logType}&index=${index}">${index}</a></li>
															</c:otherwise>
														</c:choose>
													</c:if>
												</c:forEach>
											</c:if>

											<c:choose>
												<c:when test="${page.index < page.pages}">
													<li><a href="${ctx}/hlog/initData?logType=${logType}&index=${page.index + 1}">下页</a></li>
												</c:when>
												<c:otherwise>
													<li class="disabled"><a href="#">下页</a></li>
												</c:otherwise>
											</c:choose>

											<li><a href="${ctx}/hlog/initData?logType=${logType}&index=${page.pages}">尾页</a></li>
										</ul>
									</div>


								</c:if>


							</div>

							<div class="widget-body" id="trashLog_div" style="display: none">
								<table class="table table-striped table-bordered table-hover" id="trashLog_table" >
									<thead>
									<tr>
										<th>编号</th>
										<th>集群</th>
										<th>表名</th>
										<th>状态</th>
										<th>创建人</th>
										<th>创建时间</th>

									</tr>
									</thead>
									<tbody>
									<c:forEach items="${trashLogs}" var="trashLog">
										<tr>
											<td>${trashLog.id}</td>
											<td>${trashLog.colony.name}</td>
											<td>${trashLog.tableName}</td>
											<td>
												<c:choose>
													<c:when test="${trashLog.status==0}">
														<span class="label label-lg label-success arrowed-in">进入回收站</span>
													</c:when>
													<c:when test="${trashLog.status==1}">
														<span class="label label-lg label-inverse">彻底删除</span>
													</c:when>
													<c:when test="${trashLog.status==2}">
														<span class="label label-lg label-warning">已恢复</span>
													</c:when>
												</c:choose>



											</td>
											<td>${trashLog.createUser}</td>
											<td>${trashLog.createTime}</td>
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
		<script src="${ctx}/component/select2/select2.js"></script>
		<link rel="stylesheet" href="${ctx}/component/select2/select2.css" />


		<script>
			$(function () {

/*				$("#sysLog_table").dataTable({
					"order": [[ 0, "desc" ]], //第一列逆序显示
					"lengthChange": false,
					"language": language(),
					"bFilter": true,                       //不使用过滤功能
					paging: true,
					iDisplayLength:20,
					"bAutoWidth": true//自动宽度
				});*/

				$("#trashLog_table").dataTable({
					"order": [[ 0, "desc" ]],
					"lengthChange": false,
					"language": language(),
					"bFilter": true,                       //不使用过滤功能
					paging: true,
					iDisplayLength:20,
					"bAutoWidth": true//自动宽度
				});

				$("#logType").select2();

				$("#submit").on("click",function() {
					$("#log_form").attr("action","${ctx}/hlog/initData").submit();
				})


				showTable();
				function showTable() {
					var logType = $("#logType").val();
					var sysLog_div = $("#sysLog_div");
					var trashLog_div = $("#trashLog_div");

					if(logType==1) {
						sysLog_div.show();
						trashLog_div.hide();
					}else {
						sysLog_div.hide();
						trashLog_div.show();
					}
				}

			});



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
</t:base_layout>、

