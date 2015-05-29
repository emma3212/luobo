package com.luobo.common.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * 博曼权限安全组枚举
 *
 * @author: yusheng
 * @time: 2014/9/01 15:07
 */
public enum UserGroupEnums {

    Admin(1, "管理员"),
    Member(2, "会员"),
    ;

    private Integer id;
    private String desc;

    UserGroupEnums(Integer id, String desc) {
        this.id = id;
        this.desc = desc;
    }

    public Integer getId() {
        return id;
    }

    public String getDesc() {
        return desc;
    }

    private static Map<Integer, UserGroupEnums> idMap = new HashMap<Integer, UserGroupEnums>();

    static {
        for (UserGroupEnums enums : UserGroupEnums.values()) {
            idMap.put(enums.getId(), enums);
        }
    }

    /**
     * getDesc()查找描述
     *
     * @param id
     * @return
     */
    public static UserGroupEnums valueOf(Integer id) {
        return idMap.get(id);
    }

    public static Map<Integer, UserGroupEnums> getIdMap() {
        return idMap;
    }
}
