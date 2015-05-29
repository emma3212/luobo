package com.luobo.common.annotation;

import java.lang.annotation.*;

/**
 * 忽略权限注解
 * 加上这个注解后，拦截器不会对其进行拦截。注解支持类和方法的注解，其中类的优先级别高于方法级别
 * Created by lionel 2014/12/17.
 */
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface IgnoreAuthorization {
	String value() default "";
}
