package com.rwkj.jc.domain;

import java.util.Date;

public class Relation {
    private String id;

    private String planId;

    private String testperson;

    private String betestedperson;

    private Boolean isfinish;

    private String paperId;

    private Date createtime;

    private Boolean status;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId == null ? null : planId.trim();
    }

    public String getTestperson() {
        return testperson;
    }

    public void setTestperson(String testperson) {
        this.testperson = testperson == null ? null : testperson.trim();
    }

    public String getBetestedperson() {
        return betestedperson;
    }

    public void setBetestedperson(String betestedperson) {
        this.betestedperson = betestedperson == null ? null : betestedperson.trim();
    }

    public Boolean getIsfinish() {
        return isfinish;
    }

    public void setIsfinish(Boolean isfinish) {
        this.isfinish = isfinish;
    }

    public String getPaperId() {
        return paperId;
    }

    public void setPaperId(String paperId) {
        this.paperId = paperId == null ? null : paperId.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
}