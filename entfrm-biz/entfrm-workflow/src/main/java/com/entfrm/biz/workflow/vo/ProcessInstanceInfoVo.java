package com.entfrm.biz.workflow.vo;

import cn.hutool.core.collection.CollectionUtil;
import com.entfrm.biz.workflow.enums.ExtendMessage;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.Date;
import java.util.Map;
/**
 *<p>
 * 流程实例信息
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
public class ProcessInstanceInfoVo {

    /** 流程实例ID */
    private String processInsId;

    /** 流程定义ID */
    private String processDefId;

    /** 流程定义名称 */
    private String processDefName;

    /** 流程版本 */
    private int version;

    /** 流程开始时间 */
    private Date startTime;

    /** 流程结束时间 */
    private Date endTime;

    /** 流程当前任务ID  */
    private String activityId;

    /** 流程当前任务名称 */
    private String taskName;

    /** 流程作废原因 */
    private String deleteReason;

    /** 流程当前任务信息 */
    private TaskInfoVo taskInfo;

    /** 流程操作名称 */
    private String mesName;

    /** 流程操作编码 */
    private String mesCode;

    /** 流程操作级别 */
    private String mesLevel;

    /** 历史最后结束流程任务信息 */
    private HistoryTaskInfoVo historyTaskInfo;

    /** 流程变量 */
    private Map<String, Object> vars = CollectionUtil.newHashMap();

    public void setExtendMessage(ExtendMessage extendMessage){
        this.mesName = extendMessage.getMesName();
        this.mesCode = extendMessage.getMesCode();
        this.mesLevel = extendMessage.getMesLevel();
    }

}
