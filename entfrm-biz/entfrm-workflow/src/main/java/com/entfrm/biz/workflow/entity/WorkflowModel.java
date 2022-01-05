package com.entfrm.biz.workflow.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.biz.workflow.vo.ProcessDefinitionInfoVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 流程模型
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_de_model")
public class WorkflowModel implements Serializable {

    /** 反序列密钥 */
    private static final long serialVersionUID = 1L;

    @TableId
    private String id;

    /** 模型名称 */
    private String name;

    /** 模型key  */
    private String modelKey;

    /** 描述 */
    private String description;

    /** 备注 */
    private String modelComment;

    /** 创建时间 */
    private Date created;

    /** 创建人 */
    private String createdBy;

    /** 最后更新时间 */
    private Date lastUpdated;

    /** 最后更新人 */
    private String lastUpdatedBy;

    /** 模型版本 */
    private int version;

    /** 模型设计器JSON */
    private String modelEditorJson;

    /** 模型流程图 */
    private byte[] thumbnail;

    /**
     * 模型类型
     * 0:BPMN模型
     * 2:表单模型
     * 3:APP模型
     * 4:决策模型
     * 5:CMMN模型
     */
    private Integer modelType;

    /** 多租户ID */
    private String tenantId;

    /** 流程定义 */
    @TableField(exist = false)
    private ProcessDefinitionInfoVo processDefinition = new ProcessDefinitionInfoVo();

}
