package com.rwkj.jc.domain;

public class PaperDetail {
    private String id;

    private String paperId;

    private Integer questionno;
    
    private String question;

    private String optiona;

    private Short optionascore;

    private String optionb;

    private Short optionbscore;

    private String optionc;

    private Short optioncscore;

    private String optiond;

    private Short optiondscore;

    private String optione;

    private Short optionescore;

    private String optionf;

    private Short optionfscore;

    private Boolean issuggest;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getPaperId() {
        return paperId;
    }

    public void setPaperId(String paperId) {
        this.paperId = paperId == null ? null : paperId.trim();
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question == null ? null : question.trim();
    }
    
    public Integer getQuestionno() {
        return questionno;
    }

    public void setQuestionno(Integer questionno) {
        this.questionno = questionno;
    }

    public String getOptiona() {
        return optiona;
    }

    public void setOptiona(String optiona) {
        this.optiona = optiona == null ? null : optiona.trim();
    }

    public Short getOptionascore() {
        return optionascore;
    }

    public void setOptionascore(Short optionascore) {
        this.optionascore = optionascore;
    }

    public String getOptionb() {
        return optionb;
    }

    public void setOptionb(String optionb) {
        this.optionb = optionb == null ? null : optionb.trim();
    }

    public Short getOptionbscore() {
        return optionbscore;
    }

    public void setOptionbscore(Short optionbscore) {
        this.optionbscore = optionbscore;
    }

    public String getOptionc() {
        return optionc;
    }

    public void setOptionc(String optionc) {
        this.optionc = optionc == null ? null : optionc.trim();
    }

    public Short getOptioncscore() {
        return optioncscore;
    }

    public void setOptioncscore(Short optioncscore) {
        this.optioncscore = optioncscore;
    }

    public String getOptiond() {
        return optiond;
    }

    public void setOptiond(String optiond) {
        this.optiond = optiond == null ? null : optiond.trim();
    }

    public Short getOptiondscore() {
        return optiondscore;
    }

    public void setOptiondscore(Short optiondscore) {
        this.optiondscore = optiondscore;
    }

    public String getOptione() {
        return optione;
    }

    public void setOptione(String optione) {
        this.optione = optione == null ? null : optione.trim();
    }

    public Short getOptionescore() {
        return optionescore;
    }

    public void setOptionescore(Short optionescore) {
        this.optionescore = optionescore;
    }

    public String getOptionf() {
        return optionf;
    }

    public void setOptionf(String optionf) {
        this.optionf = optionf == null ? null : optionf.trim();
    }

    public Short getOptionfscore() {
        return optionfscore;
    }

    public void setOptionfscore(Short optionfscore) {
        this.optionfscore = optionfscore;
    }

    public Boolean getIssuggest() {
        return issuggest;
    }

    public void setIssuggest(Boolean issuggest) {
        this.issuggest = issuggest;
    }
}