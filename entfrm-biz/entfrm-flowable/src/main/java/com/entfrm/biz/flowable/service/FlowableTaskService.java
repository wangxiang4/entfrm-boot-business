package com.entfrm.biz.flowable.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.biz.flowable.entity.Flow;
import com.entfrm.biz.flowable.entity.TaskComment;

import java.io.InputStream;
import java.util.List;
import java.util.Map;


/**
 *<p>
 *  任务相关 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/11
 */
public interface FlowableTaskService {



    /**
     * 代办任务列表
     * params:查询条件参数
     */
    IPage list(Map<String, Object> params);



    /**
     * 获取当前任务图片
     * taskId:任务ID
     */
    InputStream getTackImage(String taskId);


    /**
     * 获取任务定义数据
     * 必要参数:
     * procDefId:流程定义ID
     * taskDefKey:任务定义ID
     */
    Flow getTaskDef(Flow flow);



    /**
     * 提交任务,并保存意见
     * 审批任务
     * flow:工作流通用数据传输VO
     * **/
    void complete(Flow flow);


    /**
     * 外置表单审批专用
     * 审批任务
     * **/
    void auditTask(Flow flow);




    /**
     * 启动流程
     * 满足各种模块,个性化定制页面请求
     * procDefKey:启动流程定义唯一Key
     * title:流程标题
     * businessTable:业务数据表,动态修改业务表流程实例ID
     * businessId:业务Key唯一ID,后期需要传业务key给外置表单查询数据
     * vars:设置启动流程变量
     *@return :当前正在运行的流程实例ID
     */
    String startProcess(String procDefKey,
                        String businessTable,
                        String businessId,
                        String title,
                        Map<String,Object> vars);



    /**
     * 外置表单专用
     * 满足各种模块,个性化定制页面请求
     * procDefKey:启动流程定义唯一Key
     * title:流程标题
     * businessTable:业务数据表,动态修改业务表流程实例ID
     * businessId:业务Key唯一ID,后期需要传业务key给外置表单查询数据
     *@return :当前正在运行的流程实例ID
     */
    String startProcess(String procDefKey,
                        String businessTable,
                        String businessId,
                        String title);




    /**
     * 获取可驳回节点
     * taskId:任务ID
     * @return :已经运行过的活动节点信息
     */
    List<Flow> getBackNodes(String taskId);



    /**
     * 驳回任务,驳回到指定节点
     * backTaskDefKey:驳回的任务定义唯一Key
     * taskId:当前任务ID
     * TaskComment:设置驳回状态
     */
    void backTask(String backTaskDefKey, String taskId, TaskComment comment);



}
