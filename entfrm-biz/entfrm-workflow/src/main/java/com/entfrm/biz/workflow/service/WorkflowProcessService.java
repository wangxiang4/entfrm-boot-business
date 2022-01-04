package com.entfrm.biz.workflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.biz.workflow.enums.ProcessStatus;
import com.entfrm.biz.workflow.vo.ProcessDefinitionInfoVo;
import com.entfrm.biz.workflow.vo.ProcessInstanceInfoVo;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ProcessInstance;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

/**
 *<p>
 * 流程定义 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
public interface WorkflowProcessService {

    /**
     * 流程定义列表
     * params:查询条件参数
     */
    IPage<ProcessDefinitionInfoVo> list(Map<String, Object> params);

    /**
     * 运行中的流程实例列表
     * params:查询条件参数
     */
    IPage<ProcessInstanceInfoVo> runList(Map<String, Object> params);

    /**
     * 历史流程列表
     * params:查询条件参数
     */
    IPage<ProcessInstanceInfoVo> historyList(Map<String, Object> params);

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
     * comment:备注
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
     * processInsId:流程实例ID
     */
    ProcessInstanceInfoVo queryProcessState(String processInsId);

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

    /**
     * 获取流程实例
     * processInsId:流程实例ID
     */
    ProcessInstance getProcessInstance(String processInsId);

    /**
     * 获取运行完成流程实例
     * processInsId:流程实例ID
     */
    HistoricProcessInstance getFinishedProcessInstance(String processInsId);

    /**
     * 自己发起流程实例列表
     * params:查询条件参数
     */
    IPage<ProcessInstanceInfoVo> selfProcessInstanceList(Map<String, Object> params);

    /**
     * 启动流程定义
     * processDefKey:流程定义key
     * businessTable:流程业务关联表
     * businessId:流程业务关联数据ID
     * title:流程标题,显示在待办任务标题
     * processVars:流程变量
     */
    String startProcessDefinition(String processDefKey, String businessTable, String businessId, String title, Map<String, Object> processVars);


    /**
     * 启动流程定义
     * processDefKey:流程定义key
     * businessTable:流程业务关联表
     * businessId:流程业务关联数据ID
     * title:流程标题,显示在待办任务标题
     */
    String startProcessDefinition(String processDefKey, String businessTable, String businessId, String title);

}
