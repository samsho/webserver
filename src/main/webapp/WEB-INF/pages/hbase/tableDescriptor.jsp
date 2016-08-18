<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:base_layout>
    <jsp:attribute name="title">
        任务管理
    </jsp:attribute>
  <jsp:body>
    <div class="page-header">
      <div id="breadcrumbs">
		<ul class="breadcrumb">
			<li>
				<i class="icon-home home-icon"></i>
				<a href="${ctx}/taskInfo/init">任务管理</a>
			</li>
			<li class="active">任务运行日志</li>
		</ul><!-- .breadcrumb -->
	</div>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <div class="row">
          <div class="col-xs-12 widget-container-col ui-sortable">
            <div class="widget-box widget-color-blue2 ui-sortable-handle">
              <div class="widget-header">
                <h4 class="widget-title">运行日志查看</h4>
                	
              </div>
              <div class="widget-body ">
              <pre>${descriptor }</pre>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="${ctx}/js/zh_CN.js"></script>
    <script src="assets/js/ace-elements.min.js"></script>
	<script src="assets/js/ace.min.js"></script>
  </jsp:body>
</t:base_layout>
