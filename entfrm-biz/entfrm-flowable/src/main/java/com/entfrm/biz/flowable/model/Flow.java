package com.entfrm.biz.flowable.model;

import com.entfrm.biz.flowable.util.Variable;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.history.HistoricTaskInstance;

import java.util.Map;

/**
 * <p>
 * 工作流Entity
 * 工作流通用数据
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-11
 */
@Data
public class Flow {


    /**任务编号**/
    private String taskId;
    /**任务名称**/
    private String taskName;
    /**任务定义Key(任务环节标识)**/
    private String taskDefKey;
    /**表单类型**/
    private String formType;
    /**流程实例ID**/
    private String procInsId;
    /**流程定义ID**/
    private String procDefId;
    /**流程定义Key(流程定义标识)**/
    private String procDefKey;
    /**业务绑定ID**/
    private String businessId;
    /**业务绑定表名**/
    private String businessTable;
    /**任务标题**/
    private String title;
    /**任务执行人编号**/
    private String assignee;
    /**任务执行人名称**/
    private String assigneeName;
    /**流程表单地址**/
    private String formUrl;
    /**动态表单数据:josn**/
    private String formData;
    /**批注信息**/
    private TaskComment comment;
    /**流程变量**/
    private Variable vars;
    /**流程实例对象**/
    @JsonIgnore
    private ProcessInstance procIns;
    /**历史流程实例对象**/
    private HistoricProcessInstance hisProcIns;
    /**历史任务**/
    private HistoricTaskInstance histTask;
    /**历史活动任务**/
    private HistoricActivityInstance histIns;


    /** 设置流程绑定业务数据:正在运行的流程 **/
    public void setProcIns(ProcessInstance procIns) {
        this.procIns = procIns;
        if (procIns != null && procIns.getBusinessKey() != null && procIns.getBusinessKey().contains("_")) {
            String[] bind = procIns.getBusinessKey().split(":");
            setBusinessTable(bind[0]);
            setBusinessId(bind[1]);
        } else if (procIns != null && procIns.getBusinessKey() != null) {
            setBusinessId(procIns.getBusinessKey());
        }
    }

    /** 设置流程绑定业务数据:已经结束的流程 **/
    public void setFinishedProcIns(HistoricProcessInstance procIns) {
        this.hisProcIns = procIns;
        if (procIns != null && procIns.getBusinessKey() != null && procIns.getBusinessKey().contains("_")) {
            String[] bind = procIns.getBusinessKey().split(":");
            setBusinessTable(bind[0]);
            setBusinessId(bind[1]);
        } else if (procIns != null && procIns.getBusinessKey() != null) {
            setBusinessId(procIns.getBusinessKey());
        }
    }

    /** 自动注入通过Map设置流程变量值 **/
    public void setVars(Map<String, Object> map) {
        this.vars = new Variable(map);
    }



}
