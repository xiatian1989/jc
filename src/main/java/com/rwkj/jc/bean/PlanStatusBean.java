package com.rwkj.jc.bean;

public class PlanStatusBean {
	
	private boolean isPerson;
	private String betestedObejct;
	private String betestedObejctNo;
	private long totalRelation;
	private long validateRelation;
	private long noFinishRelation;
	
	public boolean isPerson() {
		return isPerson;
	}
	public void setPerson(boolean isPerson) {
		this.isPerson = isPerson;
	}
	public String getBetestedObejct() {
		return betestedObejct;
	}
	public void setBetestedObejct(String betestedObejct) {
		this.betestedObejct = betestedObejct;
	}
	public long getTotalRelation() {
		return totalRelation;
	}
	public void setTotalRelation(long totalRelation) {
		this.totalRelation = totalRelation;
	}
	public long getValidateRelation() {
		return validateRelation;
	}
	public void setValidateRelation(long validateRelation) {
		this.validateRelation = validateRelation;
	}
	public long getNoFinishRelation() {
		return noFinishRelation;
	}
	public void setNoFinishRelation(long noFinishRelation) {
		this.noFinishRelation = noFinishRelation;
	}
	public String getBetestedObejctNo() {
		return betestedObejctNo;
	}
	public void setBetestedObejctNo(String betestedObejctNo) {
		this.betestedObejctNo = betestedObejctNo;
	}
}
