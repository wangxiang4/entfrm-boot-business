package com.entfrm.biz.workflow.entity;

import cn.hutool.core.collection.CollectionUtil;
import com.entfrm.base.util.TimeUtils;
import com.entfrm.biz.workflow.vo.ActivityCommentInfoVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.runtime.ProcessInstance;

import java.io.Serializable;
import java.util.Map;

/**
 * <p>
 * 工作流核心
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Workflow implements Serializable {

    /** 反序列化密钥 */
    private static final long serialVersionUID = 1L;

    /** 流程任务ID */
    private String taskId;
    /** 流程任务名称 */
    private String taskName;
    /** 流程任务定义key */
    private String taskDefKey;
    /** 任务处理人ID */
    private String assignee;
    /** 任务处理人名称 */
    private String assigneeName;

    /** 流程表单key */
    private String formKey;
    /** 表单类型(1:动态表单,2:外置表单) */
    private String formType;
    /** 流程表单是否只读 */
    private boolean formReadOnly;

    /** 流程标题 */
    private String title;
    /** 流程实例ID */
    private String processInsId;
    /** 流程定义ID */
    private String processDefId;
    /** 流程定义Key */
    private String processDefKey;

    /** 业务数据ID */
    private String businessId;
    /** 业务数据表名 */
    private String businessTable;

    /** 流程变量 */
    private Map<String, Object> vars = CollectionUtil.newHashMap();
    /** 活动批注信息 */
    private ActivityCommentInfoVo activityCommentInfo = new ActivityCommentInfoVo();
    /** 历史任务活动实例 */
    private HistoricActivityInstance historicActivityInstance;


    /** 设置流程实例业务数据 */
    public void setProcessInstanceBusinessData(ProcessInstance processInstance) {
        if (processInstance != null
                && processInstance.getBusinessKey() != null
                && processInstance.getBusinessKey().contains(":")) {
            String[] bind = processInstance.getBusinessKey().split(":");
            setBusinessTable(bind[0]);
            setBusinessId(bind[1]);
        } else if (processInstance != null && processInstance.getBusinessKey() != null) {
            setBusinessId(processInstance.getBusinessKey());
        }
    }

    /** 设置已经结束流程实例业务数据 */
    public void setFinishedProcessInstanceBusinessData(HistoricProcessInstance historicProcessInstance) {
        if (historicProcessInstance != null
                && historicProcessInstance.getBusinessKey() != null
                && historicProcessInstance.getBusinessKey().contains(":")) {
            String[] bind = historicProcessInstance.getBusinessKey().split(":");
            setBusinessTable(bind[0]);
            setBusinessId(bind[1]);
        } else if (historicProcessInstance != null && historicProcessInstance.getBusinessKey() != null) {
            setBusinessId(historicProcessInstance.getBusinessKey());
        }
    }

    /** 获取流程运行持续时间 */
    public String getDurationTime() {
        if (historicActivityInstance != null && historicActivityInstance.getDurationInMillis() != null) {
            System.out.println("测试 ： " +TimeUtils.toTimeString(historicActivityInstance.getDurationInMillis()));
            return TimeUtils.toTimeString(historicActivityInstance.getDurationInMillis());
        }
        return "";
    }

}
