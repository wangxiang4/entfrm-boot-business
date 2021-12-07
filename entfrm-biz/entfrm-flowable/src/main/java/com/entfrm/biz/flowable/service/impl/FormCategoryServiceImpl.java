package com.entfrm.biz.flowable.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.flowable.entity.ActCategory;
import com.entfrm.biz.flowable.entity.FormCategory;
import com.entfrm.biz.flowable.mapper.ActCategoryMapper;
import com.entfrm.biz.flowable.mapper.FormCategoryMapper;
import com.entfrm.biz.flowable.service.ActCategoryService;
import com.entfrm.biz.flowable.service.FormCategoryService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 表单定义分类管理 service
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-06-21
 */
@Service
public class FormCategoryServiceImpl extends ServiceImpl<FormCategoryMapper, FormCategory> implements FormCategoryService {

}
