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
        map.addAttribute("logs", logService.getList(-1, -1, null, null));
        logger.info("++++++++++  日志  ++++++++");
        return "/table/dataTable";
    }

    /**
     * datatables 后台分页
     * @param draw
     * @param start
     * @param length
     * @param out
     */
    @RequestMapping(value = "/ajax/dataTable")
    public void dataTable(int draw, int start, int length,PrintWriter out) {

        int recordsTotal = logService.getTotalCount(null);//总数
        List<LogEntity> list = logService.getList(start, length, null, null);
        String data = "";
        try {
            data = JsonUtil.toJson(list);
        } catch (IOException e) {
            logger.error("数据失败");
        }

        String result = "{\"draw\":"+ draw + ",\"recordsTotal\": "+ recordsTotal
                +",\"recordsFiltered\": "+recordsTotal +",\"data\": "+ data +"}";

        logger.info(result);
        out.write(result);
    }

    @MethodAnnotation(type = MethodAnnotation.MethodType.READ, desc = "jpTable")
    @RequestMapping(value = "/jpTable")
    public String jpTable(ModelMap map) {
        map.addAttribute("logs", logService.getList(-1, -1, null, null));
        logger.info("++++++++++  日志  ++++++++");
        return "/table/dataTable";
    }


}
