
package com.web.framework.dao.impl;

import com.web.framework.dao.BaseDao;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import javax.annotation.Resource;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;


/**
 * ClassName: BaseDaoImpl
 * Description:  数据访问层基类
 * date: 2015年4月30日 上午10:23:13
 *
 * @author sam sho
 * @version V1.0
 * @since JDK 1.7
 */
@SuppressWarnings("unchecked")
public abstract class BaseDaoImpl<T> extends HibernateDaoSupport implements BaseDao<T> {

    private Class<T> clazz;

    public BaseDaoImpl() {
        ParameterizedType parameterizedType = (ParameterizedType) getClass().getGenericSuperclass();
        Type[] types = parameterizedType.getActualTypeArguments();
        clazz = (Class<T>) types[0];
    }

    @Resource(name = "sessionFactory")
    public void setSuperSessionFactory(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

    @Override
    public T get(int id) {
        return getHibernateTemplate().get(clazz, id);
    }

    @Override
    public T update(T t) {
        return getHibernateTemplate().merge(t);
    }

    @Override
    public List<T> getList(int start, int count, List<Criterion> conditions, List<Order> orders) {
        DetachedCriteria criteria = DetachedCriteria.forClass(clazz);
        if (conditions != null) {
            for (Criterion condition : conditions) {
                criteria.add(condition);
            }
        }
        if (orders != null) {
            for (Order order : orders) {
                criteria.addOrder(order);
            }
        }
        return (List<T>) getHibernateTemplate().findByCriteria(criteria, start, count);
    }

    @Override
    public int getTotalCount(List<Criterion> conditions) {
        DetachedCriteria criteria = DetachedCriteria.forClass(clazz);
        if (conditions != null) {
            for (Criterion condition : conditions) {
                criteria.add(condition);
            }
        }
        criteria.setProjection(Projections.rowCount());
        return ((Long) getHibernateTemplate().findByCriteria(criteria).listIterator().next()).intValue();
    }

    @Override
    public void save(T t) {
        getHibernateTemplate().save(t);
    }

    @Override
    public void save(List<T> lists) {
        for (T t : lists) {
            getHibernateTemplate().getSessionFactory().openStatelessSession().insert(t);
        }
    }

    @Override
    public void saveOrUpdate(T t) {
        getHibernateTemplate().saveOrUpdate(t);
    }

    @Override
    public void delete(T object) {
        getHibernateTemplate().delete(object);
    }

    @Override
    public List<T> findByProperty(String propertyName, Object value) {
        DetachedCriteria criteria = DetachedCriteria.forClass(clazz);
        criteria.add(Restrictions.eq(propertyName, value));
        return (List<T>) getHibernateTemplate().findByCriteria(criteria);
    }

    @Override
    public T findUniqueByProperty(String propertyName, Object value) {
        DetachedCriteria criteria = DetachedCriteria.forClass(clazz);
        criteria.add(Restrictions.eq(propertyName, value));
        List<T> list = (List<T>) getHibernateTemplate().findByCriteria(criteria);
        if (list == null || list.isEmpty()) {
            return null;
        }
        return list.get(0);
    }
}
