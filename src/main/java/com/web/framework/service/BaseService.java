
package com.web.framework.service;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;

import java.util.List;

/**
 * ClassName: BaseService
 * Description: 业务操作层基类
 * date: 2015-3-9 下午7:26:30
 *
 * @author sam sho
 * @version V1.0
 * @since JDK 1.7
 */
public interface BaseService<T> {
    List<T> getList(int start, int count, List<Criterion> conditions, List<Order> orders);

    int getTotalCount(List<Criterion> conditions);

    void save(T t);

    void save(List<T> lists);

    T get(int id);

    T update(T t);

    void delete(T t);

    List<T> findByProperty(String propertyName, Object value);

    T findUniqueByProperty(String propertyName, Object value);

    boolean isExist(String propertyName, Object value);

    String getUUID();
}
