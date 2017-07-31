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
                                    <form class="form-inline" method="post" id="searchForm">
                                        <div class="form-group">
                                            <label class="col-xs-4  col-sm-12 control-label la">color：</label>
                                            <select id="colony" class="select2style" name="colors">
                                                <option value=""></option>
                                                <option value="black">Black</option>
                                                <option value="blue">Blue</option>
                                                <option value="green">Green</option>
                                                <option value="orange">Orange</option>
                                                <option value="red">Red</option>
                                                <option value="yellow">Yellow</option>
                                                <option value="white">White</option>
                                            </select>
                                        </div>

                                            <%--<div class="form-group">
                                                <label class="col-xs-4 control-label">Favorite color using tags</label>
                                                <div class="col-xs-6">
                                                    <input class="form-control" name="colors-tags"
                                                           multiple data-placeholder="Choose 2-4 colors" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">Favorite color</label>

                                                <div class="col-xs-8 chosenContainer">
                                                    <select class="form-control chosen-select" name="colors2" multiple
                                                            data-placeholder="Choose 2-4 colors" style="width: 100%;">
                                                        <option value="black">Black</option>
                                                        <option value="blue">Blue</option>
                                                        <option value="green">Green</option>
                                                        <option value="orange">Orange</option>
                                                        <option value="red">Red</option>
                                                        <option value="yellow">Yellow</option>
                                                        <option value="white">White</option>
                                                    </select>
                                                </div>
                                            </div>--%>


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
                                        <th class="center">
                                            <label>
                                                <input type="checkbox" class="ace ace-checkbox-2"/>
                                                <span class="lbl"></span>
                                            </label>
                                        </th>
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
                                            <td class="center">
                                                <label>
                                                    <input type="checkbox" class="ace ace-checkbox-2"/>
                                                    <span class="lbl"></span>
                                                </label>
                                            </td>
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
                                <label class="col-xs-3 control-label">JobNumber</label>

                                <div class="col-xs-5">
                                    <input type="text" class="form-control" name="jobNumber" required/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3 control-label">Email</label>

                                <div class="col-xs-5">
                                    <input type="email" class="form-control" name="email" required/>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-xs-7 col-xs-offset-3">
                                    <button type="submit" id="validateButton" class="btn btn-primary">Login</button>
                                        <%--<button type="submit" id="skipButton" class="btn btn-primary">skip validate</button>--%>
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
        <link rel="stylesheet" href="${ctx}/component/scojs/css/sco.message.css"/>
        <script src="${ctx}/component/scojs/js/sco.message.js"></script>

        <link rel="stylesheet" href="${ctx}/component/ace/assets/css/chosen.min.css"/>
        <script src="${ctx}/component/ace/assets/js/chosen.jquery.min.js"></script>
        <style type="text/css">
            .chosen-choices {
                border: 1px solid #ccc;
                border-radius: 4px;
                min-height: 34px;
                padding: 6px 12px;
            }

            .chosenContainer .form-control-feedback {
                /* Adjust feedback icon position */
                right: -15px;
            }

            .chosenContainer .form-control {
                height: inherit;
                padding: 0px;
            }

            #searchForm .form-control-feedback {
                /* To make the feedback icon visible */
                z-index: 100;
            }
        </style>

        <script>


            $(function () {
                /*校验select2*/
                $('#searchForm')
                        .find('[name="colors"]')
                        .select2({
                            width: "180px",
                            placeholder: "Select an option",
                            allowClear: true

                        })
                    // Revalidate the color when it is changed
                        .change(function (e) {
                            $('#searchForm').formValidation('revalidateField', 'colors');
                        })
                        .end()
                        .find('[name="colors-tags"]')
                        .select2({
                            // Specify tags
                            tags: ['Black', 'Blue', 'Green', 'Orange', 'Red', 'Yellow', 'White']
                        })
                    // Revalidate the color when it is changed
                        .change(function (e) {
                            $('#searchForm').formValidation('revalidateField', 'colors-tags');
                        })
                        .end()
                        .formValidation({
                            framework: 'bootstrap',
                            excluded: ':disabled',
                            icon: {
                                valid: 'glyphicon glyphicon-ok',
                                invalid: 'glyphicon glyphicon-remove',
                                validating: 'glyphicon glyphicon-refresh'
                            },
                            fields: {
                                colors: {
                                    validators: {
                                        callback: {
                                            message: 'Please choose 1 color you like most',
                                            callback: function (value, validator, $field) {
                                                // Get the selected options
                                                var options = validator.getFieldElements('colors').val();
                                                return (options != null && options.length >= 1);
                                            }
                                        }
                                    }
                                },
                                'colors-tags': {
                                    validators: {
                                        callback: {
                                            message: 'Please choose 2-4 color you like most',
                                            callback: function (value, validator, $field) {
                                                // Get the selected options
                                                var options = validator.getFieldElements('colors-tags').val(),
                                                        options2 = options.split(',');
                                                return (options2 !== null && options2.length >= 2 && options2.length <= 4);
                                            }
                                        }
                                    }
                                }
                            }
                        });

                /*校验chosen*/
                $('#searchForm')
                        .find('[name="colors2"]')
                        .chosen({
                            width: '100%',
                            inherit_select_classes: true
                        })
                    // Revalidate the color when it is changed
                        .change(function (e) {
                            $('#searchForm').formValidation('revalidateField', 'colors2');
                        })
                        .end()
                        .formValidation({
                            framework: 'bootstrap',
                            excluded: ':disabled',
                            icon: {
                                valid: 'glyphicon glyphicon-ok',
                                invalid: 'glyphicon glyphicon-remove',
                                validating: 'glyphicon glyphicon-refresh'
                            },
                            fields: {
                                colors2: {
                                    validators: {
                                        callback: {
                                            message: 'Please choose 2-4 color you like most',
                                            callback: function (value, validator, $field) {
                                                // Get the selected options
                                                var options = validator.getFieldElements('colors2').val();
                                                return (options != null && options.length >= 2 && options.length <= 4);
                                            }
                                        }
                                    }
                                }
                            }
                        });

                /*校验form*/
                $('#loginForm').formValidation({
                    framework: 'bootstrap',
                    button: {
                        selector: '#validateButton',
                        disabled: 'disabled'
                    },
//                    excluded: ':disabled',
                    excluded: [':disabled', ':hidden', ':not(:visible)'],
                    icon: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    message: '必输项',
                    fields: {
                        username: {
                            validators: {
                                notEmpty: {
                                    message: '请输入你的姓名'
                                },
                                stringLength: {
                                    min: 3,
                                    max: 30,
                                    message: 'The name must be more than 3 and less than 30 characters long'
                                },
                                regexp: {
                                    regexp: /^[a-zA-Z0-9_]+$/,
                                    message: 'The name can only consist of alphabetical, number and underscore'
                                }
                            }
                        },
                        password: {
                            validators: {
                                notEmpty: {
                                    message: '请输入你的密码'
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

                /*提示格式化*/
                $('[data-rel=tooltip]').tooltip({container: 'body'});
                $('[data-rel=popover]').popover({container: 'body'});


                /*批量选择多选*/
                $('table th input:checkbox').on('click', function () {
                    var that = this;//this:父checkbox
                    // 获取this的第一个父类table元素，下面所有的tr下面
                    $(this).closest('table').find('tr > td:first-child input:checkbox')
                            .each(function () {
                                this.checked = that.checked;//this:子checkbox
                                if (this.checked) {
                                    $(this).closest('tr').addClass('danger');//所在行变色
                                } else {
                                    $(this).closest('tr').removeClass('danger');//所在行变色
                                }
                            });
                });

                $('table tbody').find('tr > td:first-child input:checkbox').on('click', function () {
                    $(this).closest('tr').toggleClass('danger');//所在行变色
//                    if (this.checked) {
                        $(this).closest('table').find('tr > th:first-child input:checkbox').checked;
//                    }
                });

                /**
                 * 用户新增模态框
                 */
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

            })
        </script>
    </jsp:body>
</t:base_layout>
