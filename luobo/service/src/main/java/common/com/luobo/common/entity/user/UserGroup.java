package com.luobo.common.entity.user;

import com.pandawork.core.entity.AbstractEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * 用户组实体表
 *
 * Created by yusheng on 2014/12/15.
 */
@Entity
@Table(name = "t_user_group")
public class UserGroup extends AbstractEntity {

    @Id
    private Integer id;

    // 名称
    private String name;

    // 描述
    private String desc;

    // 创建时间
    @Column(name = "created_time")
    private Date createdTime;

    // 最近修改时间
    @Column(name = "last_modified_time")
    private Date lastModifiedTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public String getDesc() {
        return desc;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public Date getLastModifiedTime() {
        return lastModifiedTime;
    }
    public void setName(String name) {
        this.name = name;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public void setLastModifiedTime(Date lastModifiedTime) {
        this.lastModifiedTime = lastModifiedTime;
    }
}
