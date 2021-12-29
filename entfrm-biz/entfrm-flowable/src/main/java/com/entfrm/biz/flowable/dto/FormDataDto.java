package com.entfrm.biz.flowable.dto;

import cn.hutool.json.JSONObject;
import lombok.Data;

import java.util.Map;

/**
 * <p>
 * 传输Form表单设计器数据
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-13
 */
@Data
public class FormDataDto {

    /** 表单设计器渲染数据 */
    private JSONObject formRenderData;

    /** 表单设计器双向绑定数据 */
    private Map<String,Object> formData;

}
