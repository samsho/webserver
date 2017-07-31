package com.web.framework.bean;

import java.util.List;
import java.util.Map;

/**
 * ClassName: Pager
 * Description: ��ҳ
 * Date: 2016/8/28 10:13
 *
 * @author SAM SHO
 * @version V1.0
 */
public class Pager<T> {
    private int total;//����
    private int index;//�ڼ�ҳ
    private int count;//ÿҳ���ټ�¼
    private int pages;//һ������ҳ
    private String sort;
    private String direction;
    private List<T> result;
    private Map<String, ?> conditions;

    /**
     * @param total     �ܼ�¼��
     * @param index     �ڼ�ҳ
     * @param count     ÿҳ���ټ�¼
     * @param sort      ���ĸ��ֶ�����
     * @param direction ������
     */
    public Pager(int total, int index, int count, String sort, String direction) {
        this.total = total;
        this.index = index;
        this.count = count;
        this.sort = sort;
        this.direction = direction;
        this.pages = total % count != 0 ? (total / count + 1) : (total / count);
    }


    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public List<T> getResult() {
        return result;
    }

    public void setResult(List<T> result) {
        this.result = result;
    }

    public Map<String, ?> getConditions() {
        return conditions;
    }

    public void setConditions(Map<String, ?> conditions) {
        this.conditions = conditions;
    }
}
