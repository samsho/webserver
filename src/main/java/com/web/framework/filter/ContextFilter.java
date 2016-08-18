package com.web.framework.filter;

import com.web.framework.bean.base.User;
import com.google.common.collect.ImmutableList;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Optional;

/**
 * ClassName: UserFilter
 * Description:
 * Date: 2016/1/18 15:44
 *
 * @author ymh09658
 * @version V1.0
 */
public class ContextFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String path = request.getServletContext().getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + path;
        request.setAttribute("ctx", basePath);

        if (request instanceof HttpServletRequest) {
            final HttpServletRequest httpServletRequest = (HttpServletRequest) request;
            HttpSession session = httpServletRequest.getSession();
            Optional<User> user = Optional.ofNullable((User) session.getAttribute(User.ATTRIBUTE));
            final String route = httpServletRequest.getServletPath();

            // 不处理静态资源
            if (!UrlHelper.isStaticResourceRequest(route)) {
                if (!user.isPresent()) {
                    if (!UrlHelper.isLoginRequest(route)) {
                        // 如果是ajax请求
                        if (UrlHelper.isAjaxRequest(route)) {
                            ((HttpServletResponse) response).sendError(HttpServletResponse.SC_UNAUTHORIZED, "请先登录");
                        } else {
                            String location = httpServletRequest.getContextPath() + UrlHelper.loginPath;
                            if ("GET".equalsIgnoreCase(((HttpServletRequest) request).getMethod())) {
                                location += "?url=" + URLEncoder.encode(route, "utf-8");
                            }

                            ((HttpServletResponse) response).sendRedirect(location);
                        }
                        return;
                    }
                } else {
                    user.get().getSidebar().active(route);
                }

            }

        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }

    private static class UrlHelper {

        private static final String loginPath = "/login";

        private static final String logoutPath = "/logout";

        private static final String ajaxPath = "/ajax/";

        private static final List<String> staticPaths = ImmutableList
                .of("/css/", "/js/", "/img/", "/component/", "/api/");

        private static boolean isStaticResourceRequest(String path) {
            return staticPaths.stream().anyMatch(path::startsWith) || path.equals("/monitor.jsp");
        }

        private static boolean isAjaxRequest(String path) {
            return path.contains(ajaxPath);
        }

        /**
         * @param path 访问的路径
         *             http://localhost:8080/mr/test ==> /test
         * @return 是否是登录页面或者登出
         */
        private static boolean isLoginRequest(String path) {
            return path.equals(loginPath) || path.equals(logoutPath);
        }
    }

}
