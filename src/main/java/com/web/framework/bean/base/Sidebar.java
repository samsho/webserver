package com.web.framework.bean.base;

import com.google.common.collect.Lists;

import java.util.Collection;
import java.util.List;
import java.util.Objects;


public class Sidebar {

    private List<SidebarItem> items;

    public List<SidebarItem> getItems() {
        return items;
    }

    public void setItems(List<SidebarItem> items) {
        this.items = items;
    }

    public void active(String url) {
        if (items == null) {
            return;
        }

        for (SidebarItem item : items) {
            boolean found = false;
            if (item.getChildren() != null) {
                for (SidebarItem sec : item.getChildren()) {
                    boolean secFound = false;
                    if (sec.getChildren() != null) {
                        for (SidebarItem third : sec.getChildren()) {
                            if (Objects.equals(third.getUrl(), url)) {
                                secFound = true;
                                third.setActive(true);
                            } else {
                                third.setActive(false);
                            }
                        }
                    }
                    if (Objects.equals(sec.getUrl(), url) || secFound) {
                        found = secFound = true;
                    }
                    sec.setActive(secFound);
                }
            }
            if (Objects.equals(item.getUrl(), url) || found) {
                found = true;
            }
            item.setActive(found);
        }

    }

    public void addItems(Collection<SidebarItem> sidebarItems) {
        if (this.items == null) {
            this.items = Lists.newArrayList();
        }
        this.items.addAll(sidebarItems);
    }

}
