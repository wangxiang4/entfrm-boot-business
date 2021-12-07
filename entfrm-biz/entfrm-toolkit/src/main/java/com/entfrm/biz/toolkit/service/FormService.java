package com.entfrm.biz.toolkit.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.entfrm.biz.toolkit.entity.Column;
import com.entfrm.biz.toolkit.entity.Form;

import java.util.List;
import java.util.Map;

/**
 * @author entfrm
 * @date 2021-03-11 21:57:03
 * @description 表单管理Service接口
 */
public interface FormService extends IService<Form> {
    Page<Form> customFormPage(Page<Form> page, Form form);

    Page<Map> mapFormPage(Page page, Form form, String params);

    Map queryData(String tableName, Integer id);

    void saveData(Form form, List<Column> columns, String data);

    void removeData(String tableName, Integer[] ids);
}
