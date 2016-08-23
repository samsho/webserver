<%--
  Created by IntelliJ IDEA.
  User: home
  Date: 2016/8/21
  Time: 9:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<t:base_layout>
    <jsp:attribute name="title">
       用户管理
    </jsp:attribute>
    <jsp:body>
        <div class="page-header">
            <h1>用户管理</h1>
        </div>
        <!-- /.page-header -->


        <div class="row">
            <div class="col-xs-12">

                <!-- PAGE CONTENT BEGINS -->
                <div class="row">
                    <div class="col-xs-12">
                        <div class="space-6"></div>
                    </div>
                </div>

                    <%--页面内容头部--%>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="space-6"></div>
                        <div class="widget-box">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <form class="form-inline" method="post" id="form">
                                        <div class="form-group">
                                            <label class="col-xs-12  col-sm-12 la">集&nbsp;&nbsp;群：</label>
                                            <select id="colony" class="select2style" style="width: 250px" name="colony">
                                                <option>1</option>
                                                <option>2</option>
                                            </select>
                                        </div>

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
                    <%-- /.页面内容头部--%>

                    <%--页面正文--%>
                <div class="row">
                    <div class="col-xs-12 widget-container-col ui-sortable">

                            <%--表1--%>
                        <div class="widget-box widget-color-blue2 ui-sortable-handle">
                            <div class="widget-header">
                                <h4 class="widget-title">用户列表</h4>
                                <span class="widget-toolbar">
                                    <a onclick="userAdd()" class="btn btn-primary btn-xs" title="新增用户"
                                       data-toggle="tooltip">
                                        <i class="ace-icon fa bigger-125 fa-plus"></i>
                                    </a>
                                </span>
                            </div>

                            <div class="widget-body">
                                <table class="table table-striped table-bordered table-hover" id="table">
                                    <thead>
                                    <tr>
                                        <th>编号</th>
                                        <th>姓名</th>
                                        <th>密码</th>
                                        <th>邮箱</th>
                                        <th>工号</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${users}" var="user">
                                        <tr>
                                            <td>${user.id}</td>
                                            <td>${user.username}</td>
                                            <td>${user.password}</td>
                                            <td>${user.email}</td>
                                            <td>${user.jobNumber}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                    <%--/.页面正文--%>

                <!-- PAGE CONTENT BEGINS -->
            </div>
        </div>
        <div class="modal fade" id="addConfirm" data-backdrop="static" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                        <h4 class="modal-title">用户新增</h4>
                    </div>
                    <div class="modal-body">
                        <!-- The form is placed inside the body of modal -->
                        <form id="loginForm" method="post" class="form-horizontal" action="${ctx}/user/save">
                            <div class="form-group">
                                <label class="col-xs-3 control-label">Username</label>

                                <div class="col-xs-5">
                                    <input type="text" class="form-control" name="username"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3 control-label">Password</label>

                                <div class="col-xs-5">
                                    <input type="password" class="form-control" name="password"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-xs-5 col-xs-offset-3">
                                    <button type="submit" class="btn btn-primary">Login</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                </div>
                            </div>
                        </form>
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

        <link rel="stylesheet" href="${ctx}/component/formValidation/formValidation.min.css"/>
        <script src="${ctx}/component/formValidation/formValidation.min.js"></script>
        <script src="${ctx}/component/formValidation/bootstrap.min.js"></script>
        <script>

            $(function () {

                $('#loginForm').formValidation({
                    framework: 'bootstrap',
                    excluded: ':disabled',
                    icon: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        username: {
                            validators: {
                                notEmpty: {
                                    message: 'The username is required'
                                }
                            }
                        },
                        password: {
                            validators: {
                                notEmpty: {
                                    message: 'The password is required'
                                }
                            }
                        }
                    }
                }).on('success.form.fv', function (e) {
                    // Prevent form submission
                    e.preventDefault();

                    var $form = $(e.target), fv = $(e.target).data('formValidation');
                    // Do whatever you want here ...
                    // Then submit the form as usual
                    fv.defaultSubmit();
                });


                $(".select2style").select2({
                    width: "180px"
                });

                /*提示格式化*/
                $('[data-rel=tooltip]').tooltip({container: 'body'});
                $('[data-rel=popover]').popover({container: 'body'});

            })

            function userAdd() {
                $('#addConfirm').modal('show').on('shown.bs.modal', function () {//绑定监听事件，当模态框显示后，执行相应的动作
                    $('#loginForm').formValidation('resetForm', true);
                });
            }


            <c:if test="${not empty error}">
            $.scojs_message("${error}", $.scojs_message.TYPE_ERROR);
            </c:if>
            <c:if test="${not empty success}">
            $.scojs_message("${success}", $.scojs_message.TYPE_OK);
            </c:if>


        </script>
    </jsp:body>
</t:base_layout>
