package com.entfrm.biz.intelligent.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.intelligent.entity.FormExtend;
import com.entfrm.biz.intelligent.mapper.FormExtendMapper;
import com.entfrm.biz.intelligent.service.FormExtendService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * @author entfrm开发团队-王翔
 * @create 2020-12-24
 */
@Service
@AllArgsConstructor
public class FormExtendServiceImpl extends ServiceImpl<FormExtendMapper, FormExtend> implements FormExtendService {

    @Override
    public FormExtend selectSingle(Integer id) {
        return baseMapper.selectSingle(id);
    }

    @Override
    public String fetchFormExtend(String code) {
        return baseMapper.findByCodeOne(code);
    }
}
