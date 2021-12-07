package com.entfrm.biz.intelligent.service.impl;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.intelligent.entity.ControlSteward;
import com.entfrm.biz.intelligent.mapper.ControlStewardMapper;
import com.entfrm.biz.intelligent.service.FormExtendDesignService;
import com.entfrm.biz.intelligent.service.ControlStewardService;
import com.entfrm.biz.intelligent.util.CustomizeFieldType;
import com.entfrm.biz.intelligent.util.DataBaseType;
import com.entfrm.biz.intelligent.util.ProcessUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * <p>
 * 控件大管家实现
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/3/27
 */
@Service
@AllArgsConstructor
public class ControlStewardServiceImpl extends ServiceImpl<ControlStewardMapper, ControlSteward> implements ControlStewardService {

    private final FormExtendDesignService formExtendDesignService;


    private final ControlStewardMapper controlStewardMapper;


    @Override
    public int createControlsTable(String TableName,String json) {
        List<String> fieldList=new ArrayList<>();
        Map<String,Object> processJsonMode=new HashMap<>();
        Map<String,Object> item= JSONUtil.toBean(json,Map.class);
        formExtendDesignService.ProcessJsonMode(item,processJsonMode,null);
        for (Map.Entry<String,Object> element:processJsonMode.entrySet()){
            CustomizeFieldType[] customizeFieldTypes=CustomizeFieldType.values();
            if(!Arrays.stream(customizeFieldTypes).anyMatch(match->{
                if(match.getField().equals(element.getKey())){
                    DataBaseType dataBaseType=match.getDataBaseType();
                    String fieldType=String.join("",dataBaseType.getFieldType(),"(",String.valueOf(dataBaseType.getFieldLength()),")");
                    fieldList.add(String.join("","`",element.getKey(),"` ",fieldType));
                    return true;
                }
                return false;
            })){
                DataBaseType dataBaseType=ProcessUtil.fetchFieldType(element.getValue());
                String fieldType=String.join("",dataBaseType.getFieldType(),"(",String.valueOf(dataBaseType.getFieldLength()),")");
                fieldList.add(String.join("","`",element.getKey(),"` ",fieldType));
            }
        }
        int r= controlStewardMapper.createControlsTable(TableName,fieldList);
        return 0;
    }

    @Override
    public int deleteControlsTable(Integer[] ids) {
       List<ControlSteward>  ControlsList= this.getBaseMapper().selectList(new LambdaQueryWrapper<ControlSteward>()
        .in(ControlSteward::getId,ids));
       if(ControlsList.size()>0){
           List<String> Tables=new ArrayList<>();
           ControlsList.forEach(item->Tables.add(item.getControlMappingTable()));
           int r= controlStewardMapper.deleteControlsTable(Tables);
       }
       return 0;
    }

    @Override
    public int selectControlsTable(String Table) {
        return controlStewardMapper.selectControlsTable(Table);
    }
}
