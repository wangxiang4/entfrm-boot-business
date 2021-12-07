package com.entfrm.biz.flowable.dto;

import com.entfrm.data.entity.BaseEntity;
import lombok.Data;

import java.util.Date;

/**
 * <p>
 * 模型Dto
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-17
 */
@Data
public class ModelDto extends BaseEntity {

    private String id;
    private String name;
    private String key;
    private String category;
    private String description;
    private Date created;
    private Date lastUpdated;
    private String createdBy;
    private String lastUpdatedBy;
    private int version;
    private String modelEditorJson;
    private String comment;
    private Integer modelType;
    private String tenantId;
    private byte[] thumbnail;
    //流程定义对象
    private ProcessDefDto procDef;

}
