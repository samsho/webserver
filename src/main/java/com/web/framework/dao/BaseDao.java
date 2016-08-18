
package com.web.framework.dao;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;

import java.util.List;
import java.util.Map;

/**
 * ClassName: BaseDao
 * Description:  数据访问层基类
 * date: 2015年4月30日 上午10:20:17
 *
 * @author sam sho
 * @version V1.0
 * @since JDK 1.7
 */
public interface BaseDao<T> {

    T get(int id);

    T update(T t);

    List<T> getList(int start, int count, List<Criterion> conditions, List<Order> orders);

    int getTotalCount(List<Criterion> conditions);

    void save(T t);

    void save(List<T> lists);

    void delete(T t);

    void saveOrUpdate(T t);

    List<T> findByProperty(String propertyName, Object value);

    T findUniqueByProperty(String propertyName, Object value);
}
