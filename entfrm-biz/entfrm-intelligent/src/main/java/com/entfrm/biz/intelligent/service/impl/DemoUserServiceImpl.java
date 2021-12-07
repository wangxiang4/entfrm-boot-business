package com.entfrm.biz.intelligent.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.intelligent.entity.DemoUser;
import com.entfrm.biz.intelligent.mapper.DemoUserMapper;
import com.entfrm.biz.intelligent.service.DemoUserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 用户例子
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/3/26
 */
@Service
@AllArgsConstructor
public class DemoUserServiceImpl extends ServiceImpl<DemoUserMapper, DemoUser> implements DemoUserService {
}
