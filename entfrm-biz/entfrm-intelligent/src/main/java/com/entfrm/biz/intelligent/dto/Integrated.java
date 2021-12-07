package com.entfrm.biz.intelligent.dto;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.ObjectUtil;
import com.entfrm.base.util.StrUtil;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Map;

/**
 * <p>
 * 集成处理dto
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/3/26
 */
@Data
@Accessors(chain = true)
public class Integrated{

    /** 表单编码 **/
    private String formCode;
    /** 表单扩展版本 **/
    private Float businessVersion;
    /** 当前业务逻辑处理的唯一ID **/
    private Object businessId;
    /** 表单控件数据 **/
    private Map<String,Object> formData;

    public void setBusinessVersion(Float businessVersion)  {
        if(ObjectUtil.isEmpty(businessVersion)&&businessVersion==0){
            throw new NullPointerException("表单扩展唯一版本不能为空!");
        }
        this.businessVersion = businessVersion;
    }

    public void setFormCode(String formCode)  {
        if(StrUtil.isBlank(formCode)){
            throw new NullPointerException("表单编码不能为空!");
        }
        this.formCode = formCode;
    }

    public <T> T getBusinessId(Class<T> type) {
        if(ObjectUtil.isNotEmpty(businessId)){
            return Convert.convert(type,businessId);
        }
        return null;
    }


}
