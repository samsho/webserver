package com.web.framework.controller.form;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * ClassName: FormController
 * Desc:
 * Date�� 2016/8/26
 * Created��shaom
 */
@Controller
@RequestMapping("form")
public class FormController {

    @RequestMapping("select2")
    public String select2() {
        return "form/select2";
    }



}
