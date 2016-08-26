package com.web.framework.utils;


import com.web.framework.bean.base.Sidebar;
import com.web.framework.bean.base.SidebarItem;
import com.google.common.collect.Lists;

import java.util.List;

public class SidebarUtil {
    public static Sidebar getSideBar() {
        Sidebar sidebar = new Sidebar();

        List<SidebarItem> items = Lists.newArrayList();
        items.add(new SidebarItem("首页", "/", "fa-crosshairs"));

        SidebarItem tableManager = new SidebarItem("表格", "/table", "fa-info");
        tableManager.addChild(new SidebarItem("数据表格", "/table/dataTable", "fa-mars-stroke-h"));
        tableManager.addChild(new SidebarItem("JP表格", "/table/jpTable", "fa-mars-stroke-h"));
        items.add(tableManager);

        SidebarItem formManager = new SidebarItem("表单", "/form", "fa-tasks");
        formManager.addChild(new SidebarItem("基础表单", "/form/baseForm", "fa-mars-stroke-h"));
        formManager.addChild(new SidebarItem("校验表单", "/form/validatorForm", "fa-mars-stroke-h"));
        formManager.addChild(new SidebarItem("文件上传", "/form/validatorForm", "fa-mars-stroke-h"));
        formManager.addChild(new SidebarItem("编辑器", "/form/validatorForm", "fa-mars-stroke-h"));
        formManager.addChild(new SidebarItem("日期选择", "/form/validatorForm", "fa-mars-stroke-h"));
        formManager.addChild(new SidebarItem("select2", "/form/select2", "fa-mars-stroke-h"));
        items.add(formManager);

        SidebarItem sysManager = new SidebarItem("系统管理", "/sys", "fa-gear");
        sysManager.addChild(new SidebarItem("用户管理", "/user/list", "fa-mars-stroke-h"));
        sysManager.addChild(new SidebarItem("资源管理", "/resource/resourceList", "fa-mars-stroke-h"));

        items.add(sysManager);

/*

        SidebarItem messageManager = new SidebarItem("短信管理", "/sms", "fa-envelope-o");
        items.add(messageManager);

        SidebarItem demandManager = new SidebarItem("需求管理", "/demand", "fa-ship");
        demandManager.addChild(new SidebarItem("需求列表","/demand/list","fa-paw"));
        items.add(demandManager);

        SidebarItem dataStatisticManager = new SidebarItem("数据统计", "/data", "fa-bar-chart");
        items.add(dataStatisticManager);

        SidebarItem settingsManager = new SidebarItem("配置管理", "/settings", "fa-cogs");
        items.add(settingsManager);*/

        sidebar.setItems(items);

        return sidebar;
    }

}
