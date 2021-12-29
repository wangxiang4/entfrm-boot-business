package com.entfrm.biz.flowable.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.entfrm.biz.flowable.constant.FlowableConstant;
import com.entfrm.biz.flowable.dto.FormDataDto;
import com.entfrm.biz.flowable.mapper.FlowMapper;
import com.entfrm.biz.flowable.entity.Flow;
import com.entfrm.biz.flowable.service.FlowableFormService;
import com.entfrm.biz.flowable.service.FlowableProcessService;
import com.entfrm.biz.flowable.service.FlowableTaskService;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import org.flowable.engine.IdentityService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.runtime.ProcessInstance;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * <p>
 * 动态表单表单相关 service
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-16
 */
@Service
@AllArgsConstructor
public class FlowableFormServiceImpl implements FlowableFormService {


    private final RuntimeService runtimeService;
    private final FlowableTaskService flowableTaskService;
    private final FlowMapper flowMapper;
    private final FlowableProcessService flowableProcessService;
    private final IdentityService identityService;


    /** 动态表单启动流程专用 */
    @Override
    public String submitStartFormData(String processDefinitionId, String title, String data) {

        //表单数据转换JSON对象
        JSONObject jData = JSONUtil.parseObj(data);
        //设置流程变量
        Map<String,Object> vars = MapUtil.newHashMap();
        String userName = SecurityUtil.getUser().getUsername();
        vars.put(FlowableConstant.USERNAME,userName);
        //设置流程发起人
        identityService.setAuthenticatedUserId(userName);

        // 设置流程标题
        if (StrUtil.isNotBlank(title)) {
            vars.put("title", title);
        }
        for(String key:jData.keySet()){
            vars.put(key,jData.getObj(key));
        }

        //启动流程实例
        String procInsId=runtimeService.startProcessInstanceById(processDefinitionId,vars).getProcessInstanceId();

        return procInsId;

    }



    /** 动态表单审核专用 */
    @Override
    public void submitTaskFormData(Flow flow, String data) {

        //表单数据转换JSON对象
        JSONObject jData = JSONUtil.parseObj(data);

        //设置流程变量
        Map<String,Object> vars = MapUtil.newHashMap();
        for(String key:jData.keySet()){
            vars.put(key,jData.getObj(key));
        }
        flow.setVars(vars);
        flowableTaskService.complete(flow);

    }


    /** 获取表单数据专用 */
    @Override
    public FormDataDto getFormData(String code, String procInsId) {
        String data=flowMapper.getFormRenderData(code);
        if(StrUtil.isBlank(data)){
            return null;
        }
        FormDataDto formDataDto=new FormDataDto();
        formDataDto.setFormRenderData(JSONUtil.parseObj(data));

        //确保内外置表单数据共用,还需考虑到中途表单内容修改
        Map<String,Object> dynamicFormData=runtimeService.getVariables(procInsId);
        ProcessInstance pi=flowableProcessService.getProcIns(procInsId);
        //如果存在外置表单的数据进入融合
        if(StrUtil.isNotBlank(pi.getBusinessKey())){
            Flow flow =new Flow();
            flow.setProcIns(pi);
            Map<String,Object> externalFormData=flowMapper.selectFormData(flow);
            BeanUtil.copyProperties(dynamicFormData,externalFormData);
            dynamicFormData=externalFormData;
        }
        formDataDto.setFormData(dynamicFormData);
        return formDataDto;
    }

}
