package com.entfrm.biz.intelligent.service.impl;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.entfrm.biz.intelligent.dto.Integrated;
import com.entfrm.biz.intelligent.entity.DataConf;
import com.entfrm.biz.intelligent.entity.FormExtend;
import com.entfrm.biz.intelligent.entity.ControlSteward;
import com.entfrm.biz.intelligent.mapper.*;
import com.entfrm.biz.intelligent.service.BusinessIntegratedProcessService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 表单扩展设计器控件业务表逻辑集成处理实现
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/3/26
 */
@Service
@AllArgsConstructor
public class BusinessIntegratedProcessServiceImpl implements BusinessIntegratedProcessService {

    private final ControlStewardMapper controlStewardMapper;

    private final FormExtendDesignMapper formExtendDesignMapper;

    private final FormExtendMapper formExtendMapper;

    private final DataConfMapper dataConfMapper;

    private final BusinessIntegratedProcessMapper businessIntegratedProcessMapper;

    @Override
    public int businessInsert(Integrated integrated) {
        String code=integrated.getFormCode(),businessId=integrated.getBusinessId(String.class);
        Float version=integrated.getBusinessVersion();
        Map<String,Object> formData=integrated.getFormData();
        FormExtend formExtend=formExtendMapper.selectOne(Wrappers.<FormExtend>lambdaQuery().eq(FormExtend::getCode,code));
        if(ObjectUtil.isNotEmpty(formExtend)){
            DataConf dataConf=dataConfMapper.selectOne(Wrappers.<DataConf>lambdaQuery().eq(DataConf::getFormExtendId,formExtend.getId()));
            List<ControlSteward> ControlsInfo= controlStewardMapper.selectList(Wrappers.<ControlSteward>lambdaQuery().orderByAsc(ControlSteward::getId));
            //:fixme 控件映射表全部数据,合集
            List<Map<String,Object>> AllControlsMappingTableData=new ArrayList<>();
            //:fixme 当前业务映射表全部字段,除ID
            List<String> BusinessTableAllField=formExtendDesignMapper.selectBusinessTableFieldsAll(dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()));
            Map<String,Object> BusinessInsertData=new HashMap<>();
            for (int i = 0; i < ControlsInfo.size(); ++i) {
                ControlSteward controlSteward =ControlsInfo.get(i);
                List<Map<String,Object>> ControlsMappingTableData=formExtendDesignMapper.selectAllControlsMappingTableData(controlSteward.getControlMappingTable(),formExtend.getId());
                AllControlsMappingTableData.addAll(ControlsMappingTableData);
            }
            //:fixme 循环所有控件
            BusinessInsertData.put("business_id",businessId);
            BusinessInsertData.put("business_version",version);
            AllControlsMappingTableData.forEach(item->{
                if(ObjectUtil.isNotEmpty(formData.get(item.get("config_v_model"))) && formData.get(item.get("config_v_model")) instanceof Map){
                    Object val=((Map<String,Object>) formData.get(item.get("config_v_model"))).get("defaultValue");
                    if (val.getClass().getSimpleName().equals("ArrayList") ) {
                        val=JSONUtil.toJsonStr(val);
                    }
                    BusinessInsertData.put(String.valueOf(item.get("field_current")),val);
                }
            });
            int r=businessIntegratedProcessMapper.businessInsert(
                    dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()),
                    BusinessTableAllField,
                    BusinessInsertData);
        }
        return 0;
    }


    @Override
    public int businessUpdate(Integrated integrated) {

        String code=integrated.getFormCode(),businessId=integrated.getBusinessId(String.class);
        Float version=integrated.getBusinessVersion();
        Map<String,Object> formData=integrated.getFormData();
        FormExtend formExtend=formExtendMapper.selectOne(Wrappers.<FormExtend>lambdaQuery().eq(FormExtend::getCode,code));
        if(ObjectUtil.isNotEmpty(formExtend)){
            DataConf dataConf=dataConfMapper.selectOne(Wrappers.<DataConf>lambdaQuery().eq(DataConf::getFormExtendId,formExtend.getId()));
            List<ControlSteward> ControlsInfo= controlStewardMapper.selectList(Wrappers.<ControlSteward>lambdaQuery().orderByAsc(ControlSteward::getId));
            //:fixme 控件映射表全部数据,合集
            List<Map<String,Object>> AllControlsMappingTableData=new ArrayList<>();
            //:fixme 当前业务映射表全部字段,除ID
            List<String> BusinessTableAllField=formExtendDesignMapper.selectBusinessTableFieldsAll(dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()));
            Map<String,Object> BusinessUpdateData=new HashMap<>();
            for (int i = 0; i < ControlsInfo.size(); ++i) {
                ControlSteward controlSteward =ControlsInfo.get(i);
                List<Map<String,Object>> ControlsMappingTableData=formExtendDesignMapper.selectAllControlsMappingTableData(controlSteward.getControlMappingTable(),formExtend.getId());
                AllControlsMappingTableData.addAll(ControlsMappingTableData);
            }
            //:fixme 循环所有控件
            AllControlsMappingTableData.forEach(item->{
                if(ObjectUtil.isNotEmpty(formData.get(item.get("config_v_model"))) && formData.get(item.get("config_v_model")) instanceof Map){
                    Object val=((Map<String,Object>) formData.get(item.get("config_v_model"))).get("defaultValue");
                    if (val.getClass().getSimpleName().equals("ArrayList") ) {
                        val=JSONUtil.toJsonStr(val);
                    }
                    BusinessUpdateData.put(String.valueOf(item.get("field_current")),val);
                }
            });
            int r=businessIntegratedProcessMapper.businessUpdate(
                    dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()),
                    BusinessTableAllField,
                    BusinessUpdateData,
                    businessId,
                    version);
        }

        return 0;
    }


    @Override
    public int businessDelete(Object[] ids,String formCode,Float version) {
        String code=formCode;
        String[] businessIds = Convert.convert(String[].class,ids);
        FormExtend formExtend=formExtendMapper.selectOne(Wrappers.<FormExtend>lambdaQuery().eq(FormExtend::getCode,code));
        if(ObjectUtil.isNotEmpty(formExtend)){
            DataConf dataConf=dataConfMapper.selectOne(Wrappers.<DataConf>lambdaQuery().eq(DataConf::getFormExtendId,formExtend.getId()));
            businessIntegratedProcessMapper.businessDelete(
                dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()), businessIds, version
            );
        }
        return 0;
    }


    @Override
    public Map<String, Object> businessSelect(Object id,String formCode,Float version) {
        String code=formCode,businessId=Convert.convert(String.class,id);;
        FormExtend formExtend=formExtendMapper.selectOne(Wrappers.<FormExtend>lambdaQuery().eq(FormExtend::getCode,code));
        Map<String,Object> result=new HashMap<>();
        if(ObjectUtil.isNotEmpty(formExtend)){
            DataConf dataConf=dataConfMapper.selectOne(Wrappers.<DataConf>lambdaQuery().eq(DataConf::getFormExtendId,formExtend.getId()));
            List<ControlSteward> ControlsInfo= controlStewardMapper.selectList(Wrappers.<ControlSteward>lambdaQuery().orderByAsc(ControlSteward::getId));
            //:fixme 控件映射表全部数据,合集
            List<Map<String,Object>> AllControlsMappingTableData=new ArrayList<>();
            for (int i = 0; i < ControlsInfo.size(); ++i) {
                ControlSteward controlSteward =ControlsInfo.get(i);
                List<Map<String,Object>> ControlsMappingTableData=formExtendDesignMapper.selectAllControlsMappingTableData(controlSteward.getControlMappingTable(),formExtend.getId());
                AllControlsMappingTableData.addAll(ControlsMappingTableData);
            }
            //:fixme 查询当前业务处理数据
            Map<String,Object> businessData=businessIntegratedProcessMapper.businessSelect(
                dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()),
                businessId,
                version
            );
            if(ObjectUtil.isNotEmpty(businessData)){
                AllControlsMappingTableData.forEach(item->{
                    Map<String,Object> element=new HashMap<>();
                    Object val=businessData.get(item.get("field_current"));
                    if (ObjectUtil.isNotEmpty(val)&&JSONUtil.isJson(val.toString())) {
                        val=JSONUtil.parseArray(val.toString());
                    }
                    element.put("defaultValue",val);
                    element.put("tagIcon",item.get("config_tag_icon"));
                    result.put(String.valueOf(item.get("config_v_model")),element);
                });
            }
        }
        return result;
    }




}
