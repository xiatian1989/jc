package com.rwkj.jc.domain;

import java.util.Date;

public class Plan {
    private String id;

    private String plantitle;

    private Date begintime;

    private Date endtime;

    private Boolean isfinish;

    private Boolean isstart;

    private Date createtime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getPlantitle() {
        return plantitle;
    }

    public void setPlantitle(String plantitle) {
        this.plantitle = plantitle == null ? null : plantitle.trim();
    }

    public Date getBegintime() {
        return begintime;
    }

    public void setBegintime(Date begintime) {
        this.begintime = begintime;
    }

    public Date getEndtime() {
        return endtime;
    }

    public void setEndtime(Date endtime) {
        this.endtime = endtime;
    }

    public Boolean getIsfinish() {
        return isfinish;
    }

    public void setIsfinish(Boolean isfinish) {
        this.isfinish = isfinish;
    }

    public Boolean getIsstart() {
        return isstart;
    }

    public void setIsstart(Boolean isstart) {
        this.isstart = isstart;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }
}