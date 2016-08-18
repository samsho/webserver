package com.web.framework.log;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * ClassName: MethodAnnotation
 * Description:
 * Date: 2016/4/7 17:53
 *
 * @author ymh09658
 * @version V1.0
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface MethodAnnotation {
    MethodType type();

    String desc();

    enum MethodType {
        CREATE("新增"), READ("访问"), UPDATE("修改"), DELETE("删除");
        private String desc;

        MethodType(String desc) {
            this.desc = desc;
        }

        String getDesc() {
            return desc;
        }
    }

}


