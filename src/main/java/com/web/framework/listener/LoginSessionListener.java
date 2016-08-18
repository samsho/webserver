package com.web.framework.listener;


import com.web.framework.bean.base.User;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import java.util.HashMap;
import java.util.Map;

/**
 * ClassName: LoginSessionListener
 * Description:
 * Date: 2016/4/23 10:22
 *
 * @author sam-sho
 * @version V1.0
 */
public class LoginSessionListener implements HttpSessionAttributeListener {
    Map<String, HttpSession> map = new HashMap<>();

    public void attributeAdded(HttpSessionBindingEvent event) {
        if (!(event.getValue() instanceof User)) {
            return;
        }

        add(event, (User) event.getValue());
    }

    public void attributeRemoved(HttpSessionBindingEvent event) {
        if (!(event.getValue() instanceof User)) {
            return;
        }
        User user = (User) event.getValue();
        if (user != null) {
            map.remove(user.getJobNumber());
        }
    }

    public void attributeReplaced(HttpSessionBindingEvent event) {
        if (!(event.getValue() instanceof User)) {
            return;
        }

        User oldUser = (User) event.getValue();
        if (oldUser != null) {
            map.remove(oldUser.getJobNumber());
        }

        User user = (User) event.getSession().getAttribute(User.ATTRIBUTE);
        add(event, user);
    }

    private void add(HttpSessionBindingEvent event, User user) {
        String key = user.getJobNumber();
        if (map.get(key) != null) {
            HttpSession session = map.get(key);
            session.removeAttribute(User.ATTRIBUTE);
        } else {
            map.put(key, event.getSession());
        }
    }

}
