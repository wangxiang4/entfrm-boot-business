package com.entfrm.biz.intelligent.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.entfrm.biz.intelligent.entity.FormExtend;

/**
 * @author entfrm开发团队-王翔
 * @create 2020-12-24
 */
public interface FormExtendService extends IService<FormExtend> {

    FormExtend selectSingle(Integer id);

    String fetchFormExtend(String code);

}
