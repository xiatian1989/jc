package com.rwkj.jc.bean;


public class ResultBean {
	
    private String id = "0";
    
    private String planTitle;
    
    private String paperTitle;

    private String beTestedObject;

    private double score;

    private String result;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPlanTitle() {
		return planTitle;
	}

	public void setPlanTitle(String planTitle) {
		this.planTitle = planTitle;
	}

	public String getPaperTitle() {
		return paperTitle;
	}

	public void setPaperTitle(String paperTitle) {
		this.paperTitle = paperTitle;
	}

	public String getBeTestedObject() {
		return beTestedObject;
	}

	public void setBeTestedObject(String beTestedObject) {
		this.beTestedObject = beTestedObject;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
    
    

}