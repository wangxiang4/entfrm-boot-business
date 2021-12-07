package com.entfrm.biz.flowable.listener;

import com.entfrm.security.util.SecurityUtil;
import lombok.extern.slf4j.Slf4j;
import org.flowable.task.service.delegate.DelegateTask;
import org.flowable.task.service.delegate.TaskListener;


/**
 *<p>
 * 请假流程例子
 * 流程监听器
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
@Slf4j
public class LeaveTaskListener implements TaskListener {



    @Override
    public void notify(DelegateTask delegateTask) {

        //查询当前上级 提醒上级审批并创建数据
        //此处实现给自己审批
        log.info("审批人：{}", SecurityUtil.getUser().getUsername());
        delegateTask.addCandidateUser(SecurityUtil.getUser().getUsername());

    }




}
