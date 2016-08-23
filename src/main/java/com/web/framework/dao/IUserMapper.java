package com.web.framework.dao;

import com.web.framework.bean.base.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * ClassName: IUserMapper
 * Description:
 * Date: 2016/8/20 21:26
 *
 * @author SAM SHO
 * @version V1.0
 */
@Repository
public interface IUserMapper {

    List<User> getList();

    int save(User user);

    int deleteById(int id);

    int update(User user);

    User getUserById(int id);


}
