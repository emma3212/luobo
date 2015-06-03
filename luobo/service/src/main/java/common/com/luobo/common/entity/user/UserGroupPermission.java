package com.luobo.common.entity.user;

import com.pandawork.core.entity.AbstractEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * 用户组权限关联表
 *
 * Created by yusheng on 2014/12/15.
 */
@Entity
@Table(name = "t_user_group_permission")
public class UserGroupPermission extends AbstractEntity {

    @Id
    private Integer id ;

    // 名称
    @Column(name = "group_id")
    private Integer groupId;

    // 描述
    @Column(name = "permission_id")
    private Integer permissionId;

    // 权限生效开始时间
    @Column(name="from_time")
    private Date fromTime;

    // 实现时间
    @Column(name = "thru_time")
    private Date thruTime;

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

    public Date getCreatedTime() {
        return createdTime;
    }

    public Date getLastModifiedTime() {
        return lastModifiedTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public void setLastModifiedTime(Date lastModifiedTime) {
        this.lastModifiedTime = lastModifiedTime;
    }

	public Integer getGroupId() {
		return groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public Integer getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(Integer permissionId) {
		this.permissionId = permissionId;
	}

    public Date getFromTime() {
        return fromTime;
    }

    public void setFromTime(Date fromTime) {
        this.fromTime = fromTime;
    }

    public Date getThruTime() {
        return thruTime;
    }

    public void setThruTime(Date thruTime) {
        this.thruTime = thruTime;
    }
}
