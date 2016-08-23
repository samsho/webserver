package com.web.framework.controller.table;

import com.web.framework.controller.base.BaseController;
import com.web.framework.entity.LogEntity;
import com.web.framework.log.MethodAnnotation;
import com.web.framework.utils.JsonUtil;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * ClassName: TableController
 * Description:
 * Date: 2016/5/14 13:12
 *
 * @author SAM SHO
 * @version V1.0
 */
@Controller
@RequestMapping(value = "/table")
public class TableController extends BaseController {

    private final Logger logger = Logger.getLogger(this.getClass());

    @MethodAnnotation(type = MethodAnnotation.MethodType.READ, desc = "dataTable")
    @RequestMapping(value = "/dataTable")
    public String dataTable(ModelMap map) {
//        map.addAttribute("logs", logService.getList());
        logger.info("++++++++++  日志  ++++++++");
        return "/table/dataTable";
    }





}
