package com.entfrm.biz.workflow.vo;

import com.entfrm.biz.workflow.enums.ProcessStatus;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;
import java.util.Map;
/**
 *<p>
 * 流程实例
 * 流程数据封装
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */

@Data
@Accessors(chain = true)
public class ProcessInstanceInfoVo {

    //流程实例ID
    private String processInstanceId;
    //流程定义ID
    private String processDefinitionId;
    //流程名称
    private String processDefinitionName;
    //当前活动ID
    private String activityId;
    //流程版本
    private int version;
    //当前任务流程变量
    private Map vars;
    //流程开始时间
    private Date startTime;
    //流程结束时间
    private Date endTime;
    //流程当前节点名称
    private String taskName;
    //流程作废原因
    private String deleteReason;
    //流程当前节点
    private TaskInfoVo task;


    //流程状态码
    private int code;
    //流程状态
    private String status;
    //状态级别，用于控制在前台显示的颜色
    private String level;

    public String getId(){ // 流程实例id 作为列表的id
        return processInstanceId;
    }

    public void setProcessStatus(ProcessStatus processStatus){
        this.code = processStatus.getCode ();
        this.status = processStatus.getStatus ();
        this.level = processStatus.getLevel ();
    }



}
