package com.entfrm.biz.flowable.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.biz.flowable.enums.ProcessStatus;
import com.entfrm.biz.flowable.vo.ProcessDefinitionVo;
import com.entfrm.biz.flowable.vo.ProcessInstanceVo;
import org.flowable.engine.repository.ProcessDefinition;

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
    IPage<ProcessDefinitionVo> list(Map<String, Object> params);

    /**
     * 运行中的流程实例列表
     * params:查询条件参数
     */
    IPage<ProcessInstanceVo> runList(Map<String, Object> params);

    /**
     * 历史流程列表
     * params:查询条件参数
     */
    IPage<ProcessInstanceVo> historyList(Map<String, Object> params);

    /**
     * 读取xml/image资源
     * processInsId:流程实例ID
     * processDefId:流程定义ID
     * fileType:读取文件类型
     */
    InputStream readResource(String processInsId, String processDefId, String fileType);

    /**
     * 设置流程分类类别
     * processDefId: 流程定义ID
     * category: 类别
     */
    void setProcessInstanceCategory(String processDefId, String category);

    /**
     * 挂起/激活
     * processDefId:流程定义ID
     * status:状态
     */
    void setProcessInstanceStatus(String processDefId, String status);

    /**
     * 删除流程部署
     * deploymentId:部署ID
     */
    void deleteDeployment(String deploymentId);

    /**
     * 停止流程实例
     * processInsId:流程实例ID
     * processStatus:流程状态
     * comment:签名备注
     */
    void stopProcessInstance(String processInsId, ProcessStatus processStatus, String comment);

    /**
     * 删除流程实例
     * processInsId:流程实例ID
     * deleteReason:删除原因
     */
    void deleteProcessInstance(String processInsId, String deleteReason);

    /**
     * 撤销流程实例
     * processInsId:流程实例ID
     */
    void undoProcessInstance(String processInsId);

    /**
     * 节点跳转
     * executionIds:需要到那个执行分支流程的执行ID
     * activityId:指定跳转的活动ID
     */
    void moveExecutionsToSingleActivityId(List<String> executionIds, String activityId);

    /**
     * 删除历史流程实例
     * processInsId:流程实例ID
     */
    void delHistoryProcessInstance(String processInsId);

    /**
     * 获取流程实例状态
     * processInstanceId:流程实例ID
     */
    ProcessInstanceVo queryProcessState(String processInstanceId);

    /**
     * 获取流程定义
     * processDefId:流程定义ID
     */
    ProcessDefinition getProcessDefinition(String processDefId);

    /**
     * 获取流程定义
     * processDefKey:流程定义key
     */
    ProcessDefinition getProcessDefinitionByKey(String processDefKey);

}
