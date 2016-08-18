<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<t:base_layout>
	<jsp:attribute name="title">
       	 同步管理
    </jsp:attribute>

    <jsp:body>
        <div class="page-header">
            <h1>同步管理操作</h1>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="space-6"></div>
                        <div class="widget-box">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <div class="row">
                                        <div class="col-xs-12  col-sm-12">

                                            <form class="form-inline" action="${ctx}/synchronize/initData"
                                                  method="POST">
                                                <div class="input-group">
                                                    <label>同步任务：</label>
                                                    <select id="operateType" name="operateType" class="select2style">
                                                        <c:forEach items="${syncTypes}" var="type">
                                                            <c:choose>
                                                                <c:when test="${search.operateType.name() == type.name()}">
                                                                    <option value="${type.name()}"
                                                                            selected>${type.getDesc()}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${type.name()}">${type.getDesc()}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                </div>


                                                <div class="input-group">
                                                    <label>同步源：</label>
                                                    <select id="source" class="select2style" name="source" required>
                                                        <c:forEach items="${colonys}" var="colo">
                                                            <c:choose>
                                                                <c:when test="${search.source == colo.id}">
                                                                    <option value="${colo.id}"
                                                                            selected>${colo.name}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${colo.id}">${colo.name}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>

                                                    </select>
                                                </div>

                                                <div class="input-group">
                                                    <label>同步目标：</label>
                                                    <select id="target" class="select2style" name="target" required>
                                                        <c:forEach items="${colonys}" var="colo">
                                                            <c:choose>
                                                                <c:when test="${search.target == colo.id}">
                                                                    <option value="${colo.id}"
                                                                            selected>${colo.name}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${colo.id}">${colo.name}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>

                                                    </select>
                                                </div>

                                                <button class="btn btn-purple btn-sm" id="dataQuery" type="submit">
                                                    查询
                                                    <i class="icon-search icon-on-right bigger-110"></i>
                                                </button>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    <%--<div class="space-8"></div>--%>

                <div class="row">
                    <div class="col-xs-12 widget-container-col ui-sortable">
                        <div class="widget-box widget-color-blue2 ui-sortable-handle">
                            <div class="widget-header">
                                <h4 class="widget-title">集群列表</h4>
                            </div>
                            <div class="widget-body">
                                <form id="tableForm" method="POST">
                                    <input type="hidden" id="operType" name="operType">
                                    <input type="hidden" id="tableColonyId" name="tableColonyId">
                                    <table class="table table-striped table-bordered table-hover" id="table">
                                        <thead>
                                        <tr>
                                        <tr>
                                            <th class="center">
                                                <label>
                                                    <input type="checkbox" class="ace"/>
                                                    <span class="lbl"></span>
                                                </label>
                                            </th>
                                            <th>表名</th>
                                            <th>别名</th>
                                            <th>列族</th>
                                            <th>是否分割</th>
                                            <th>是否MD5加密</th>
                                            <th>开始分隔符</th>
                                            <th>结束分隔符</th>
                                            <th>分割数量</th>
                                            <th>创建者</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${tables}" var="table">
                                            <tr>
                                                <td class="center">
                                                    <label>
                                                        <input type="checkbox" class="ace" id="tableId"
                                                               value="${table.id}"/>
                                                        <span class="lbl"></span>
                                                    </label>
                                                </td>
                                                <td>${table.tableName}</td>
                                                <td>${table.alias}</td>
                                                <td>${table.family}</td>
                                                <td>${table.isSplit}</td>
                                                <td>${table.isMd5}</td>
                                                <td>${table.startKey}</td>
                                                <td>${table.endKey}</td>
                                                <td>${table.splitNum}</td>
                                                <td>${table.createUser}</td>
                                                <td>
                                                    <%--<c:if test="${fn:contains(authorities,'table_backup')}">--%>
                                                        <a data-toggle="modal" data-target="#confirmModel" class="btn btn-success btn-xs">同步<a/>
                                                    <%--</c:if>--%>
                                                </td>
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

        <!-- 同步确认 -->
        <div class="modal fade" id="confirmModel" data-backdrop="static" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                        <h4 class="modal-title">确认</h4>
                    </div>
                    <div class="modal-body">
                        确认同步该表吗！
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-danger" id="backUpSure">确定</button>
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

        <script src="${ctx}/component/select2/select2.js"></script>
        <link rel="stylesheet" href="${ctx}/component/select2/select2.css"/>
        <script type="text/javascript">
            $(function () {
                $("#table").DataTable({
                    "aoColumns": [{"bSortable": false}, null, null, null, null, null, null, null, null, null, null],
                    "lengthChange": false,
                    "bFilter": true,
                    paging: true,
                    iDisplayLength: 10,
                    "bAutoWidth": true,//自动宽度
                    "language": language()
                });

                $("#operateType,#source,#target").select2({
                    width: "220px"
                })

                $('table th input:checkbox').on('click', function () {
                    var that = this;
                    $(this).closest('table').find('tr > td:first-child input:checkbox')
                            .each(function () {
                                this.checked = that.checked;
                                $(this).closest('tr').toggleClass('selected');
                            });
                });

                <c:if test="${not empty error}">
                $.scojs_message("${error}", $.scojs_message.TYPE_ERROR);
                </c:if>
                <c:if test="${not empty success}">
                $.scojs_message("${success}", $.scojs_message.TYPE_OK);
                </c:if>

                $("#operateType").on("change", function () {
                    var operateType = $(this).val();
                    alert(operateType);

                });

                $('#confirmModel').on('shown.bs.modal', function () {
                    alert('嘿，我听说您喜欢模态框...');

                });




            });





            function backUpTable(tableName) {

                var sourceColony = $("#dataSource").val();
                var targetColony = $("#dataTarget").val();

                $('#backUpTable').modal('show').on('shown.bs.modal', function () {//绑定监听事件，当模态框显示后，执行相应的动作
                    $("#backUpSure").on("click", function () {
                        $.ajax({
                            url: "${ctx}/synchronize/dealDatas",
                            type: "post",
                            data: {
                                "tableName": tableName,
                                "sourceColony": sourceColony,
                                "targetColony": targetColony
                            },
                            beforeSend: function () {
                                //这里是开始执行方法，显示效果，效果自己写
                                $('#backUpTable').modal('hide');
                                $('#waiting').modal('show');
                            },
                            complete: function () {
                                //方法执行完毕，效果自己可以关闭，或者隐藏效果
                                $('#waiting').modal('hide');
                            },
                            success: function (data) {
                                //数据加载成功
                                if ("0" == data.isSuccess) {
                                    $.scojs_message('同步数据成功！', $.scojs_message.TYPE_OK);
                                } else {
                                    $.scojs_message(data.error, $.scojs_message.TYPE_ERROR);
                                }
                                window.setTimeout(function () {
                                    location.reload();
                                }, 1000);
                            },
                            error: function () {
                                //数据加载失败
                            }
                        });
                    });
                });
            }

        </script>
        <style type="text/css">
            .la {
                width: 100px;
                line-height: 31px;
            }
        </style>
    </jsp:body>
</t:base_layout>
