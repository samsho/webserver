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
	      <h1>数据权限操作</h1>
	    </div>
	    <div class="row">
	      <div class="col-xs-12">
	      	<div class="row">
    			<div class="col-xs-12">
					<div class="space-6"></div>
					<div class="widget-box">
						<div class="widget-body">
							<div class="widget-main">
								<form class="form-inline" name="form" action="${ctx}/privileges/initData" id="form" method="POST">
									<div class="form-group">
										<label>用&nbsp;&nbsp;户：</label>
										<select id="user" class="select2style" name="user" required oninvalid="setCustomValidity('请选择用户')" oninput="setCustomValidity('')">
											<c:forEach items="${users}" var="user">
												<c:choose>
													<c:when test="${us == user.id}">
														<option value="${user.id}" selected>${user.name}</option>
													</c:when>
													<c:otherwise>
														<option value="${user.id}">${user.name}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>

									<div class="form-group">
										<label>集&nbsp;&nbsp;群：</label>
										<select id="colony" class="select2style" name="colony" required oninvalid="setCustomValidity('请选择集群')" oninput="setCustomValidity('')">
											<c:forEach items="${colonys}" var="colony">
												<c:choose>
													<c:when test="${col == colony.id}">
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
						<th>表名</th>
						<th>操作</th>
	                  </tr>
	                  </thead>
	                  <tbody>
	                  <c:forEach items="${priModels}" var="table">
						<tr>
							<td>${table.tableName}</td>
							<td>
								<div class="control-group">
									<c:forEach items="${functions}" var="fun">
										<label>
											<c:choose>
						                    <c:when test="${fn:contains(table.checkedIds,fun.id)}">
						                    <input type="checkbox" class="ace ace-checkbox-2" name="form-field-checkbox" value="${fun.id}" checked />
						                    </c:when>
						                    <c:otherwise>
						                    <input type="checkbox" class="ace ace-checkbox-2" name="form-field-checkbox" value="${fun.id}"  />
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
	                </table>
	              </div>
	            </div>
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
				$("#colony,#user").select2({
					width:"220px"
				});

			 	$("#table").DataTable({
		        	"lengthChange": false,
		          	"bFilter": true,                       //不使用过滤功能   
		          	paging: true,
		          	iDisplayLength:10,
		          	"bAutoWidth": true,//自动宽度
		          	 "language": language()
		        });

			 	$("body").delegate('#table input', 'click', function () { 
			 		var user = $("select[name='user']").val();//用户
				 	var colony = $("select[name='colony']").val();//集群
			 		var tableName=$(this).parent().parent().parent().prev().text();//表名
			 		var privi = $(this).val();//操作：添加、删除...
			 		var isAddPrivi = $(this).is(':checked');//是否选中
			 		 $.ajax({
	                        url: "${ctx}/privileges/authorize",
	                        type: "POST",
	                        data: "user="+user+"&colony="+colony+"&tableName="+tableName+"&isAddPrivi="+isAddPrivi+"&privi="+privi
	                    });
			 	});
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
