package com.entfrm.biz.intelligent.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.entfrm.biz.intelligent.entity.ControlSteward;

/**
 * <p>
 * 控件大管家业务接口
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/3/27
 */
public interface ControlStewardService extends IService<ControlSteward> {


    /**
     * 创建控件表
     *@Param [json]
     *@return int
     */
    int createControlsTable(String TableName,String json);

    /**
     * 删除控件表
     *@Param [ids]
     *@return int
     */
    int deleteControlsTable(Integer[] ids);


    int selectControlsTable(String Table);

}
