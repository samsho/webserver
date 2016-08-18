/*
 * Project Name:TCYarn
 * File Name:AbstractServiceImpl
 * Package Name:com.ly.dc.tcyarn.manager.service.impl
 * Date:2015-3-9 下午7:29:30
 * Copyright (c) 2015, LY.com All Rights Reserved.
 */
package com.web.framework.service.impl;

import com.web.framework.dao.BaseDao;
import com.web.framework.service.BaseService;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

/**
 * 
 * ClassName: AbstractServiceImpl
 * Description: 业务操作层基类
 * date: 2015-3-9 下午7:29:30
 * 
 * @author dys09435
 * @version V1.0
 * @since JDK 1.7
 */
@Service
@Transactional(rollbackFor = Exception.class)
public abstract class AbstractServiceImpl<T> implements BaseService<T> {
	protected abstract BaseDao<T> getDAO();

	@Override
	@Transactional(readOnly = true)
	public List<T> getList(int start, int count, List<Criterion> conditions, List<Order> orders) {
		return getDAO().getList(start, count, conditions, orders);
	}

	@Override
	@Transactional(readOnly = true)
	public int getTotalCount(List<Criterion> conditions) {
		return getDAO().getTotalCount(conditions);
	}

	@Override
	public void save(T t) {
		getDAO().save(t);
	}

	@Override
	public void save(List<T> lists) {
		getDAO().save(lists);
	}

	@Override
	@Transactional(readOnly = true)
	public T get(int id) {
		return getDAO().get(id);
	}

	@Override
	public T update(T t) {
		return getDAO().update(t);
	}

	@Override
	public void delete(T t) {
		getDAO().delete(t);
	}

	@Override
	@Transactional(readOnly = true)
	public List<T> findByProperty(String propertyName, Object value) {
		return getDAO().findByProperty(propertyName, value);
	}

	@Override
	@Transactional(readOnly = true)
	public T findUniqueByProperty(String propertyName, Object value) {
		return getDAO().findUniqueByProperty(propertyName, value);
	}

	@Override
	@Transactional(readOnly = true)
	public boolean isExist(String propertyName,Object value) {
		return getDAO().findUniqueByProperty(propertyName, value) != null;
	}
	
	@Override
	public String getUUID() {
		return UUID.randomUUID().toString().replace("-", "");
	}
	
}
