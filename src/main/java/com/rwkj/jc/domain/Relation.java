package com.rwkj.jc.domain;

import java.util.Date;

public class Relation {
    private String id;

    private String planId;

    private String testperson;

    private String betestedobject;

    private Boolean isperson;

    private Boolean isfinish;

    private String paperId;

    private String ruleId;

    private Boolean issupportsms;

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

    public String getBetestedobject() {
        return betestedobject;
    }

    public void setBetestedobject(String betestedobject) {
        this.betestedobject = betestedobject == null ? null : betestedobject.trim();
    }

    public Boolean getIsperson() {
        return isperson;
    }

    public void setIsperson(Boolean isperson) {
        this.isperson = isperson;
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

    public String getRuleId() {
        return ruleId;
    }

    public void setRuleId(String ruleId) {
        this.ruleId = ruleId == null ? null : ruleId.trim();
    }

    public Boolean getIssupportsms() {
        return issupportsms;
    }

    public void setIssupportsms(Boolean issupportsms) {
        this.issupportsms = issupportsms;
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