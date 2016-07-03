package com.rwkj.jc.domain;

import java.util.Date;

public class Templet {
    private String id;

    private String templettitle;

    private String keyword;

    private String description;

    private Date createtime;

    private Date updattime;

    private String tablename;

    private Boolean status;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getTemplettitle() {
        return templettitle;
    }

    public void setTemplettitle(String templettitle) {
        this.templettitle = templettitle == null ? null : templettitle.trim();
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword == null ? null : keyword.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Date getUpdattime() {
        return updattime;
    }

    public void setUpdattime(Date updattime) {
        this.updattime = updattime;
    }

    public String getTablename() {
        return tablename;
    }

    public void setTablename(String tablename) {
        this.tablename = tablename == null ? null : tablename.trim();
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
}