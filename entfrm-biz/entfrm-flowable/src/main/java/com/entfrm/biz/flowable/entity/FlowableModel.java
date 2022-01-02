package com.entfrm.biz.flowable.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.biz.flowable.vo.ProcessDefinitionVo;
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
 * @Date: 2021-05-17
 */

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_de_model")
public class FlowableModel implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;
    private String name;
    private String modelKey;
    private String description;
    private String modelComment;
    private Date created;
    private String createdBy;
    private Date lastUpdated;
    private String lastUpdatedBy;
    private int version;
    private String modelEditorJson;
    private byte[] thumbnail;
    private Integer modelType;
    private String tenantId;

    @TableField(exist = false)
    private ProcessDefinitionVo processDefinitionVo;

}
