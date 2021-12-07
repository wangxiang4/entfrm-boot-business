package com.entfrm.biz.intelligent.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.entfrm.biz.intelligent.dto.FormExtendDesignDto;
import com.entfrm.biz.intelligent.dto.JsonMode;
import com.entfrm.biz.intelligent.entity.DataConf;
import com.entfrm.biz.intelligent.entity.FormExtend;
import com.entfrm.biz.intelligent.entity.ControlSteward;
import com.entfrm.biz.intelligent.mapper.DataConfMapper;
import com.entfrm.biz.intelligent.mapper.FormExtendDesignMapper;
import com.entfrm.biz.intelligent.mapper.FormExtendMapper;
import com.entfrm.biz.intelligent.mapper.ControlStewardMapper;
import com.entfrm.biz.intelligent.service.FormExtendDesignService;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

/**
 * <p>
 * 表单扩展设计器业务接口实现
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/1/21
 */
@Service
@AllArgsConstructor
@Transactional(rollbackFor=Exception.class)
public class FormExtendDesignServiceImpl implements FormExtendDesignService {

    //:todo mapper接口成员变量初始化
    private final FormExtendDesignMapper formExtendDesignMapper;

    private final ControlStewardMapper controlStewardMapper;

    private final FormExtendMapper formExtendMapper;

    private final DataConfMapper dataConfMapper;


    @Override
    public int insert(FormExtendDesignDto formExtendDesignDto) {
        //:fixme 校验
        Optional.ofNullable(formExtendDesignDto.getJsonMode()).orElseThrow(()->new NullPointerException("Json数据模型不能为空!"));
        //:todo 初始化局部变量
        JsonMode JsonMode=formExtendDesignDto.getJsonMode();
        List<Map<String,Object>> controlFields=JsonMode.getDrawingControls();
        DataConf settings= JsonMode.getDataConf();
        List<String> vFieldCounts=new ArrayList<>();
        List<ControlSteward> ControlsInfo= controlStewardMapper.selectList(Wrappers.<ControlSteward>lambdaQuery().orderByAsc(ControlSteward::getId));

        //:fixme 首次新增处理逻辑
        for (int i = 0; i < controlFields.size(); ++i) {
            Map<String,Object> item=controlFields.get(i);
            Map<String,Object> ProcessJsonMode=new HashMap();
            ProcessJsonMode(item,ProcessJsonMode,null);
            ControlSteward controlSteward = StreamSupport.stream(ControlsInfo.spliterator(),true)
                    .filter(e-> e.getControlTagIcon().equals(ProcessJsonMode.get("config_tag_icon")))
                    .collect(Collectors.toList()).stream().findFirst().orElse(null);
           if(ObjectUtil.isNotEmpty(controlSteward)){
               //生成新增所需的数据
               ProcessJsonMode.put("field_length",settings.getFieldLength());
               ProcessJsonMode.put("field_current","field"+Integer.sum(i,1));
               ProcessJsonMode.put("data_mapping_table",settings.getDataMappingTablePrepend().concat(settings.getDataMappingTable()));
               ProcessJsonMode.put("create_by", SecurityUtil.getUser().getUsername());
               ProcessJsonMode.put("form_extend_id",formExtendDesignDto.getFormExtendId());
               ProcessJsonMode.put("data_mapping_table_prefix",settings.getDataMappingTablePrepend());
               ProcessJsonMode.put("data_mapping_table_suffix",settings.getDataMappingTable());
               List<String> TableFields=formExtendDesignMapper.selectTableFields(controlSteward.getControlMappingTable());
               //新增控件
               int r=formExtendDesignMapper.insertControlsMappingTable(TableFields, controlSteward.getControlMappingTable(),ProcessJsonMode);
               //新增业务映射表字段
               String precision=(ObjectUtil.isNotEmpty(controlSteward.getControlPrecision())&& controlSteward.getControlPrecision()!=0)?
                       ",".concat(controlSteward.getControlPrecision()+""):"";
               vFieldCounts.add(String.join("", String.valueOf(ProcessJsonMode.get("field_current")).concat(" "),
                                  controlSteward.getControlFieldType(),"(",String.valueOf(controlSteward.getControlFieldLength()),precision,")"));

           }else {
               throw new NullPointerException("目前组件为"+ProcessJsonMode.get("config_tag_icon")+"没有控件表,请去控件大管家新增!");
           }
        }

        //:fixme 创建业务数据映射表
        for (int i = controlFields.size(); i < settings.getFieldLength(); ++i) {
            vFieldCounts.add( String.join("", ("field"+Integer.sum(i,1)).concat(" "),"tinyint") );
        }
        formExtendDesignMapper.createTable(settings.getDataMappingTablePrepend().concat(settings.getDataMappingTable()),
                vFieldCounts.isEmpty()?"":String.join(",",vFieldCounts));


        //:fixme 修改vue渲染所需数据与ID
        formExtendMapper.update(new FormExtend()
                .setDrawingControls(JSONUtil.toJsonStr(formExtendDesignDto.getOriginJsonMode().getDrawingControls()))
                .setIdGlobal(formExtendDesignDto.getIdGlobal())
                .setTreeNodeId(formExtendDesignDto.getTreeNodeId())
                .setUpdateBy(SecurityUtil.getUser().getUsername()).setUpdateTime(new Date()),
                Wrappers.<FormExtend>lambdaUpdate().eq(FormExtend::getId,formExtendDesignDto.getFormExtendId()));

        //:fixme 新增数据配置
        dataConfMapper.insert(new DataConf()
                .setFormExtendId(formExtendDesignDto.getFormExtendId())
                .setDataMappingTablePrepend(settings.getDataMappingTablePrepend())
                .setDataMappingTable(settings.getDataMappingTable())
                .setFieldLength(settings.getFieldLength()));

        return 0;
    }


    @Override
    public int update(FormExtendDesignDto formExtendDesignDto) {
        //:fixme 校验
        Optional.ofNullable(formExtendDesignDto.getJsonMode()).orElseThrow(()->new NullPointerException("Json数据模型不能为空!"));
        //:todo 初始化局部变量
        JsonMode JsonMode=formExtendDesignDto.getJsonMode();
        DataConf settings= JsonMode.getDataConf();
        List<ControlSteward> ControlsInfo= controlStewardMapper.selectList(Wrappers.<ControlSteward>lambdaQuery().orderByAsc(ControlSteward::getId));
        DataConf dataConf=dataConfMapper.selectOne(Wrappers.<DataConf>lambdaQuery().eq(DataConf::getFormExtendId,formExtendDesignDto.getFormExtendId()));
        List<String> businessTableFieldsList=formExtendDesignMapper.selectBusinessTableFields(dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()));
        List<String> vFieldCounts=new ArrayList<>();
        List<Map<String,Object>> controlFields=JsonMode.getOptionPool(), addedPool=new ArrayList<>(),
                                 modifiedPool=new ArrayList<>(), removedPool=new ArrayList<>();
        AtomicInteger reduce=new AtomicInteger(0);

        //:todo 处理数据记录池,筛选数据
        StreamSupport.stream(controlFields.spliterator(),true).forEach(item->{
            switch (item.get("_state").toString()){
                case "added":
                    addedPool.add(item);
                    break;
                case "modified":
                    modifiedPool.add(item);
                    break;
                case "removed":
                    removedPool.add(item);
                    break;
            }
        });

        //:fixme 删除处理逻辑
        for (int i = 0; i < removedPool.size(); ++i) {
            Map<String,Object> item=removedPool.get(i);
            Map<String,Object> ProcessJsonMode=new HashMap();
            ProcessJsonMode(item,ProcessJsonMode,null);
            ControlSteward controlSteward = StreamSupport.stream(ControlsInfo.spliterator(),true)
                    .filter(e-> e.getControlTagIcon().equals(ProcessJsonMode.get("config_tag_icon")))
                    .collect(Collectors.toList()).stream().findFirst().orElse(null);
            if(ObjectUtil.isNotEmpty(controlSteward)){
                //格式化业务映射表字段,为后续控件修改做准备
                Map<String,Object> control=formExtendDesignMapper.selectSingleControlsMappingTable(controlSteward.getControlMappingTable(),
                        formExtendDesignDto.getFormExtendId(),Long.valueOf(ProcessJsonMode.get("config_form_id")+"")).stream().findFirst().orElse(null);
                if(ObjectUtil.isNotEmpty(control)){
                    formExtendDesignMapper.settingsFieldNull(dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()),
                            String.valueOf(control.get("field_current")));
                }
                //删除控件
                int r=formExtendDesignMapper.deleteSingleControlsMappingTable(controlSteward.getControlMappingTable(),
                        formExtendDesignDto.getFormExtendId(),Long.valueOf(ProcessJsonMode.get("config_form_id")+""));
            }else {
                throw new NullPointerException("目前组件为"+ProcessJsonMode.get("config_tag_icon")+"没有控件表,请去控件大管家新增!");
            }
        }

        //:fixme 修改处理逻辑
        for (int i = 0; i < modifiedPool.size(); ++i) {
            Map<String,Object> item=modifiedPool.get(i);
            Map<String,Object> ProcessJsonMode=new HashMap();
            ProcessJsonMode(item,ProcessJsonMode,null);
            ControlSteward controlSteward = StreamSupport.stream(ControlsInfo.spliterator(),true)
                    .filter(e-> e.getControlTagIcon().equals(ProcessJsonMode.get("config_tag_icon")))
                    .collect(Collectors.toList()).stream().findFirst().orElse(null);
            if(ObjectUtil.isNotEmpty(controlSteward)){
                //生成修改所需的数据
                ProcessJsonMode.put("field_length",settings.getFieldLength());
                ProcessJsonMode.put("data_mapping_table",settings.getDataMappingTablePrepend().concat(settings.getDataMappingTable()));
                ProcessJsonMode.put("data_mapping_table_prefix",settings.getDataMappingTablePrepend());
                ProcessJsonMode.put("data_mapping_table_suffix",settings.getDataMappingTable());
                List<String> TableFields=formExtendDesignMapper.selectTableFields(controlSteward.getControlMappingTable());
                //修改控件
                int r=formExtendDesignMapper.updateControlsMappingTable(TableFields,
                        controlSteward.getControlMappingTable(),
                        ProcessJsonMode,
                        formExtendDesignDto.getFormExtendId(),
                        Long.valueOf(ProcessJsonMode.get("config_form_id")+""));
            }else {
                throw new NullPointerException("目前组件为"+ProcessJsonMode.get("config_tag_icon")+"没有控件表,请去控件大管家新增!");
            }
        }

        //:fixme 新增处理逻辑
        for (int i = 0; i < addedPool.size(); ++i) {
            Map<String,Object> item=addedPool.get(i);
            Map<String,Object> ProcessJsonMode=new HashMap();
            ProcessJsonMode(item,ProcessJsonMode,null);
            //本单扩展的所有控件
            Set<String> AllControlsMappingTableFieldCurrent=new HashSet<>();
            ControlSteward controlSteward =null;
            for (int m = 0; m < ControlsInfo.size(); ++m) {
                ControlSteward model=ControlsInfo.get(m);
                AllControlsMappingTableFieldCurrent.addAll(
                        formExtendDesignMapper.selectAllControlsMappingTableFieldCurrent(model.getControlMappingTable(),formExtendDesignDto.getFormExtendId()));
                if(model.getControlTagIcon().equals(ProcessJsonMode.get("config_tag_icon"))){
                    controlSteward =model;
                }
            }
            if(ObjectUtil.isNotEmpty(controlSteward)){
                //动态检测是否需要补位
                AtomicReference<String> write= new AtomicReference<>("");

                businessTableFieldsList.stream().anyMatch(element->{
                    if(!AllControlsMappingTableFieldCurrent.stream().anyMatch(e->element.equals(e))){
                        write.set(element);
                        reduce.set(Integer.sum(reduce.get(),1));
                       return true;
                    }
                    return false;
                });
                //计算求出当前业务映射表字段
                String fieldCurrent= StrUtil.isEmpty(write.get()) ? "field" + Integer.sum((i+1)-reduce.get(), businessTableFieldsList.size())  : write.get();
                //生成新增所需的数据
                ProcessJsonMode.put("field_length",settings.getFieldLength());
                ProcessJsonMode.put("field_current",fieldCurrent);
                ProcessJsonMode.put("data_mapping_table",settings.getDataMappingTablePrepend().concat(settings.getDataMappingTable()));
                ProcessJsonMode.put("create_by", SecurityUtil.getUser().getUsername());
                ProcessJsonMode.put("form_extend_id",formExtendDesignDto.getFormExtendId());
                ProcessJsonMode.put("data_mapping_table_prefix",settings.getDataMappingTablePrepend());
                ProcessJsonMode.put("data_mapping_table_suffix",settings.getDataMappingTable());

                List<String> TableFields=formExtendDesignMapper.selectTableFields(controlSteward.getControlMappingTable());
                //新增控件
                int r=formExtendDesignMapper.insertControlsMappingTable(TableFields, controlSteward.getControlMappingTable(),ProcessJsonMode);
                //是否是补位控件[是:修改控件使用的业务映射表字段类型,否:新增业务映射表字段]
                String precision=(ObjectUtil.isNotEmpty(controlSteward.getControlPrecision())&& controlSteward.getControlPrecision()!=0)?
                        ",".concat(controlSteward.getControlPrecision()+""):"";
                if(StrUtil.isNotEmpty(write.get())){
                    formExtendDesignMapper.updateFieldType(dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()),
                        String.join("", String.valueOf(ProcessJsonMode.get("field_current")).concat(" "),
                        controlSteward.getControlFieldType(),"(",String.valueOf(controlSteward.getControlFieldLength()),precision,")") );
                }else{
                    vFieldCounts.add(String.join("", String.valueOf(ProcessJsonMode.get("field_current")).concat(" "),
                        controlSteward.getControlFieldType(),"(",String.valueOf(controlSteward.getControlFieldLength()),precision,")") );
                }
            }else {
                throw new NullPointerException("目前组件为"+ProcessJsonMode.get("config_tag_icon")+"没有控件表,请去控件大管家新增!");
            }
        }


        //:fixme 修改业务映射表结构,重命名
        if(Long.compare(dataConf.getFieldLength(),settings.getFieldLength())==-1){
            for (long i = Long.sum(dataConf.getFieldLength(),vFieldCounts.size()); i < settings.getFieldLength(); ++i) {
                vFieldCounts.add(String.join("", ("field"+Long.sum(i,1)).concat(" "),"tinyint"));
            }
            formExtendDesignMapper.insertFieldType(settings.getDataMappingTablePrepend().concat(settings.getDataMappingTable()),
                    String.join("","(",String.join(",",vFieldCounts),")"));
        }
        if(StrUtil.compare(settings.getDataMappingTablePrepend().concat(settings.getDataMappingTable()),
                dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()),true)!=0){
            formExtendDesignMapper.reTableName(dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()),
                    settings.getDataMappingTablePrepend().concat(settings.getDataMappingTable()));
        }

        //:fixme 修改vue渲染所需数据与ID
        formExtendMapper.update(new FormExtend()
                .setDrawingControls(JSONUtil.toJsonStr(formExtendDesignDto.getOriginJsonMode().getDrawingControls()))
                .setIdGlobal(formExtendDesignDto.getIdGlobal())
                .setTreeNodeId(formExtendDesignDto.getTreeNodeId())
                .setUpdateBy(SecurityUtil.getUser().getUsername()).setUpdateTime(new Date()),
                Wrappers.<FormExtend>lambdaUpdate().eq(FormExtend::getId,formExtendDesignDto.getFormExtendId()));
        //:fixme 修改数据配置
        dataConfMapper.update(new DataConf()
                .setDataMappingTablePrepend(settings.getDataMappingTablePrepend())
                .setDataMappingTable(settings.getDataMappingTable())
                .setFieldLength(settings.getFieldLength()),
                Wrappers.<DataConf>lambdaUpdate().eq(DataConf::getFormExtendId,formExtendDesignDto.getFormExtendId()));

        return 0;
    }


    @Override
    public int delete(Long formExtendId) {
        //:fixme 校验
        Optional.ofNullable(formExtendId).orElseThrow(()->new NullPointerException("表单扩展字段不能为空!"));
        //:todo 初始化局部变量
        List<ControlSteward> ControlsInfo= controlStewardMapper.selectList(Wrappers.<ControlSteward>lambdaQuery().orderByAsc(ControlSteward::getId));
        DataConf dataConf=dataConfMapper.selectOne(Wrappers.<DataConf>lambdaQuery().eq(DataConf::getFormExtendId,formExtendId));
        if(ObjectUtil.isNotEmpty(dataConf)){
            //:fixme 删除业务数据映射表
            formExtendDesignMapper.deleteTable(dataConf.getDataMappingTablePrepend().concat(dataConf.getDataMappingTable()));
            //:fixme 删除表单控件
            ControlsInfo.forEach(element->{
                formExtendDesignMapper.deleteControlsMappingTable(element.getControlMappingTable(),formExtendId);
            });
            //:fixme 删除数据配置
            dataConfMapper.delete(Wrappers.<DataConf>lambdaQuery().eq(DataConf::getFormExtendId,formExtendId));
        }
        return 0;
    }


    @Override
    public void ProcessJsonMode(Map<String,Object> TempJsonMode, Map<String,Object> ProcessJsonMode,
                                String ProcessKey){
        for (Map.Entry<String, Object> entry : TempJsonMode.entrySet()) {
            if(entry.getValue() instanceof java.util.Map){
                ProcessJsonMode((Map<String, Object>) entry.getValue(),
                        ProcessJsonMode,
                        String.join(Optional.ofNullable(ProcessKey).map(item->"_").orElse(""),
                                    Optional.ofNullable(ProcessKey).orElse(""),
                                    StrUtil.toUnderlineCase(entry.getKey().replace("_","")).replaceAll("([-])+","_")));
            }
            if(!(entry.getValue() instanceof java.util.Map)){
                ProcessJsonMode.put(String.join(Optional.ofNullable(ProcessKey).map(item->"_").orElse(""),
                        Optional.ofNullable(ProcessKey).orElse(""),
                        StrUtil.toUnderlineCase(entry.getKey().replace("_","")).replaceAll("([-])+","_")),
                        entry.getValue());
            }
        }
    }


    @Override
    public int validatorBusinessTable(String tableName) {
        return formExtendDesignMapper.validatorBusinessTable(tableName.trim());
    }


}
