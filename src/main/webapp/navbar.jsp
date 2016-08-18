<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="navbar-container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar">
                <span class="sr-only">展开</span>
                <span class="icon-bar">数据库操作</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${ctx}/">
                <small>
                    <i class="fa fa-leaf"></i>
                   	Boots 界面管理系统
                </small>
            </a>
        </div>

        <div class="navbar-buttons navbar-header pull-right" role="navigation">
            <ul class="nav ace-nav">
                <li class="light-blue">
                    <a class="dropdown-toggle" href="#" data-toggle="dropdown">
                        <img alt="${sessionScope.get('__USER__').username}的头像" src="component/ace/assets/avatars/user.jpg" class="nav-user-photo">
						<span class="user-info">
							<small>你好</small>
							${sessionScope.get('__USER__').username}
						</span>
                        <i class="ace-icon fa fa-caret-down"></i>
                    </a>

                    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                        <li>
                            <a href="${ctx}/logout">
                                <i class="ace-icon fa fa-power-off"></i>
                              	  退出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>

</nav>