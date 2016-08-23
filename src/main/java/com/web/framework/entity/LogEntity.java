package com.web.framework.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * ClassName: LogEntity
 * Description:
 * Date: 2016/4/7 17:44
 *
 * @author sam-sho
 * @version V1.0
 */
public class LogEntity implements Serializable {

    private int id;
    private String username;
    private String jobName;
    private String action;
    private String args;
    private String exception;
    private String url;
    private String ip;
    private Date createTime = new Date();


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

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getArgs() {
        return args;
    }

    public void setArgs(String args) {
        this.args = args;
    }

    public String getException() {
        return exception;
    }

    public void setException(String exception) {
        this.exception = exception;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "LogEntity{" +
                "username='" + username + '\'' +
                ", jobName='" + jobName + '\'' +
                ", action='" + action + '\'' +
                ", args='" + args + '\'' +
                ", exception='" + exception + '\'' +
                ", url='" + url + '\'' +
                '}';
    }
}
