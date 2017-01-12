package com.rwkj.jc.domain;

import java.util.Date;

public class Result {
    private String id;

    private String relationId;

    private Integer answerproportion;

    private String resultmessage;

    private String extrameassge;

    private Integer score;

    private Boolean status;

    private Date createtime;
    
    private Relation relation;

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

    public String getExtrameassge() {
        return extrameassge;
    }

    public void setExtrameassge(String extrameassge) {
        this.extrameassge = extrameassge == null ? null : extrameassge.trim();
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

	public Relation getRelation() {
		return relation;
	}

	public void setRelation(Relation relation) {
		this.relation = relation;
	}
}