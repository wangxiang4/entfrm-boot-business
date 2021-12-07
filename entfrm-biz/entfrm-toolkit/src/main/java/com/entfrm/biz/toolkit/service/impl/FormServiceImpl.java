package com.entfrm.biz.toolkit.service.impl;

import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.base.constant.GenConstants;
import com.entfrm.base.util.DateUtil;
import com.entfrm.base.util.StrUtil;
import com.entfrm.biz.toolkit.entity.Column;
import com.entfrm.biz.toolkit.entity.Form;
import com.entfrm.biz.toolkit.mapper.FormMapper;
import com.entfrm.biz.toolkit.service.ColumnService;
import com.entfrm.biz.toolkit.service.FormService;
import com.entfrm.biz.toolkit.service.TableService;
import com.entfrm.biz.toolkit.util.BuilderUtil;
import com.entfrm.security.entity.EntfrmUser;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author entfrm
 * @date 2021-03-11 21:57:03
 * @description 表单管理Service业务层
 */
@Service
@AllArgsConstructor
public class FormServiceImpl extends ServiceImpl<FormMapper, Form> implements FormService {

    private final JdbcTemplate jdbcTemplate;
    private final TableService tableService;
    private final ColumnService columnService;

    @Override
    public Page<Form> customFormPage(Page<Form> page, Form form) {
        return page.setRecords(baseMapper.selectCustomQuery(page, form));
    }

    @Override
    public Page<Map> mapFormPage(Page page, Form form, String params) {
        form = baseMapper.selectOne(new QueryWrapper<Form>().eq("table_name", form.getTableName()));
        String fields = "";
        List<Column> columns = BuilderUtil.createColumns(form.getData());
        for (Column column : columns) {
            if ("1".equals(column.getIsList())) {
                fields += column.getColumnName() + ",";
            }
        }
        if (StrUtil.isNotBlank(fields)) {
            fields = fields.substring(0, fields.length() - 1);
        }
        int total = jdbcTemplate.queryForObject("select count(1) from " + CommonConstants.PREFIX + form.getTableName() + " where del_flag = 0", Integer.class);
        page.setTotal(total);
        String pageSql = "select " + fields + " from " + CommonConstants.PREFIX + form.getTableName() + " where del_flag = 0 limit " + (page.getCurrent() - 1) * page.getSize() + "," + page.getSize();
        //todo 构建条件查询sql

        List<Map<String, Object>> mapList = jdbcTemplate.queryForList(pageSql);
        page.setRecords(mapList);
        return page;
    }

    @Override
    public Map queryData(String tableName, Integer id) {
        String originalSql = "select * from " + CommonConstants.PREFIX + tableName + " where id = '" + id + "'";
        Map map = jdbcTemplate.queryForMap(originalSql);
        return map;
    }

    @Override
    public void saveData(Form form, List<Column> columns, String data) {
        JSONObject jData = JSONUtil.parseObj(data);
        String insertSql = "insert into " + CommonConstants.PREFIX + form.getTableName() + "(";
        String insertSqlValue = " values(";
        EntfrmUser user = SecurityUtil.getUser();
        for (Column column : columns) {
            if (!StrUtil.containsAny(column.getColumnName(), GenConstants.COLUMNNAME_NOT_EDIT) && StrUtil.equals(column.getIsAdd(), "1")) {
                insertSql += column.getColumnName() + ",";
                if (StrUtil.endWithAny(column.getJavaType(), "Integer", "Long")) {
                    insertSqlValue += "" + jData.get(column.getJavaField()) + ",";
                } else {
                    insertSqlValue += "'" + jData.get(column.getJavaField()) + "',";
                }
            }
            if (StrUtil.equals(column.getColumnName(), "create_by") && user != null) {
                insertSql += "create_by,";
                insertSqlValue += "'" + user.getUsername() + "',";
            }
            if (StrUtil.equals(column.getColumnName(), "create_time")) {
                insertSql += "create_time,";
                insertSqlValue += "'" + DateUtil.formatDateTime(new Date()) + "',";
            }
        }
        insertSql = insertSql.substring(0, insertSql.length() - 1);
        insertSqlValue = insertSqlValue.substring(0, insertSqlValue.length() - 1);
        insertSql += ")" + insertSqlValue + ")";
        jdbcTemplate.execute(insertSql);
    }

    @Override
    public void removeData(String tableName, Integer[] ids) {
        String deleteSql = "delete from " + CommonConstants.PREFIX + tableName + " where id in ( ";
        String idArra = "";
        for (Integer id : ids) {
            idArra = idArra + "'" + id + "',";
        }
        idArra = idArra.substring(0, idArra.length() - 1);
        deleteSql = deleteSql + idArra + " ) ";
        jdbcTemplate.execute(deleteSql);
    }
}
