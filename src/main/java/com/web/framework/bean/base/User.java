package com.web.framework.bean.base;

import com.google.common.base.Preconditions;

import java.util.Objects;

public class User {
    public final static String ATTRIBUTE = "__USER__";

    private final long id;

    private final String jobNumber;

    private final String username;

    private String email;

    private Sidebar sidebar;

    private String mobile;

    public User(long id, String jobNumber, String username) {
        this.id = id;
        this.jobNumber = jobNumber;
        this.username = username;
    }

    public User(long id, String jobNumber, String username, String email, String mobile) {
        this.id = id;
        this.jobNumber = jobNumber;
        this.username = username;
        this.email = email;
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

    public long getId() {
        return id;
    }

    public String getJobNumber() {
        return jobNumber;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getMobile() {
        return mobile;
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

    public static class Builder {
        private long id;
        private String jobNumber;
        private String username;
        private String email;
        private String mobile;

        public Builder setId(long id) {
            this.id = id;
            return this;
        }

        public Builder setJobNumber(String jobNumber) {
            this.jobNumber = jobNumber;
            return this;
        }

        public Builder setUsername(String username) {
            this.username = username;
            return this;
        }

        public Builder setEmail(String email) {
            this.email = email;
            return this;
        }

        public Builder setMobile(String mobile) {
            this.mobile = mobile;
            return this;
        }

        public User build() {
            Preconditions.checkArgument(id >= 0, "ID必须是正数");
            Preconditions.checkNotNull(jobNumber, "工号不能为空");

            return new User(id, jobNumber, username, email, mobile);
        }
    }
}
