package com.entfrm.biz.workflow.vo;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;


/**
 *<p>
 * 流程定义
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */

@Data
@Accessors(chain = true)
public class ProcessDefinitionInfoVo {

    /** 流程定义ID */
    private String id;

    /** 流程定义分类 */
    private String category;

    /** 流程定义key */
    private String key;

    /** 流程定义名称 */
    private String name;

    /** 流程定义版本 */
    private String version;

    /** bpmn.xml名称 */
    private String resourceName;

    /** 流程图名称 */
    private String diagramResourceName;

    /** 流程部署ID */
    private String deploymentId;

    /** 是否暂停 */
    private boolean suspend;

    /** 流程部署时间 */
    private Date deploymentTime;

}
