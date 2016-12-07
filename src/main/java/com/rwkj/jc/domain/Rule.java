package com.rwkj.jc.domain;

public class Rule {
	
    private String id;

    private Integer level1;

    private Integer level2;

    private Integer level3;

    private Integer level4;

    private Integer level5;

    private Integer level6;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Integer getLevel1() {
        return level1;
    }

    public void setLevel1(Integer level1) {
        this.level1 = level1;
    }

    public Integer getLevel2() {
        return level2;
    }

    public void setLevel2(Integer level2) {
        this.level2 = level2;
    }

    public Integer getLevel3() {
        return level3;
    }

    public void setLevel3(Integer level3) {
        this.level3 = level3;
    }

    public Integer getLevel4() {
        return level4;
    }

    public void setLevel4(Integer level4) {
        this.level4 = level4;
    }

    public Integer getLevel5() {
        return level5;
    }

    public void setLevel5(Integer level5) {
        this.level5 = level5;
    }

    public Integer getLevel6() {
        return level6;
    }

    public void setLevel6(Integer level6) {
        this.level6 = level6;
    }
}