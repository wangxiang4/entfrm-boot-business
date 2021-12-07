package com.entfrm.biz.intelligent.util;

import java.util.concurrent.*;

/**
 * <p>
 * 后期并发编程-使用
 * 线程配置|所有用户使用公用一个池
 * 线程池工具类
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/2/8
 */
public class ExecutorPoolUtil {

    // 核心线程数
    private static final int DEFAULT_CORE_SIZE = 80;
    // 任务队列容量(阻塞队列)采用数组集合阻塞队列
    private static final int QUEUE_CAPACITY = 80;
    // 最大线程数
    private static final int MAX_QUEUE_SIZE = 92;
    // 非核心线程闲置超时时间L
    private static final long KEEP_ALIVE_TIME = 60L;
    // 延迟超时单位(秒)
    private static final TimeUnit UNIT=TimeUnit.SECONDS;
    // 允许核心线程超时
    private static final boolean ALLOW_CORE_THREAD_TIMEOUT=false;
    // 任务拒绝处理器(由调用线程处理该任务)
    private static final RejectedExecutionHandler REJECTED_EXECUTION_HANDLER=new ThreadPoolExecutor.CallerRunsPolicy();
    // java线程池执行器(自定义配置)
    private volatile static ThreadPoolExecutor executor=new ThreadPoolExecutor(
            DEFAULT_CORE_SIZE,
            MAX_QUEUE_SIZE,
            KEEP_ALIVE_TIME,
            UNIT,
            new LinkedBlockingQueue(QUEUE_CAPACITY),
            REJECTED_EXECUTION_HANDLER
    );

    //获取固定大小线程池
    public static ExecutorService getFixedThreadPool() {
        executor.allowCoreThreadTimeOut(ALLOW_CORE_THREAD_TIMEOUT);
        return executor;
    }

}

