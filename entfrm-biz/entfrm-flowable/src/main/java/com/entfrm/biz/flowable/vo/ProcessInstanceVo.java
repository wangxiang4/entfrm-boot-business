package com.entfrm.biz.flowable.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
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
public class ProcessInstanceVo {

    private String id;
    private String category;
    private String key;
    private String name;
    private String version;
    private String resourceName;
    private String diagramResourceName;
    private String deploymentId;
    private boolean suspend;
    private Date deploymentTime;

}
