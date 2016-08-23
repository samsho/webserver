package com.web.framework.dao;

import com.web.framework.entity.LogEntity;
import org.apache.ibatis.annotations.Insert;
import org.springframework.stereotype.Repository;

/**
 * ClassName: ILogMapper
 * Description:
 * Date: 2016/8/20 20:27
 *
 * @author SAM SHO
 * @version V1.0
 */
@Repository
public interface ILogMapper {

    @Insert("INSERT INTO boot_log(username,jobName,action,args,exception,url,ip,createTime) " +
            " VALUES(#{userName},#{jobName},#{action},#{args},#{exception},#{url},#{ip},#{createTime})")
    void save(LogEntity log);

}



















