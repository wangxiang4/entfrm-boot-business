package com.entfrm.biz.flowable.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.biz.flowable.dto.ProcessDefDto;
import com.entfrm.biz.flowable.enums.ProcessStatus;
import com.entfrm.biz.flowable.vo.ProcessInsVo;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ProcessInstance;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

/**
 *<p>
 * 流程定义相关 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/11
 */
public interface FlowableProcessService {


    /**
     * 流程定义列表
     * params:查询条件参数
     */
    IPage<ProcessDefDto> list(Map<String, Object> params);

    /**
     * 读取xml/image资源
     * procInsId:流程实例ID
     * procDefId:流程定义ID
     * resType:读取文件类型
     */
    InputStream readResource(String procInsId, String procDefId, String resType);

    /**
     * 挂起/激活
     * status:状态
     * procDefId:流程定义ID
     */
    Boolean changeStatus(String procDefId, String status);


    /**
     * 删除流程实例
     * deployId:部署ID
     */
    Boolean removeProcIns(String deployId);


    /**
     * 获取正在运行的流程实例对象
     * procInsId:流程实例ID
     * @return :ProcessInstance实体
     */
    ProcessInstance getProcIns(String procInsId);

    /**
     * 获取已经结束流程实例对象
     * procInsId:流程实例ID
     * @return :HistoricProcessInstance实体
     */
    HistoricProcessInstance getFinishedProcIns(String procInsId);


    /**
     * 获取流程实例状态
     * processInstanceId:流程实例ID
     * @return :ProcessVo实体
     */
    ProcessInsVo queryProcessState(String processInstanceId);



    /**
     * 根据key获取流程定义
     * key:流程定义Key
     */
    ProcessDefinition getProcessDefinitionByKey(String key);


    /**
     * 终止流程实例
     * procInsId:流程实例ID
     * processStatus:流程状态
     * comment:审批意见
     */
    void stopProcessInstanceById(String procInsId, ProcessStatus processStatus, String comment);



    /**
     * 节点跳转
     * executionIds:需要到那个执行分支流程的执行ID
     * activityId:指定跳转的活动ID
     */
    void moveExecutionsToSingleActivityId(List<String> executionIds, String activityId);



}
