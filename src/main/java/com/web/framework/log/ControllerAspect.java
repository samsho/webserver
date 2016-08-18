package com.web.framework.log;

import com.web.framework.bean.Bean;
import com.web.framework.bean.base.User;
import com.web.framework.entity.LogEntity;
import com.web.framework.service.LogService;
import com.web.framework.utils.JsonUtil;
import com.google.common.collect.Lists;
import com.google.common.util.concurrent.Futures;
import com.google.common.util.concurrent.ListenableFuture;
import com.google.common.util.concurrent.ListenableScheduledFuture;
import com.google.common.util.concurrent.ListeningScheduledExecutorService;
import com.google.common.util.concurrent.MoreExecutors;
import com.google.common.util.concurrent.ThreadFactoryBuilder;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.annotation.Resource;
import javax.persistence.Entity;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Method;
import java.util.List;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;

/**
 * ClassName: ControllerAspect
 * Description:
 * Date: 2016/4/7 15:09
 *
 * @author ymh09658
 * @version V1.0
 */
@Component
@Aspect
@SuppressWarnings("unchecked")
public class ControllerAspect {
    private final Logger logger = LoggerFactory.getLogger(ControllerAspect.class);
    private final int poolSize = 2;

    private ListeningScheduledExecutorService executorService;

    private BlockingQueue<LogEntity> queue;

    @Resource
    private LogService logService;

    private int batchSize = 100;

    public ControllerAspect() {
        executorService = MoreExecutors.listeningDecorator(
                Executors.newScheduledThreadPool(poolSize,
                        new ThreadFactoryBuilder().setNameFormat("log-thread-%d").build()));
        queue = new LinkedBlockingQueue<>();
    }

    @PostConstruct
    public void startSchedule() {
        for (int i = 0; i < poolSize; i++) {
            ListenableScheduledFuture<?> future = executorService
                    .scheduleWithFixedDelay(getRunnable(), 10, 10, TimeUnit.SECONDS);
            Futures.catchingAsync(future, RuntimeException.class, ex -> {
                logger.error("记入数据库时出错", ex);
                ListenableScheduledFuture<?> f = executorService
                        .scheduleWithFixedDelay(getRunnable(), 10, 10, TimeUnit.SECONDS);
                return (ListenableFuture<Object>) f;
            });
        }
    }

    @PreDestroy
    public void shutdown() {
        MoreExecutors.shutdownAndAwaitTermination(executorService, 5, TimeUnit.SECONDS);
    }

    @Pointcut("within(@org.springframework.stereotype.Controller *)")
    public void viewMethod() {

    }

    @Around("viewMethod()")
    public Object doBefore(ProceedingJoinPoint joinPoint) throws Throwable {
        Signature signature = joinPoint.getSignature();

        if (signature instanceof MethodSignature) {

            HttpServletRequest request = getRequest();
            HttpSession session = request.getSession();
            if (session != null) {
                User user = (User) session.getAttribute(User.ATTRIBUTE);
                if (user != null) { // 只记录已经登录的用户
                    MethodSignature mtdSign = (MethodSignature) signature;
                    Object[] args = joinPoint.getArgs();
                    Method method = mtdSign.getMethod();
                    MethodAnnotation annotation = method.getAnnotation(MethodAnnotation.class);

                    LogEntity logEntity = new LogEntity();
                    logEntity.setUsername(user.getUsername());
                    logEntity.setJobName(user.getJobNumber());
                    StringBuilder stringBuilder = getParams(mtdSign, args);
                    logEntity.setArgs(stringBuilder.toString());
                    logEntity.setUrl(request.getRequestURI());
                    if (annotation != null) {
                        String action = annotation.type().getDesc() + annotation.desc();
                        logEntity.setAction(action);
                    } else {
                        logEntity.setAction(request.getMethod());
                    }

                    logEntity.setIp(request.getRemoteAddr());
                    queue.add(logEntity);
                }
            }

        }

        return joinPoint.proceed();
    }

    @AfterThrowing(value = "viewMethod()", throwing = "ex")
    public void logError(Throwable ex) {
        HttpServletRequest request = getRequest();
        HttpSession session = request.getSession();
        if (session != null) {
            User user = (User) session.getAttribute(User.ATTRIBUTE);
            if (user != null) {
                LogEntity logEntity = new LogEntity();
                logEntity.setUsername(user.getUsername());
                logEntity.setJobName(user.getJobNumber());
                logEntity.setUrl(request.getRequestURI());
                logEntity.setIp(request.getRemoteAddr());
                try (StringWriter stringWriter = new StringWriter()) {
                    PrintWriter p = new PrintWriter(stringWriter);
                    ex.printStackTrace(p);
                    logEntity.setException(stringWriter.toString());
                } catch (IOException e) {
                    logger.error("将错误日志转成string时出错", e);
                }
                queue.add(logEntity);
            }
        }
    }

    private StringBuilder getParams(MethodSignature mtdSign, Object[] args) {
        String[] params = mtdSign.getParameterNames();
        Class[] paramTypes = mtdSign.getParameterTypes();
        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < args.length; i++) {
            Class type = paramTypes[i];
            if (!HttpServletRequest.class.isAssignableFrom(type)
                    && !ModelMap.class.isAssignableFrom(type)
                    && !HttpServletResponse.class.isAssignableFrom(type)
                    && !WebDataBinder.class.isAssignableFrom(type)) {
                final Object arg = args[i];
                String s;
                if (arg == null) {
                    s = "null";
                } else if (arg instanceof String) {
                    s = "\"" + arg + "\"";
                } else if (type.getAnnotation(Entity.class) != null || Bean.class.isAssignableFrom(type)) {
                    // 如果是数据库的类，记录下来
                    try {
                        s = JsonUtil.toJson(arg);
                    } catch (IOException e) {
                        s = arg.toString();
                    }
                } else {
                    s = arg.toString();
                }
                stringBuilder.append(params[i]).append("=").append(s).append(";");
            }
        }
        return stringBuilder;
    }

    private HttpServletRequest getRequest() {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder
                .currentRequestAttributes();
        return attributes.getRequest();
    }

    private Runnable getRunnable() {
        return () -> {
            if (!queue.isEmpty()) {
                final List<LogEntity> entities = Lists.newArrayListWithExpectedSize(batchSize);
                queue.drainTo(entities, batchSize);
                logger.info("", entities);
                logService.save(entities);
            }
        };

    }
}
