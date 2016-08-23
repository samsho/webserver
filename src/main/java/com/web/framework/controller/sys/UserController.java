package com.web.framework.controller.sys;

import com.web.framework.bean.base.User;
import com.web.framework.controller.base.BaseController;
import com.web.framework.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import javax.annotation.Resource;

/**
 * ClassName: UserController
 * Description:
 * Date: 2016/8/21 9:20
 *
 * @author SAM SHO
 * @version V1.0
 */
@Controller
@RequestMapping(value = "user")
public class UserController extends BaseController {

    @Resource
    private UserService userService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String userList(ModelMap map) {
        map.addAttribute("users", userService.getList());
        return "sys/userList";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String save(RedirectAttributesModelMap map, User user) {
        userService.save(user);
        map.addFlashAttribute("success", "新增成功");
        return "redirect:list";

    }

}
