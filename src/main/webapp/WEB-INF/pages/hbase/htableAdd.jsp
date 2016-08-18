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
          <div class="col-xs-12 widget-container-col ui-sortable">
            <div class="widget-box widget-color-blue2 ui-sortable-handle">
              <div class="widget-header">
                <h4 class="widget-title">HBase表新增</h4>
              </div>
              <div class="widget-body">
              	<form class="form-horizontal" action="${ctx}/htable/save" method="post"  enctype="multipart/form-data" id="registerForm">
              		<div class="form-group" id="div0">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right"> 集群 </label>
						<div class="col-sm-7">
							<select id="colony" class="select2style" name="colony"  required data-bv-notempty-message="请选择集群">
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
						<div class="space-4"></div>
					</div>					
					<div class="form-group" id="div01">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right"> 所属项目 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<select id="project" name="projectIds"  class="js-example-basic-multiple" required multiple="multiple" data-bv-notempty-message="请选择集群">
						    	<option id='all_project' value="9999">所有项目</option>
						    	<c:forEach items="${projects}" var="project">
					            	<option value="${project.id}">${project.projectCode}</option>
								</c:forEach>
							</select>
						</div>
						<div class="space-4"></div>
					</div>
					
					
					<div class="form-group" id="div1">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" >表名 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="表名以项目名为前缀" class="col-xs-7" id="tableName" name="tableName"  data-bv-notempty="true"
								    required data-bv-notempty-message="表名不可为空" maxlength="50"/>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group" id="div10">
						<div class="space-4"></div>
						<label class="col-sm-4 control-label no-padding-right" > 中文名 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" name="alias"  required maxlength="100"/>
						</div>
						<div class="space-4"></div>
					</div>
	
					<div class="form-group" id="div2">
						<label class="col-sm-4 control-label no-padding-right" > 列族 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="f" class="col-xs-7" name="family" maxlength="50"/>
						</div>
						<div class="space-4"></div>
					</div>
					<c:if test="${fn:contains(authorities,'index_add')}">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" > 是否建索引 </label>
							<div class="radio">
								<label>
									<input name="isColumn" class="ace" type="radio"  value="true">
									<span class="lbl"> 是</span>
								</label>
								<label>
									<input name="isColumn" class="ace" type="radio" checked value="false">
									<span class="lbl"> 否</span>
								</label>
							</div>
							<div class="space-4"></div>
						</div>
					</c:if>

					<div id='div11' style="display:none" >
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" > 索引列(逗号分隔) </label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" id ="columnName" name="columnNames" />
						</div>
						<div class="space-4"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" > solr ZK地址 </label>
						<div class="col-sm-7">
							<select id="solrZKHost" name="tableIndex.solrZKHost"  class="js-example-basic-simple" required>
								<%--<option value="kmaster:2181,kslave01:2181,kslave02:2181/solr410" selected>kmaster:2181,kslave01:2181,kslave02:2181/solr410</option>--%>
								<option value="172.16.137.171:3181,172.16.137.172:3181,172.16.137.173:3181,172.16.137.176:3181,172.16.137.177:3181/solrcloudnew" selected>172.16.137.171:3181,172.16.137.172:3181,172.16.137.173:3181,172.16.137.176:3181,172.16.137.177:3181/solrcloudnew</option>
							</select>

						</div>
						<div class="space-4"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" > solr地址 </label>
						<div class="col-sm-7">
							<select id="solrHost" name="tableIndex.solrHost"  class="js-example-basic-simple" required>
								<%--<option value="10.14.84.128" selected>10.14.84.128</option>--%>
								<option value="172.16.137.209" selected>172.16.137.209</option>
								<option value="172.16.137.210" >172.16.137.210</option>
								<option value="172.16.137.211" >172.16.137.211</option>
								<option value="172.16.137.212" >172.16.137.212</option>
								<option value="172.16.137.213" >172.16.137.213</option>
							</select>

						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right"> solr端口号 </label>
						<div class="col-sm-7">
							<select id="solrPort" name="tableIndex.solrPort"  class="js-example-basic-simple" required>
								<option value="8888" selected>8888</option>
							</select>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" > 操作类型 </label>
						<div class="col-sm-7">
							<select id="solrAction" name="tableIndex.solrAction"  class="js-example-basic-simple" required>
								<option id='create' value="create" selected>新建</option>
							</select>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" > 分片数 </label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" id ="shardNum" name="tableIndex.shardNum" />
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right"> 副本数 </label>
						<div class="col-sm-7">
							<input type="text" placeholder="" class="col-xs-7" id ="replicaFactor" name="tableIndex.replicaFactor" />
						</div>
						<div class="space-4"></div>
					</div>
					</div>

					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" >
							<%--<span class="help-button" data-rel="popover" data-trigger="hover" data-placement="left" data-content="选择‘是’会在该表所在集群对应的灾备集群上新建副本表，并同步数据。默认选择‘否’即可。" title="表副本">?</span>--%>
							是否创建表副本
						</label>
						<div class="radio">
							<label>
								<input name="isBackUp" class="ace" type="radio"  value="true">
								<span class="lbl"> 是</span>
							</label>
							<label>
								<input name="isBackUp" class="ace" type="radio" checked value="false">
								<span class="lbl"> 否</span>
							</label>
							<span class="help-button" data-rel="popover" data-trigger="hover" data-placement="right" data-content="选择‘是’会在该表所在集群对应的灾备集群上新建副本表，并同步数据。默认选择‘否’即可。" title="表副本">?</span>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" >
							生存时间(ttl)
						</label>
						<div class="col-sm-7">
							<input type="text" placeholder="默认永久有效" class="col-xs-7" name="timeToLive"  maxlength="50"/>
							<span class="help-button" data-rel="popover" data-trigger="hover" data-placement="right"
								  data-content="TTL属性针对整个列族有效，可指定单元数据的有效时间，单位为秒(s)；默认是永久有效" title="TTL属性">?</span>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group" id="div9">
						<label class="col-sm-4 control-label no-padding-right" > 选择表结构描述文件 <small style="color: red">*</small> </label>
						<div class="ace-file-input col-sm-7" name="fileinput" id="fileinput">
							<input type="file" id="inputfile" name="file" required/>
							<small id="small1" style="display:none" class="help-block"  data-bv-result="INVALID">&nbsp;&nbsp;只能上传word类型文件！</small>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group" id="div3">
						<label class="col-sm-4 control-label no-padding-right" >
							是否分割
						</label>
						<div class="radio">
							<label>
								<input name="isSplit" class="ace" type="radio" checked value="true">
								<span class="lbl"> 是</span>
							</label>
							<label>
								<input name="isSplit" class="ace" type="radio" value="false">
								<span class="lbl"> 否</span>
							</label>
							<span class="help-button" data-rel="popover" data-trigger="hover" data-placement="right" data-content="建议选择“是”预分割region,优化hbase表的负载；分割数量以表具体的数据量为准。" title="Region预分割">?</span>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group"  id="div4">
						<label class="col-sm-4 control-label no-padding-right" > 是否使用MD5加密 </label>
						<div class="radio">
							<label>
								<input name="isMd5" class="ace" type="radio"  value="true">
								<span class="lbl"> 是</span>
							</label>
							<label>
								<input name="isMd5" class="ace" type="radio" checked value="false">
								<span class="lbl"> 否</span>
							</label>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group" id="div5">
						<label class="col-sm-4 control-label no-padding-right" > 开始分割符 </label>
						<div class="col-sm-7">
							<input type="text" placeholder="0" class="col-xs-7" id="startKey" name="startKey" />
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group" id="div6">
						<label class="col-sm-4 control-label no-padding-right" > 结束分割符 </label>
						<div class="col-sm-7">
							<input type="text" placeholder="z" class="col-xs-7" id="endKey" name="endKey"/>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-group" id="div7">
						<label class="col-sm-4 control-label no-padding-right" > 分割数量 <small style="color: red">*</small></label>
						<div class="col-sm-7">
							<input type="text" placeholder="以具体表实际数据量为依据，分割region为32、64等" class="col-xs-7" name="splitNum" id="splitNum" min="2"/>
						</div>
						<div class="space-4"></div>
					</div>
					
					<div class="form-actions center">
						<button class="btn btn-primary" type="submit" id="bt1">
								提交
						<i class="icon-arrow-right icon-on-right bigger-110"></i>
						</button>
						<button class="btn btn-primary" type="reset" onclick="javascript:history.back()">
								返回
						<i class="icon-arrow-right icon-on-right bigger-110"></i>
						</button>
					</div>
              	</form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="${ctx}/component/ace/assets/js/jquery.dataTables.min.js"></script>
    <script src="${ctx}/component/ace/assets/js/jquery.dataTables.bootstrap.min.js"></script>
	  <script src="${ctx}/component/formValidation/formValidation.min.js"></script>
	  <script src="${ctx}/component/formValidation/bootstrap.min.js"></script>
    <script src="${ctx}/component/scojs/js/sco.message.js"></script>
    <script src="${ctx}/component/select2/select2.js"></script>
    <script src="${ctx}/js/zh_CN.js"></script>
	  <link rel="stylesheet" href="${ctx}/component/formValidation/formValidation.min.css"/>
	  <link rel="stylesheet" href="${ctx}/component/scojs/css/sco.message.css"/>
 	<link rel="stylesheet" href="${ctx}/component/select2/select2.css" />

 
	<script>
	    $('#table').DataTable( {
	    	"language": language(),
	        paging: false
	    } );
    </script>
    <script type="text/javascript">
		$(function () {
			<c:if test="${not empty error}">
      			$.scojs_message("${error}", $.scojs_message.TYPE_ERROR);
	      	</c:if>
	      	<c:if test="${not empty success}">
	  			$.scojs_message("${success}", $.scojs_message.TYPE_OK);
	  		</c:if>

			/*提示格式化*/
			$('[data-rel=tooltip]').tooltip({container:'body'});
			$('[data-rel=popover]').popover({container:'body'});
	  		
	  		
	  		//$("input[type='radio'][name='isMd5'][value='false']").attr("checked","true"); 
	  		
	  		//如果不分割，则隐藏下面输入框
			$("input[name='isSplit']").click(function() {
				//checkMD5Box,非MD5加密，则显示自定义分割 
				
				var category = this.value;
				if(category=="true") {
					$('#div4').show();
					$('#div7').show();
					$('#splitNum').attr("required",true);//增加必填属性
					$('#registerForm').formValidation('enableFieldValidators', 'splitNum', true);
					var md5Value = $("input[name='isMd5'][type='radio']:checked").val();
					if(md5Value==="false"){
						$('#div5').show();
						$('#div6').show();
					}
					
				} else {
					//删除已经填写的值 
					$('#splitNum').val(null);
					$('#startKey').val(null);
					$('#endKey').val(null);
					$('#splitNum').removeAttr("required");//删除必填属性
					$('#registerForm').formValidation('enableFieldValidators', 'splitNum', false);
					$("input[type='radio'][name='isMd5'][value='false']").prop("checked", true);//设置默认选中“否”
					
					$('#div4').hide();
					$('#div5').hide();
					$('#div6').hide();
					$('#div7').hide();
				}
			});

	  		$("input[name='isMd5']").click(function() {
				var category = this.value;
				if(category=="true") {
					$('#div5').hide();
					$('#div6').hide();
				} else {
					
					$('#div5').show();
					$('#div6').show();
				}
	  		});
	  		
	  		// 索引操作 
	  		$("input[name='isColumn']").click(function() {
				var category = this.value;
				if(category=="true") {//新建索引 
					$('#div11').show();
					$('#columnName').attr("required",true);//增加必填属性
					$('#solrZKHost').attr("required",true);//增加必填属性
					$('#solrHost').attr("required",true);//增加必填属性
					$('#solrPort').attr("required",true);//增加必填属性
					$('#solrAction').attr("required",true);//增加必填属性
					$('#shardNum').attr("required",true);//增加必填属性
					$('#replicaFactor').attr("required",true);//增加必填属性
				} else {
					$('#div11').hide();
					$('#columnName').val(null).removeAttr("required");//删除必填属性  
					$('#solrZKHost').val(null).removeAttr("required");//删除必填属性
					$('#solrHost').val(null).removeAttr("required");//删除必填属性
					$('#solrPort').val(null).removeAttr("required");//删除必填属性
					$('#solrAction').val(null).removeAttr("required");//删除必填属性  
					$('#shardNum').val(null).removeAttr("required");//删除必填属性  
					$('#replicaFactor').val(null).removeAttr("required");//删除必填属性  
				}
				
	  		});

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

					if(inputFile.match(/.doc$/) != '.doc' && inputFile.match(/.docx$/) != '.docx') {//java
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
			
			 
	  		 $("#project,#solrAction,#solrPort,#solrHost,#solrZKHost,#colony").select2({
				width : "58.5%"
		     })

			 $('#registerForm').formValidation({
				 icon: {
					 valid: 'glyphicon glyphicon-ok',
					 invalid: 'glyphicon glyphicon-remove',
					 validating: 'glyphicon glyphicon-refresh'
				 },
				 excluded: ':disabled',//必须写，否则select2无法校验,[':disabled']
				 message: '该项不能为空！',
				 fields: {
					 splitNum: {
						 enabled: true,//默认生效,隐藏的时候校验失效
						 validators: {
							 notEmpty: {
							 }
						 }
					 }
				 }
			 });
	  		 
			 //加载调用 
			 //showTableName();
			 
			 //点击调用显示表名 
			 $("#project").on("change",function(){
				 showTableName();
			 })
			 
			 //根据项目，动态显示表名(全选、多选、不选不会访问后台) 
			 function showTableName (){
				var projectId = $("#project").val();//数组 
				//console.log(projectId instanceof Array) //返回true  
				var tableName = $("input[name='tableName']");
			 	if(projectId && projectId!=9999 && projectId.length==1){
				 	 $.ajax({
		    		    url:"${ctx}/hproject/getCodeById",
		    		    type:"get",
		    		    data: "&projectId="+projectId,
		    		    success:function(data){
							tableName.val(data);
		    		    }
			    	 });
			 	}else{
			 		tableName.val('');
			 	}
			 };
		
		});
	</script>
  </jsp:body>
</t:base_layout>
