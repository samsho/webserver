package com.web.framework.controller.login;

import com.web.framework.bean.base.User;
import com.web.framework.utils.SidebarUtil;
import com.google.common.base.Strings;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController {
    private final Logger logger = LoggerFactory.getLogger(LoginController.class);
    private final String redirectAttribute = "url";

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String renderLogin(HttpServletRequest request, ModelMap modelMap,
                              @RequestParam(value = redirectAttribute, required = false) String url) {
        if (isLogin(request)) {
            return "redirect:/";
        }

        modelMap.addAttribute(redirectAttribute, url);
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(RedirectAttributesModelMap map, HttpServletRequest request,
                        @RequestParam("username") String username, @RequestParam("password") String password,
                        @RequestParam(value = redirectAttribute, required = false) String url) {
        String error;
        try {
            User user = new User(16390,"12652","sam-sho");
            user.setSidebar(SidebarUtil.getSideBar());
            request.getSession().setAttribute(User.ATTRIBUTE, user);
            if (!Strings.isNullOrEmpty(url)) {
                if (!url.startsWith("/")) {
                    url = "/" + url;
                }
                return "redirect:" + url;
            } else {
                return "redirect:/";
            }
        } catch (Exception e) {
            logger.warn("登录失败", e);
            error = e.getMessage();
        }

        if (!Strings.isNullOrEmpty(url)) {
            map.addAttribute(redirectAttribute, url);
        }
        map.addFlashAttribute("error", error);

        return "redirect:/login";
    }

    @RequestMapping(value = "/logout")
    public String renderLogout(RedirectAttributesModelMap map, HttpServletRequest request) {
        request.getSession().removeAttribute(User.ATTRIBUTE);
        map.addFlashAttribute("error", "您已登出");
        return "redirect:/login";
    }

    private boolean isLogin(HttpServletRequest request) {
        return request.getSession().getAttribute(User.ATTRIBUTE) != null;
    }
}
