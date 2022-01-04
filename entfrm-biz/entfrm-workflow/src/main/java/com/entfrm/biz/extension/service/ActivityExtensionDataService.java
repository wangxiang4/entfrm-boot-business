package com.entfrm.biz.extension.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.entfrm.biz.extension.entity.ActivityExtensionData;

/**
 *<p>
 * 任务扩展数据 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
public interface ActivityExtensionDataService extends IService<ActivityExtensionData> {

    ActivityExtensionData findById (Integer id);

    void delete (Integer id);

    void deleteByProcessDefId(String processDefId);
}

