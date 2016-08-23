package com.web.framework.service;

import com.web.framework.entity.LogEntity;

import java.util.List;

/**
 * ClassName: LogService
 * Description:
 * Date: 2016/8/20 20:29
 *
 * @author SAM SHO
 * @version V1.0
 */
public interface LogService {
    void save(List<LogEntity> entities);

    Object getList();
}
