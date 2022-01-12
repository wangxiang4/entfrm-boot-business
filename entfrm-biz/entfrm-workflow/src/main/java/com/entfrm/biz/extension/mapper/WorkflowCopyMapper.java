package com.entfrm.biz.extension.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.biz.extension.entity.WorkflowCopy;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 流程抄送 Mapper
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-11
 */
public interface WorkflowCopyMapper extends BaseMapper<WorkflowCopy> {

    IPage<WorkflowCopy> findList(Page page, @Param("ew") WorkflowCopy workflowCopy);

}
