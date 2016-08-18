<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<div class="sidebar responsive sidebar-fixed" id="sidebar"
	data-sidebar="true" data-sidebar-scroll="true"
	data-sidebar-hover="true">
	<script type="text/javascript">
		try {
			ace.settings.check('sidebar', 'fixed')
		} catch (e) {
		}
	</script>

	<ul class="nav nav-list" style="top: 0;">
		<c:forEach items="${__USER__.sidebar.items}" var="item">
			<c:choose>
				<c:when test="${not empty item.children}">
					<li
						class="<c:if test='${item.active}'>active <c:if test='${not empty item.children}'>open</c:if></c:if>">
						<a class="dropdown-toggle" href="#"> <i
							class="menu-icon fa ${item.icon}"></i> <span class="menu-text">${item.title}
								<c:if test="${item.displayCount}">
									<span class="badge badge-primary">${item.children.size()}</span>
								</c:if>
						</span> <b class="arrow fa fa-angle-down"></b>
					</a> <b class="arrow"></b>
						<ul class="submenu">
							<c:forEach items="${item.children}" var="sub">
								<li class="<c:if test='${sub.active}'>active</c:if>"><a
									href="<c:out value='${ctx}${sub.url}'/>"> <i
										class="menu-icon fa fa-angle-right"></i> ${sub.title}
								</a> <b class=" arrow"></b></li>
							</c:forEach>
						</ul>
					</li>
				</c:when>
				<c:otherwise>
					<li class="<c:if test='${item.active}'>active</c:if>"><a
						href="<c:out value='${ctx}/${item.url}'/>"> <i
							class="menu-icon fa ${item.icon}"></i> ${item.title}
					</a> <b class=" arrow"></b></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</ul>
	<!-- /.nav-list -->

	<div id="sidebar-collapse" class="sidebar-toggle sidebar-collapse">
		<i data-icon2="ace-icon fa fa-angle-double-right"
			data-icon1="ace-icon fa fa-angle-double-left"
			class="ace-icon fa fa-angle-double-left"></i>
	</div>

	<script type="text/javascript">
		try {
			ace.settings.check('sidebar', 'collapsed')
		} catch (e) {
		}
	</script>
</div>