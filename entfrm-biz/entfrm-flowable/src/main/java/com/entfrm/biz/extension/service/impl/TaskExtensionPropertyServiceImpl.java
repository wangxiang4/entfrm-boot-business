package com.entfrm.biz.extension.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.extension.entity.TaskExtensionProperty;
import com.entfrm.biz.extension.mapper.TaskExtensionPropertyMapper;
import com.entfrm.biz.extension.service.TaskExtensionPropertyService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;


/**
 *<p>
 * 任务扩展属性 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
@Service
@AllArgsConstructor
public class TaskExtensionPropertyServiceImpl extends ServiceImpl<TaskExtensionPropertyMapper, TaskExtensionProperty> implements TaskExtensionPropertyService {

}
