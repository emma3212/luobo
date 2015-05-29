package com.luobo.common.enums.upload;

/**
 * 文件上传类型选择
 *
 * @author: zhangteng
 * @time: 2014/8/26 9:13
 */
public enum FileUploadUrlTypeEnums {

    // 直接上传,上传之后地址进行md5加密
    Upload("/up/upload"),
    // 直接拷贝
    Cp("/up/upload/cp"),
    // 把文件列出来
    List("/up/list");

    private String path;

    FileUploadUrlTypeEnums(String path) {
        this.path = path;
    }

    public String getPath() {
        return path;
    }
}
