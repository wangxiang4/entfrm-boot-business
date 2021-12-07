package com.entfrm.biz.intelligent.dto;

import com.entfrm.biz.intelligent.entity.DataConf;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * JSON模型
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/2/18
 */
@Data
@Accessors(chain = true)
public class JsonMode {

   /**
    * 目前表单内所有的控件数据
    */
   private List<Map<String,Object>> drawingControls;

   /**
    * 操作池数据
    */
   private List<Map<String,Object>> optionPool;

   /**
    * 数据配置数据
    */
   private DataConf dataConf;

}
