package com.rwkj.jc.domain;

public class Rule {
    private String id;

    private Integer first;

    private String firstname;

    private Integer second;

    private String secondname;

    private Integer third;

    private String thirdname;

    private Integer forth;

    private String forthname;

    private Integer fifth;

    private String fifthname;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Integer getFirst() {
        return first;
    }

    public void setFirst(Integer first) {
        this.first = first;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname == null ? null : firstname.trim();
    }

    public Integer getSecond() {
        return second;
    }

    public void setSecond(Integer second) {
        this.second = second;
    }

    public String getSecondname() {
        return secondname;
    }

    public void setSecondname(String secondname) {
        this.secondname = secondname == null ? null : secondname.trim();
    }

    public Integer getThird() {
        return third;
    }

    public void setThird(Integer third) {
        this.third = third;
    }

    public String getThirdname() {
        return thirdname;
    }

    public void setThirdname(String thirdname) {
        this.thirdname = thirdname == null ? null : thirdname.trim();
    }

    public Integer getForth() {
        return forth;
    }

    public void setForth(Integer forth) {
        this.forth = forth;
    }

    public String getForthname() {
        return forthname;
    }

    public void setForthname(String forthname) {
        this.forthname = forthname == null ? null : forthname.trim();
    }

    public Integer getFifth() {
        return fifth;
    }

    public void setFifth(Integer fifth) {
        this.fifth = fifth;
    }

    public String getFifthname() {
        return fifthname;
    }

    public void setFifthname(String fifthname) {
        this.fifthname = fifthname == null ? null : fifthname.trim();
    }
}