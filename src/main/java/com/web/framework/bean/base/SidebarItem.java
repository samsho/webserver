package com.web.framework.bean.base;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Lists;

import java.io.Serializable;
import java.util.List;

public class SidebarItem implements Serializable {
    private String url;
    private List<SidebarItem> children;
    private String title;
    private boolean displayCount;
    private boolean isActive;

    private boolean visible = false;
    private String icon;

    public SidebarItem(String title) {
        this(title, "#");
    }

    public SidebarItem(String title, String url) {
        this(title, url, "fa-caret-right");
    }

    public SidebarItem(String title, String url, String icon) {
        this.icon = icon;
        this.title = title;
        this.url = url;
        this.isActive = false;
    }

    public boolean isVisible() {
        for (SidebarItem sidebarItem : getChildren()) {
            if (sidebarItem.isVisible()) {
                return true;
            }
        }
        return visible;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    public boolean isDisplayCount() {
        return displayCount;
    }

    public void setDisplayCount(boolean displayCount) {
        this.displayCount = displayCount;
    }

    public List<SidebarItem> getChildren() {
        if (children == null) {
            children = ImmutableList.of();
        }
        return children;
    }

    public void setChildren(List<SidebarItem> children) {
        this.children = children;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public void addChild(SidebarItem sidebarItem) {
        if (this.children == null) {
            this.children = Lists.newArrayList();
        }
        children.add(sidebarItem);
    }
}
