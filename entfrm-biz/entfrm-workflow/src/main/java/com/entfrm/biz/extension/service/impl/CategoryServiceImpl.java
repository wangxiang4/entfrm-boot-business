package com.entfrm.biz.extension.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.extension.entity.Category;
import com.entfrm.biz.extension.mapper.CategoryMapper;
import com.entfrm.biz.extension.service.CategoryService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 流程分类管理 service
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-06-21
 */
@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {

}
