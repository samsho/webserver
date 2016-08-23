package com.web.framework.service;

import com.web.framework.bean.base.User;

import java.util.List;

/**
 * ClassName: UserService
 * Description:
 * Date: 2016/8/21 9:25
 *
 * @author SAM SHO
 * @version V1.0
 */
public interface UserService {
    List<User> getList();

    void save(User user);
}
