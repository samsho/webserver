package com.web.framework.bean.base;

import com.google.common.base.Preconditions;

import java.util.Objects;

public class User {
    public final static String ATTRIBUTE = "__USER__";

    private int id;
    private String username;
    private String password;
    private String jobNumber;
    private String email;
    private String mobile;

    private Sidebar sidebar;

    public User() {
    }

    public User(int id, String username, String jobNumber) {
        this.id = id;
        this.username = username;
        this.jobNumber = jobNumber;
    }

    public User(int id, String jobNumber, String username, String email, String mobile) {
        this.id = id;
        this.username = username;
        this.jobNumber = jobNumber;
        this.email = email;
        this.mobile = mobile;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getJobNumber() {
        return jobNumber;
    }

    public void setJobNumber(String jobNumber) {
        this.jobNumber = jobNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Sidebar getSidebar() {
        if (sidebar == null) {
            sidebar = new Sidebar();
        }
        return sidebar;
    }

    public void setSidebar(Sidebar sidebar) {
        this.sidebar = sidebar;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;
        User user = (User) o;
        return id == user.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }


    public User build() {
        Preconditions.checkArgument(id >= 0, "ID必须是正数");
        Preconditions.checkNotNull(jobNumber, "工号不能为空");
        return new User(id, jobNumber, username, email, mobile);
    }
}
