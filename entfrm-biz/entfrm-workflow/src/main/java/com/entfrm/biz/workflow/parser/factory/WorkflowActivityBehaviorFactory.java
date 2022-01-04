package com.entfrm.biz.workflow.parser.factory;

import com.entfrm.biz.workflow.parser.handler.ExtendUserTaskActivityBehavior;
import org.flowable.bpmn.model.UserTask;
import org.flowable.engine.impl.bpmn.parser.factory.DefaultActivityBehaviorFactory;

/**
 *<p>
 * 工作流活动行为工厂
 * 活动即代表bpmn流程元素
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
public class WorkflowActivityBehaviorFactory extends DefaultActivityBehaviorFactory {

    @Override
    public ExtendUserTaskActivityBehavior createUserTaskActivityBehavior(UserTask userTask) {
        return new ExtendUserTaskActivityBehavior(userTask);
    }

}
