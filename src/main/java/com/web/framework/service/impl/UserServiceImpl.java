package com.web.framework.service.impl;

import com.web.framework.bean.base.User;
import com.web.framework.dao.IUserMapper;
import com.web.framework.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * ClassName: UserServiceImpl
 * Description:
 * Date: 2016/8/21 9:25
 *
 * @author SAM SHO
 * @version V1.0
 */
@Service
public class UserServiceImpl implements UserService {

    @Resource
    private IUserMapper userMapper;

    @Override
    public List<User> getList() {
        return userMapper.getList();
    }

    @Override
    public void save(User user) {
        userMapper.save(user);
    }
}
