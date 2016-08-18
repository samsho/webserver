<%@tag description="Page Template" pageEncoding="UTF-8" %>
<%@attribute name="title" %>
<!DOCTYPE html>
<html>
<head>
    <title>${title}</title>
    <base href="${ctx}/">
    <jsp:include page="/head.jsp"/>
</head>
<body class="no-skin">
<jsp:include page="/navbar.jsp"/>
<div class="main-container">
    <jsp:include page="/sidebar.jsp"/>
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <jsp:doBody/>
            </div>
        </div>
    </div>
</div>

</body>
</html>
