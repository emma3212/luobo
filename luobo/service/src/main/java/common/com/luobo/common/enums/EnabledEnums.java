package com.luobo.common.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * 定义可用和不可用的枚举
 *
 * Created by yusheng on 2014/12/15.
 */
public enum EnabledEnums {

    Enabled(1, "可用"),
    Disabled(0, "不可用")
    ;

    private Integer id;
    private String desc;

    EnabledEnums(Integer id, String desc) {
        this.id = id;
        this.desc = desc;
    }



    private static Map<Integer, EnabledEnums> map = new HashMap<Integer, EnabledEnums>();

    static{
        for(EnabledEnums statusType : EnabledEnums.values()){
            map.put(statusType.getId(), statusType);
        }
    }

    public static Map<Integer, EnabledEnums> getMap() {
        return EnabledEnums.map;
    }

    public Integer getId() {
        return id;
    }

    public String getDes() {
        return desc;
    }

    /**
     *  获取值，当ID不能找到的时候，直接默认为null.
     * @param id
     * @return
     */
    public static EnabledEnums valueOf(int id) {
        return valueOf(id, null);
    }

    public static EnabledEnums valueOf(int id, EnabledEnums defaultValue) {
        EnabledEnums status = map.get(id);

        return status == null? defaultValue: status;
    }
}
