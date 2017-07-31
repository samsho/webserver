<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/8/26
  Time: 17:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<t:base_layout>
    <jsp:attribute name="title">
       select2
    </jsp:attribute>
    <jsp:body>
        <div class="page-header">
            <h1>用户管理</h1>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-1">
                <h1>简单的select</h1>
            </div>

            <div class="col-md-6 col-md-offset-1">
                <select class="js-example-basic-single">
                    <option value=""></option>
                    <option value="AL">Alabama</option>
                    <option value="WY">Wyoming</option>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-1">
                <h1>多选的select</h1>
            </div>

            <div class="col-md-6 col-md-offset-1">
                <select class="js-example-basic-multiple" multiple="multiple">
                    <option value="AL">Alabama</option>
                    <option value="WY">Wyoming</option>
                    <option value="YU">YyImhgh</option>
                    <option value="KI">Kijuhgh</option>
                </select>
            </div>
        </div>


        <script>
            $(function () {
                $(".js-example-basic-single").select2({
                    placeholder: "Select a state"
                });

                $(".js-example-basic-multiple").select2({});


            })

        </script>

    </jsp:body>
</t:base_layout>