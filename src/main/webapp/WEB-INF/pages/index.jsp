<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<t:base_layout>
	<jsp:attribute name="title">
    	Boots界面化管理系统
    </jsp:attribute>
	<jsp:body>
        <div class="page-header">
			<h1>Hello ${__USER__.username}, 欢迎使用界面化管理系统</h1>
		</div>



    </jsp:body>
</t:base_layout>
