package com.web.framework.service.impl;

import com.web.framework.dao.BaseDao;
import com.web.framework.entity.LogEntity;
import com.web.framework.service.LogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * ClassName: LogServiceImpl
 * Description:
 * Date: 2016/5/13 23:12
 *
 * @author SAM SHO
 * @version V1.0
 */
@Service(value = "logService")
public class LogServiceImpl extends AbstractServiceImpl<LogEntity> implements LogService {


    @Resource
    private BaseDao<LogEntity> baseDao;

    @Override
    public BaseDao<LogEntity> getDAO() {
        return baseDao;
    }
}
