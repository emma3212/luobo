package com.luobo.common.enums.upload;

/**
 * 文件上传之后的存放位置枚举
 * 方便统一管理
 *
 * @author: zhangteng
 * @time: 2014/8/26 8:56
 */
public enum FileUploadFolderEnums {

    FriendlylinkFolder("友情链接logo存放文件夹", "friendly/link/logo/"),


    ;


    // 描述
    private String description;
    // 存放位置
    private String value;

    FileUploadFolderEnums(String description, String value) {
        this.description = description;
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
