package com.luobo.common.entity.user;

import com.pandawork.core.entity.AbstractEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * 用户实体表
 *
 * Created by yusheng on 2014/12/15.
 */
@Entity
@Table(name = "t_user")
public class User extends AbstractEntity {
    @Id
    private Integer id ;

    //用户姓名
    private String name;

    //登陆名称
    @Column(name = "login_name")
    private String loginName;

    //密码
    private String pwd;

    //权限组
    @Column(name="group_id")
    private Integer groupId;

    // 用户状态，详见EnabledEnums
    private Integer enabled;

    // 1表示必须修改密码，0，表示不需要修改密码。
    @Column(name="update_pwd")
    private Integer updatePwd;

    // 失效时间
    @Column(name = "trust_time")
    private Date trustTime;

    // 创建时间
    @Column(name = "created_time")
    private Date createdTime;

    // 最近修改时间
    @Column(name = "last_modified_time")
    private Date lastModifiedTime;

    public Integer getId() {
        return id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public Integer getEnabled() {
        return enabled;
    }

    public void setEnabled(Integer enabled) {
        this.enabled = enabled;
    }

    public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public Integer getUpdatePwd() {
        return updatePwd;
    }

    public void setUpdatePwd(Integer updatePwd) {
        this.updatePwd = updatePwd;
    }

    public Date getTrustTime() {
        return trustTime;
    }

    public void setTrustTime(Date trustTime) {
        this.trustTime = trustTime;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public Date getLastModifiedTime() {
        return lastModifiedTime;
    }

    public void setLastModifiedTime(Date lastModifiedTime) {
        this.lastModifiedTime = lastModifiedTime;
    }
}
