package com.rwkj.jc.domain;

import java.util.Date;

public class TestForMessage {
    private String id;

    private String planId;

    private String relationId;

    private Boolean isuse;

    private Date createtime;
    
    private Plan plan;
    
    private Relation relation;

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

    public String getRelationId() {
        return relationId;
    }

    public void setRelationId(String relationId) {
        this.relationId = relationId == null ? null : relationId.trim();
    }

    public Boolean getIsuse() {
        return isuse;
    }

    public void setIsuse(Boolean isuse) {
        this.isuse = isuse;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

	public Plan getPlan() {
		return plan;
	}

	public void setPlan(Plan plan) {
		this.plan = plan;
	}

	public Relation getRelation() {
		return relation;
	}

	public void setRelation(Relation relation) {
		this.relation = relation;
	}
}