package com.rwkj.jc.bean;

public class planStatusBean {
	
	private boolean isPerson;
	private String betestedObejct;
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
}
