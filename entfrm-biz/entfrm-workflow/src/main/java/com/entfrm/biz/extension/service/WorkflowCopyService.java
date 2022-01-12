package com.entfrm.biz.extension.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.entfrm.biz.extension.entity.WorkflowCopy;

/**
 *<p>
 * 流程抄送 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
public interface WorkflowCopyService extends IService<WorkflowCopy> {

    IPage<WorkflowCopy> findList(Page page, WorkflowCopy workflowCopy);

}

