package com.web.framework.service.impl;

import com.web.framework.dao.ILogMapper;
import com.web.framework.service.LogService;
import com.web.framework.entity.LogEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * ClassName: LogService
 * Description:
 * Date: 2016/8/20 20:29
 *
 * @author SAM SHO
 * @version V1.0
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class LogServiceImpl implements LogService {

    @Resource
    private ILogMapper logMapper;

    @Override
    public void save(List<LogEntity> entities) {
        for (LogEntity log : entities) {
            logMapper.save(log);
        }
    }

    @Override
    public Object getList() {
        return null;
    }
}
