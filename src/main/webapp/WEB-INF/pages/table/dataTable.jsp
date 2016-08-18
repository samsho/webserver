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
            <h1>表管理</h1>
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
                                            <label class="col-xs-12 la">查询</label>
                                            <select class="form-control" style="width: 80px">
                                                <option selected>select1</option>
                                                <option selected>select2</option>
                                                <option selected>select3</option>
                                            </select>
                                        </div>
                                        &nbsp;
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" class="ace ace-checkbox-2" name="onlyHBM"/>
                                                <span class="lbl"> 仅显示平台</span>
                                            </label>
                                        </div>
                                        &nbsp;
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
                                <h4 class="widget-title">DataTable</h4>
                                <span class="widget-toolbar">
                                    <a href="#" data-action="collapse">
                                        <i class="fa fa-angle-down" aria-hidden="true"></i>
                                    </a>
                                </span>
                            </div>

                            <div class="widget-body">
                                <table class="table table-striped table-bordered table-hover" id="table">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>用户名</th>
                                        <th>工号</th>
                                        <th>访问类型</th>
                                        <th>参数</th>
                                        <th>异常</th>
                                        <th>URL</th>
                                        <th>IP</th>
                                        <th>创建时间</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${logs}" var="log">
                                        <tr>
                                            <td>${log.id}</td>
                                            <td>${log.username}</td>
                                            <td>${log.jobName}</td>
                                            <td>${log.action}</td>
                                            <td>${log.args}</td>
                                            <td>${log.exception}</td>
                                            <td>${log.url}</td>
                                            <td>${log.ip}</td>
                                            <td>${log.createTime}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                            <%--表2--%>
                        <div class="widget-box widget-color-blue2 ui-sortable-handle">
                            <div class="widget-header">
                                <h4 class="widget-title">DataTable2</h4>
                                <span class="widget-toolbar">
                                    <a href="#" data-action="collapse">
                                        <i class="fa fa-angle-down" aria-hidden="true"></i>
                                    </a>
                                </span>
                            </div>

                            <div class="widget-body">
                                <table class="table table-striped table-bordered table-hover" id="table2">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>用户名</th>
                                        <th>工号</th>
                                        <th>访问类型</th>
                                        <th>参数</th>
                                        <th>异常</th>
                                        <th>URL</th>
                                        <th>IP</th>
                                        <th>创建时间</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>

                            <%--表3--%>
                        <div class="widget-box widget-color-blue2 ui-sortable-handle">
                            <div class="widget-header">
                                <h4 class="widget-title">DataTable3</h4>
                                <span class="widget-toolbar">
                                    <a href="#" data-action="collapse">
                                        <i class="fa fa-angle-down" aria-hidden="true"></i>
                                    </a>
                                </span>
                            </div>

                            <div class="widget-body">
                                <table class="table table-striped table-bordered table-hover" id="table3">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>ID</th>
                                        <th>用户名</th>
                                        <th>工号</th>
                                        <th>访问类型</th>
                                        <th>参数</th>
                                        <th>异常</th>
                                        <th>URL</th>
                                        <th>IP</th>
                                        <th>创建时间</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${logs}" var="log">
                                        <tr>
                                            <th></th>
                                            <td>${log.id}</td>
                                            <td>${log.username}</td>
                                            <td>${log.jobName}</td>
                                            <td>${log.action}</td>
                                            <td>${log.args}</td>
                                            <td>${log.exception}</td>
                                            <td>${log.url}</td>
                                            <td>${log.ip}</td>
                                            <td>${log.createTime}</td>
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
        <script src="${ctx}/component/ace/assets/js/jquery.dataTables.min.js"></script>
        <script src="${ctx}/component/ace/assets/js/jquery.dataTables.bootstrap.min.js"></script>
        <script src="${ctx}/js/zh_CN.js"></script>

        <script>
            $(function () {

                // jquery事件配合deferred rendering使用:
                $('#table tbody').on('click', 'td', function () {
                    alert('Clicked on: ' + this.innerHTML);
                });

                $("#table").dataTable({
                    "autoWidth": false,
                    "columns": [{
                        "width": "20%",
                        "orderable": false,
                        "searchable": false
                    }, null, null, null, null, null, null, null, null],//宽度,"autoWidth": false
                    paging: true, //分页，false|true
                    "scrollY": "200px",
                    "scrollCollapse": true,
                    language: language(),  //中文
                    "deferRender": true,// 控制表格的延迟渲染，可以提高初始化的速度。控制表格的延迟渲染，可以提高初始化的速度。
                    "info": false,  //左下角信息，可以使用 language一起控制
                    lengthChange: true,//每页显示的数据量，提前是 paging 为true.
                    "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],// 每页显示的数据量
                    "processing": true,
                    "ordering": true, //排序
                    "searching": true, //搜索过滤
                    iDisplayLength: 10
                });

                var data = [
                    [
                        "Tiger Nixon",
                        "System Architect",
                        "Edinburgh",
                        "5421",
                        "2011/04/25",
                        "$3,120"
                    ],
                    [
                        "Garrett Winters",
                        "Director",
                        "Edinburgh",
                        "8422",
                        "2011/07/25",
                        "$5,300"
                    ]
                ];

                /**
                 * 后台分页
                 **/
                $("#table2").dataTable({
//                    data:data //指定数据
                    language: language(), //中文

                    /*后台分页*/
                    processing: true,
                    serverSide: true,
                    ajax: "${ctx}/table/ajax/dataTable",
                    columns: [
                        {"data": "id"},
                        {"data": "username"},
                        {"data": "jobName"},
                        {"data": "action"},
                        {"data": "args"},
                        {"data": "exception"},
                        {"data": "url"},
                        {"data": "ip"},
                        {"data": "createTime"}
                    ]
                });


                /**
                 *
                 * @type {jQuery}
                 */
                var table = $('#table3').DataTable({
                    "columns": [{
                        "className": 'details-control',
                        "orderable": false,
                        "data": null,
                        "defaultContent": 'a'
                    }, null,null, null, null, null, null, null, null, null],
                    "order": [[1, 'asc']]
                });

                // Add event listener for opening and closing details
                $('#table3 tbody td.details-control').on('click',function () {
                    var tr = $(this).closest('tr');
                    var row = table.row(tr);

                    if (row.child.isShown()) {
                        // This row is already open - close it
                        row.child.hide();
                        tr.removeClass('shown');
                    }
                    else {
                        // Open this row
                        row.child(format(row.data())).show();
                        tr.addClass('shown');
                    }
                });

            })
            function format(d) {
                // `d` is the original data object for the row
                return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
                        '<tr>' +
                        '<td>Full name:</td>' +
                        '<td>' + d.name + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>Extension number:</td>' +
                        '<td>' + d.extn + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>Extra info:</td>' +
                        '<td>And any further details here (images etc)...</td>' +
                        '</tr>' +
                        '</table>';
            }

        </script>
    </jsp:body>
</t:base_layout>