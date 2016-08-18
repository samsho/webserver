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
	      <h1>Token表分配操作</h1>
	    </div>
	    <div class="row">
	      <div class="col-xs-12">
	      	<div class="row">
    			<div class="col-xs-12">
					<div class="space-6"></div>
					<div class="widget-box">
						<div class="widget-body">
							<div class="widget-main">
								<form class="form-search" name="form" action="${ctx}/htoken/initData" id="form" method="POST">
									<div class="row">
										<div class="col-xs-12  col-sm-12">
											<div class="input-group col-xs-12  col-sm-12">
												<label class="col-xs-12  col-sm-12 la">Token：</label>
												<input type="text" placeholder="" class="col-xs-3" name="token" value="${token}" readonly="readonly" />

												<label class="col-xs-8  col-sm-8 la">集&nbsp;&nbsp;群：</label>
												<select id="colonyId" class="col-xs-2" name="colonyId" required oninvalid="setCustomValidity('请选择集群')" oninput="setCustomValidity('')">
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

												<button class="btn btn-purple btn-sm" id="distrbuteBtn" type="submit">
												分配
												<i class="icon-search icon-on-right bigger-110"></i>
												</button>&nbsp;
											</div>
										</div>
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
							  <h4 class="widget-title">集群列表</h4>
						  </div>
						  <div class="widget-body">
							  <form id="tableForm">
								  <input name="token"  type="hidden" value="${token}"/>
								  <input name="colonyId"  type="hidden" value="${colonyId}"/>
							  <table class="table table-striped table-bordered table-hover" id="table">
								  <thead>
								  <tr>
								  <tr>
									  <th class="center">
										  <label>
											  <input type="checkbox" class="ace" />
											  <span class="lbl"></span>
										  </label>
									  </th>
									  <th>表名</th>
									  <th>别名</th>
									  <th>所属项目</th>
									  <th>列族</th>
									  <th>是否分割</th>
									  <th>是否MD5加密</th>
									  <th>开始分隔符</th>
									  <th>结束分隔符</th>
									  <th>分割数量</th>
								  </tr>
								  </thead>
								  <tbody>
								  <c:forEach items="${datas}" var="data">
									  <tr>
										  <td class="center">
											  <label>
												  <input type="checkbox" class="ace" />
												  <span class="lbl"></span>
											  </label>
										  </td>
										  <td>${data.value.tableName}</td>
										  <td>${data.value.alias}</td>
										  <td>${data.value.projectNames}</td>
										  <td>${data.value.family}</td>
										  <td>${data.value.isSplit}</td>
										  <td>${data.value.isMd5}</td>
										  <td>${data.value.startKey}</td>
										  <td>${data.value.endKey}</td>
										  <td>${data.value.splitNum}</td>
									  </tr>
								  </c:forEach>
								  </tbody>
							  </table>
							  </form>
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
		<script type="text/javascript">
			$(function () {

			 	$("#table").DataTable({
					"aoColumns": [{"bSortable": false},null, null,null, null, null,null, null,null,null],
		        	"lengthChange": false,
		          	"bFilter": true,
		          	paging: true,
		          	iDisplayLength:2,
		          	"bAutoWidth": true,//自动宽度
		          	 "language": language()
		        });


				$('table th input:checkbox').on('click' , function(){
					var that = this;
					$(this).closest('table').find('tr > td:first-child input:checkbox')
							.each(function(){
								this.checked = that.checked;
								$(this).closest('tr').toggleClass('selected');
							});
				});


				//保存提交
				$("#distrbuteBtn").click(function () {
					var url = "${ctx}/htoken/distrbute";
					$("#tableForm").attr("action", url).submit();
				})

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
