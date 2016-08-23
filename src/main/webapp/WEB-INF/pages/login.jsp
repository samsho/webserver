<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <base href="${ctx}/">
    <jsp:include page="/head.jsp"/>
    <script src="component/bootstrapValidator/dist/js/bootstrapValidator.min.js"></script>
    <script src="component/bootstrapValidator/dist/js/language/zh_CN.js"></script>
    <link rel="stylesheet" href="component/bootstrapValidator/dist/css/bootstrapValidator.min.css"/>
    <script>
        $(function () {
            $("form").bootstrapValidator().on('success.field.bv', function (e, data) {
                // If the field is empty
                var $parent = data.element.parents('.form-group');

                // Remove the has-success class
                $parent.removeClass('has-success');

                // Hide the success icon
                $parent.find('.form-control-feedback[data-bv-icon-for="' + data.field + '"]').hide();
                if (data.bv.getSubmitButton()) {
                    data.bv.disableSubmitButtons(false);
                }
            }).on('error.field.bv', function (e, data) {
                if (data.bv.getSubmitButton()) {
                    data.bv.disableSubmitButtons(false);
                }
            });

        })
    </script>
</head>
<body>
<div class="main-container login-layout">
    <div class="main-content">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="login-container">
                    <div class="center">
                        <h1>
                            <i class="ace-icon fa fa-leaf green"></i>
                            <span class="red">界面化管理系统</span>
                        </h1>
                    </div>

                    <div class="space-6"></div>

                    <div class="position-relative">
                        <div id="login-box" class="login-box visible widget-box no-border" style="background-color: #d0d0d0;">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <h4 class="header blue lighter bigger">
                                        <i class="ace-icon fa fa-coffee green"></i>
                                        	请登录：
                                        <c:if test="${not empty errorMessage}">
                                            <small class="red">
                                                ${errorMessage}
                                            </small>
                                        </c:if>

                                    </h4>

                                    <div class="space-6"></div>

                                    <form action="login" method="post">
                                        <fieldset>
                                            <div class="form-group clearfix">
                                                <div class="input-group block input-icon input-icon-right">
                                                    <input name="username" type="text" class="form-control" placeholder="用户名" required="required"/>
                                                    <i class="ace-icon fa fa-user"></i>
                                                </div>
                                            </div>

                                            <div class="form-group clearfix">
                                                <div class="input-group block input-icon input-icon-right">
                                                    <input name="password" type="password" class="form-control" placeholder="密码" required="required"/>
                                                    <i class="ace-icon fa fa-lock"></i>
                                                </div>
                                            </div>

                                            <div class="space"></div>

                                            <div class="form-group clearfix">
                                                <button class="width-35 pull-right btn btn-sm btn-primary" type="submit">
                                                    <i class="ace-icon fa fa-key"></i>
                                                    <span class="bigger-110">登录</span>
                                                </button>
                                            </div>

                                            <div class="space-4"></div>
                                        </fieldset>
                                    </form>
                                </div>
                                <!-- /.widget-main -->
                            </div>
                            <!-- /.widget-body -->
                        </div>
                        <!-- /.login-box -->

                        <!-- /position-relative -->
                        <div class="center">
                            <h4 class="blue">&copy;XX 网络科技股份有限公司</h4>
                        </div>
                    </div>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
    </div>
    <!-- /.main-container -->
</div>
</body>
</html>
