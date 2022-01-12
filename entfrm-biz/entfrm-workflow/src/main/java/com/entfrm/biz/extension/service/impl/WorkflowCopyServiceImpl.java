package com.entfrm.biz.extension.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.extension.entity.WorkflowCopy;
import com.entfrm.biz.extension.mapper.WorkflowCopyMapper;
import com.entfrm.biz.extension.service.WorkflowCopyService;
import org.springframework.stereotype.Service;


/**
 *<p>
 * 流程抄送 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
@Service
public class WorkflowCopyServiceImpl extends ServiceImpl<WorkflowCopyMapper, WorkflowCopy> implements WorkflowCopyService {

    @Override
    public IPage<WorkflowCopy> findList(Page page, WorkflowCopy workflowCopy) {
        return baseMapper.findList(page, workflowCopy);
    }

}
