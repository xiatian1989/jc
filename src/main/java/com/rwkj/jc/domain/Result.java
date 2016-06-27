package com.rwkj.jc.domain;

import java.util.Date;

public class Result {
    private String id;

    private String relationId;

    private Integer aproportion;

    private Integer bproportion;

    private Integer cproportion;

    private Integer dproportion;

    private Integer eproportion;

    private Integer fproportion;

    private Integer answerproportion;

    private String resultmessage;

    private Date createtime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getRelationId() {
        return relationId;
    }

    public void setRelationId(String relationId) {
        this.relationId = relationId == null ? null : relationId.trim();
    }

    public Integer getAproportion() {
        return aproportion;
    }

    public void setAproportion(Integer aproportion) {
        this.aproportion = aproportion;
    }

    public Integer getBproportion() {
        return bproportion;
    }

    public void setBproportion(Integer bproportion) {
        this.bproportion = bproportion;
    }

    public Integer getCproportion() {
        return cproportion;
    }

    public void setCproportion(Integer cproportion) {
        this.cproportion = cproportion;
    }

    public Integer getDproportion() {
        return dproportion;
    }

    public void setDproportion(Integer dproportion) {
        this.dproportion = dproportion;
    }

    public Integer getEproportion() {
        return eproportion;
    }

    public void setEproportion(Integer eproportion) {
        this.eproportion = eproportion;
    }

    public Integer getFproportion() {
        return fproportion;
    }

    public void setFproportion(Integer fproportion) {
        this.fproportion = fproportion;
    }

    public Integer getAnswerproportion() {
        return answerproportion;
    }

    public void setAnswerproportion(Integer answerproportion) {
        this.answerproportion = answerproportion;
    }

    public String getResultmessage() {
        return resultmessage;
    }

    public void setResultmessage(String resultmessage) {
        this.resultmessage = resultmessage == null ? null : resultmessage.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }
}