package com.rwkj.jc.domain;

import java.util.Date;

public class Relation {
    private String id;

    private String planId;

    private String testperson;

    private String betestedperson;

    private String betesteddepart;

    private Boolean isperson;

    private Boolean isfinish;

    private String paperId;

    private String ruleId;

    private Boolean issupportsms;

    private Date createtime;

    private Boolean status;
    
    private User testUser;
    
    private User beTestedUser;
    
    private Depart beTestedDepart;
    
    private Plan plan;
    
    private Paper paper;
    
    private Rule rule;

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

    public String getBetesteddepart() {
        return betesteddepart;
    }

    public void setBetesteddepart(String betesteddepart) {
        this.betesteddepart = betesteddepart == null ? null : betesteddepart.trim();
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

	public User getTestUser() {
		return testUser;
	}

	public void setTestUser(User testUser) {
		this.testUser = testUser;
	}

	public User getBeTestedUser() {
		return beTestedUser;
	}

	public void setBeTestedUser(User beTestedUser) {
		this.beTestedUser = beTestedUser;
	}

	public Depart getBeTestedDepart() {
		return beTestedDepart;
	}

	public void setBeTestedDepart(Depart beTestedDepart) {
		this.beTestedDepart = beTestedDepart;
	}

	public Plan getPlan() {
		return plan;
	}

	public void setPlan(Plan plan) {
		this.plan = plan;
	}

	public Paper getPaper() {
		return paper;
	}

	public void setPaper(Paper paper) {
		this.paper = paper;
	}

	public Rule getRule() {
		return rule;
	}

	public void setRule(Rule rule) {
		this.rule = rule;
	}
}