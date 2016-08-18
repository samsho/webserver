<%--
  Created by IntelliJ IDEA.
  User: ymh09658
  Date: 2015/3/2
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:base_layout>
    <jsp:attribute name="title">
        管理平台
    </jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <div class="error-container">
                    <div class="well">
                        <h1 class="grey lighter smaller">
                                    <span class="blue bigger-125">
                                        <i class="ace-icon fa fa-sitemap"></i>
                                        404
                                    </span>
                            页面未找到
                        </h1>

                        <hr/>
                        <h3 class="lighter smaller">该页面无法访问</h3>

                        <div>
                            <form class="form-search">
												<span class="input-icon align-middle">
													<i class="ace-icon fa fa-search"></i>

													<input type="text" placeholder="请输入关键字" class="search-query">
												</span>
                                <button type="button" class="btn btn-sm">搜索</button>
                            </form>

                            <div class="space"></div>

                        </div>

                        <hr/>
                        <div class="space"></div>

                        <div class="center">
                            <a href="javascript:history.back()" class="btn btn-grey">
                                <i class="ace-icon fa fa-arrow-left"></i>
                                返回
                            </a>

                            <a href="${ctx}/" class="btn btn-primary">
                                <i class="ace-icon fa fa-server"></i>
                                主页
                            </a>
                        </div>
                    </div>
                </div>
                <!-- PAGE CONTENT ENDS -->
            </div>
            <!-- /.col -->
        </div>
    </jsp:body>
</t:base_layout>
