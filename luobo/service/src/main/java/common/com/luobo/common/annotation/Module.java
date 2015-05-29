package com.luobo.common.annotation;

import com.luobo.common.enums.ModuleEnums;

import java.lang.annotation.*;

/**
 * 模块声明标签
 * Created by Lionel on 2014/6/5.
 */
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Module {
    ModuleEnums value() default ModuleEnums.Null;
}
