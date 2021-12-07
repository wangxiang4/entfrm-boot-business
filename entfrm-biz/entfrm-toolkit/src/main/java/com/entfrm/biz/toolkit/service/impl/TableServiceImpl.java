package com.entfrm.biz.toolkit.service.impl;

import cn.hutool.core.io.IoUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.base.constant.GenConstants;
import com.entfrm.base.constant.SqlConstants;
import com.entfrm.base.exception.BaseException;
import com.entfrm.base.util.FileUtil;
import com.entfrm.base.util.StrUtil;
import com.entfrm.biz.toolkit.config.GenConfig;
import com.entfrm.biz.toolkit.entity.Column;
import com.entfrm.biz.toolkit.entity.Table;
import com.entfrm.biz.toolkit.mapper.TableMapper;
import com.entfrm.biz.toolkit.service.ColumnService;
import com.entfrm.biz.toolkit.service.TableService;
import com.entfrm.biz.toolkit.util.BuilderUtil;
import com.entfrm.biz.toolkit.util.GenUtil;
import com.entfrm.biz.toolkit.util.VelocityInitializer;
import com.entfrm.biz.toolkit.util.VelocityUtil;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import static com.entfrm.biz.toolkit.util.GenUtil.*;

/**
 * 业务 服务层实现
 */
@Slf4j
@Service
@AllArgsConstructor
public class TableServiceImpl extends ServiceImpl<TableMapper, Table> implements TableService {

    private final ColumnService columnService;
    private final JdbcTemplate jdbcTemplate;

    /**
     * 生成表、列数据
     *
     * @param tableName 表名
     */
    @Override
    @Transactional
    public Table getGenTable(String tableName, String tableComment) {
        Table table = new Table();
        if (StrUtil.isBlank(tableName)) {
            table.setPackageName(GenConfig.getPackageName());
            table.setFunctionAuthor(GenConfig.getAuthor());
            table.setTplCategory("crud");
            table.setCols("24");
            table.setGenApi("0");
            table.setGenWay("1");
            table.setColumns(GenUtil.initColumns());
        } else {
            table = baseMapper.selectOne(new QueryWrapper<Table>().eq("table_name", tableName).orderByDesc("create_time").last("limit 1"));
            if (table != null) {
                List<Column> list = columnService.list(new QueryWrapper<Column>().eq(!StrUtil.isBlankIfStr(table.getId()), "table_id", table.getId()).orderByAsc("sort"));
                table.setColumns(list);
            } else {
                table = new Table();
                //表信息新增
                table.setTableName(tableName);
                table.setTableComment(tableComment);
                if ("true".equals(GenConfig.getAutoRemovePre()) && StrUtil.isNotBlank(GenConfig.getTablePrefix())) {
                    table.setClassName(StrUtil.upperFirst(StrUtil.toCamelCase(StrUtil.replace(table.getTableName(), GenConfig.getTablePrefix(), ""))));
                } else {
                    table.setClassName(StrUtil.upperFirst(StrUtil.toCamelCase(table.getTableName())));
                }
                table.setPackageName(GenConfig.getPackageName());
                table.setModuleName(getModuleName(GenConfig.getPackageName()));
                table.setBusinessName(StrUtil.lowerFirst(table.getClassName()));
                table.setFunctionName(replaceText(table.getTableComment()));
                table.setFunctionAuthor(GenConfig.getAuthor());
                table.setTplCategory("crud");
                table.setCols("24");
                table.setGenApi("0");
                table.setGenWay("1");
                table.setCreateBy(SecurityUtil.getUser().getUsername());
                baseMapper.insert(table);
                //表列 信息新增
                List<Column> columns = columnService.selectDbColumnsByName(tableName);
                List<Column> list = new ArrayList<>();
                for (Column column : columns) {
                    String dataType = getDbType(column.getColumnType());
                    String columnName = column.getColumnName();
                    column.setTableId(table.getId());
                    column.setCreateBy(table.getCreateBy());
                    // 设置java字段名
                    column.setJavaField(StrUtil.toCamelCase(columnName));

                    if (arraysContains(GenConstants.COLUMNTYPE_STR, dataType)) {
                        column.setJavaType(GenConstants.TYPE_STRING);
                        // 字符串长度超过255设置为文本域
                        Integer columnLength = getColumnLength(column.getColumnType());
                        String htmlType = columnLength >= 255 ? GenConstants.HTML_TEXTAREA : GenConstants.HTML_INPUT;
                        column.setHtmlType(htmlType);
                    } else if (arraysContains(GenConstants.COLUMNTYPE_TIME, dataType)) {
                        column.setJavaType(GenConstants.TYPE_DATE);
                        column.setHtmlType(GenConstants.HTML_DATETIME);
                    } else if (arraysContains(GenConstants.COLUMNTYPE_NUMBER, dataType)) {
                        column.setHtmlType(GenConstants.HTML_INPUT);

                        // 如果是浮点型
                        String[] str = StrUtil.split(StrUtil.subBetween(column.getColumnType(), "(", ")"), ",");
                        if (str != null && str.length == 2 && Integer.parseInt(str[1]) > 0) {
                            column.setJavaType(GenConstants.TYPE_DOUBLE);
                        }
                        // 如果是整形
                        else if (str != null && str.length == 1 && Integer.parseInt(str[0]) <= 11) {
                            column.setJavaType(GenConstants.TYPE_INTEGER);
                        }
                        // 长整形
                        else {
                            column.setJavaType(GenConstants.TYPE_LONG);
                        }
                    }

                    // 插入字段
                    if (!arraysContains(GenConstants.COLUMNNAME_NOT_EDIT, columnName) && !StrUtil.equals("1", column.getIsPk())) {
                        column.setIsAdd(GenConstants.REQUIRE);
                    }

                    // 编辑字段
                    if (!arraysContains(GenConstants.COLUMNNAME_NOT_EDIT, columnName) && !StrUtil.equals("1", column.getIsPk())) {
                        column.setIsEdit(GenConstants.REQUIRE);
                    }
                    // 列表字段
                    if (!arraysContains(GenConstants.COLUMNNAME_NOT_LIST, columnName) && !StrUtil.equals("1", column.getIsPk())) {
                        column.setIsList(GenConstants.REQUIRE);
                    }
                    // 查询字段
                    if (!arraysContains(GenConstants.COLUMNNAME_NOT_QUERY, columnName) && !StrUtil.equals("1", column.getIsPk())) {
                        column.setIsQuery(GenConstants.REQUIRE);
                    }

                    // 查询字段类型
                    if (StrUtil.endWithIgnoreCase(columnName, "name")) {
                        column.setQueryType(GenConstants.QUERY_LIKE);
                    } else if (StrUtil.endWithIgnoreCase(columnName, "createTime")) {
                        column.setQueryType(GenConstants.QUERY_BETWEEN);
                    } else {
                        column.setQueryType(GenConstants.QUERY_EQ);
                    }

                    // 状态字段设置单选框
                    if (StrUtil.endWithIgnoreCase(columnName, "status")) {
                        column.setHtmlType(GenConstants.HTML_RADIO);
                    }
                    // 类型&性别字段设置下拉框
                    else if (StrUtil.endWithIgnoreCase(columnName, "type")
                            || StrUtil.endWithIgnoreCase(columnName, "sex")) {
                        column.setHtmlType(GenConstants.HTML_SELECT);
                    }
                    columnService.save(column);
                    list.add(column);
                }
                table.setColumns(list);
            }
        }
        String genPath = StrUtil.isNotBlank(table.getGenPath()) ? table.getGenPath() : System.getProperty("user.dir");
        table.setGenPath(genPath);
        List<Table> tables = baseMapper.selectList(new QueryWrapper<Table>());
        for (Table table1 : tables) {
            List<Column> list = columnService.list(new QueryWrapper<Column>().eq("table_id", table1.getId()).orderByAsc("sort"));
            table1.setColumns(list);
        }
        table.setTables(tables);
        List<Map<String, Object>> list = jdbcTemplate.queryForList(SqlConstants.MENU_TREE);
        table.setMenus(list);
        return table;
    }

    /**
     * 修改保存参数校验
     *
     * @param table 业务信息
     */
    public void validateEdit(Table table) {
        if (GenConstants.TPL_TREE.equals(table.getTplCategory())) {
            String options = JSONUtil.toJsonStr(table.getParams());
            JSONObject paramsObj = JSONUtil.parseObj(options);
            if (StrUtil.isEmpty(paramsObj.getStr(GenConstants.TREE_ID))) {
                throw new BaseException("树编号字段不能为空");
            } else if (StrUtil.isEmpty(paramsObj.getStr(GenConstants.TREE_PARENT_ID))) {
                throw new BaseException("树父编号字段不能为空");
            } else if (StrUtil.isEmpty(paramsObj.getStr(GenConstants.TREE_NAME))) {
                throw new BaseException("树名称字段不能为空");
            }
        }
    }

    /**
     * 修改业务
     *
     * @param table 业务信息
     * @return 结果
     */
    @Override
    @Transactional
    public void updateTable(Table table) {
        String options = JSONUtil.toJsonStr(table.getParams());
        table.setOptions(options);
        if (StrUtil.isBlankIfStr(table.getId())) {
            int row = baseMapper.insert(table);
            if (row > 0) {
                for (Column column : table.getColumns()) {
                    if (StrUtil.isNotEmpty(column.getColumnName())) {
                        column.setId(null);
                        column.setTableId(table.getId());
                        column.setJavaField(StrUtil.toCamelCase(column.getColumnName()));
                        columnService.save(column);
                    }
                }
            }
            //创建数据库表结构
            jdbcTemplate.execute(BuilderUtil.createTable(table));
        } else {
            //Table oldTable = baseMapper.selectById(table.getId());
            int row = baseMapper.updateById(table);
            if (row > 0) {
                //判断是否有删除字段
                if (StrUtil.isNotEmpty(table.getDelNames())) {
                    for (String columnName : StrUtil.split(table.getDelNames(), ",")) {
                        columnService.remove(new QueryWrapper<Column>().eq("table_id", table.getId()).eq("column_name", columnName));
                    }
                }
                //更新数据库表结构，
                /*if (oldTable != null) {
                    //方案一：删除重建，删除更新之前的表信息
                    //jdbcTemplate.execute("drop table " + oldTable.getTableName() + ";");
                    //方案二：备份原表重建
                    String newTableName = oldTable.getTableName() + DateUtil.format(new Date(), DatePattern.PURE_TIME_PATTERN);
                    jdbcTemplate.execute("rename  table " + oldTable.getTableName() + " to " + newTableName + ";");
                }
                jdbcTemplate.execute(BuilderUtil.createTable(table));*/
                //直接更新表结构
                jdbcTemplate.execute(BuilderUtil.updateTable(table));
                for (Column column : table.getColumns()) {
                    if (StrUtil.isNotEmpty(column.getColumnName())) {
                        column.setTableId(table.getId());
                        column.setJavaField(StrUtil.toCamelCase(column.getColumnName()));
                        columnService.saveOrUpdate(column);
                    }
                }
            }
        }
    }

    /**
     * 删除业务对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    @Transactional
    public void deleteTableByIds(String ids) {
        baseMapper.deleteBatchIds(Arrays.asList(ids.split(",")));
        columnService.deleteColumnByTableIds(ids);
    }

    /**
     * 预览代码
     *
     * @param tableName 表名
     * @return 预览数据列表
     */
    public Map<String, String> previewCode(String tableName) {
        Map<String, String> dataMap = new LinkedHashMap<>();
        // 查询表信息
        Table table = baseMapper.selectOne(new QueryWrapper<Table>().eq("table_name", tableName));
        // 查询列信息
        List<Column> columns = columnService.list(new QueryWrapper<Column>().eq("table_id", table.getId()));
        table.setColumns(columns);
        // 加载主子表信息
        loadSubTable(table);
        setPkColumn(table, columns);
        VelocityInitializer.initVelocity();

        VelocityContext context = VelocityUtil.prepareContext(table);

        // 获取模板列表
        List<String> templates = VelocityUtil.getTemplateList(table.getTplCategory());
        for (String template : templates) {
            // 渲染模板
            StringWriter sw = new StringWriter();
            Template tpl = Velocity.getTemplate(template, CommonConstants.UTF8);
            tpl.merge(context, sw);
            dataMap.put(template, sw.toString());
        }
        return dataMap;
    }

    /**
     * 批量生成代码
     *
     * @param tableNames 表数组
     * @return 数据
     */
    @Override
    public byte[] genCode(String[] tableNames) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        ZipOutputStream zip = new ZipOutputStream(outputStream);
        for (String tableName : tableNames) {
            genCode(tableName, zip);
        }
        IoUtil.close(zip);
        return outputStream.toByteArray();
    }

    /**
     * 查询表信息并生成代码
     */
    private void genCode(String tableName, ZipOutputStream zip) {
        // 查询表信息
        Table table = baseMapper.selectOne(new QueryWrapper<Table>().eq("table_name", tableName));
        if (table != null) {
            //加载主子表
            loadSubTable(table);
            // 查询列信息
            List<Column> columns = columnService.list(new QueryWrapper<Column>().eq("table_id", table.getId()).orderByAsc("sort"));
            setPkColumn(table, columns);
            table.setColumns(columns);

            VelocityInitializer.initVelocity();

            VelocityContext context = VelocityUtil.prepareContext(table);

            // 获取模板列表
            List<String> templates = VelocityUtil.getTemplateList(table.getTplCategory());
            for (String template : templates) {
                // 渲染模板
                StringWriter sw = new StringWriter();
                Template tpl = Velocity.getTemplate(template, CommonConstants.UTF8);
                tpl.merge(context, sw);
                try {
                    // 添加到zip
                    zip.putNextEntry(new ZipEntry(VelocityUtil.getFileName(template, table)));
                    IoUtil.write(zip, CommonConstants.UTF8, false, sw.toString());
                    IoUtil.close(sw);
                    zip.closeEntry();
                } catch (IOException e) {
                    log.error("渲染模板失败，表名：" + table.getTableName(), e);
                }
            }
        }
    }

    @Override
    public String genToLocal(String[] tableNames) {
        StringBuilder result = new StringBuilder();
        result.append("生成结果：");
        for (String tableName : tableNames) {
            result.append(genToFile(tableName));
        }
        return result.toString();
    }

    private String genToFile(String tableName) {
        // 查询表信息
        Table table = baseMapper.selectOne(new QueryWrapper<Table>().eq("table_name", tableName));
        if (table != null) {
            //加载主子表
            loadSubTable(table);
            // 查询列信息
            List<Column> columns = columnService.list(new QueryWrapper<Column>().eq("table_id", table.getId()).orderByAsc("sort"));
            setPkColumn(table, columns);
            table.setColumns(columns);

            VelocityInitializer.initVelocity();

            VelocityContext context = VelocityUtil.prepareContext(table);

            // 获取模板列表
            List<String> templates = VelocityUtil.getTemplateList(table.getTplCategory());
            for (String template : templates) {
                // 渲染模板
                StringWriter sw = new StringWriter();
                Template tpl = Velocity.getTemplate(template, CommonConstants.UTF8);
                tpl.merge(context, sw);
                // 生成文件到本地
                String localFile = "";
                String sqlPath = "";
                if (StrUtil.containsAny(template, "vue", "js")) {
                    localFile = table.getGenPath().replace("\\", "/") + "/entfrm-ui/" + VelocityUtil.getFileName(template, table).replace("vue/", "src/");
                } else if (StrUtil.contains(template, "sql")) {
                    localFile = table.getGenPath().replace("\\", "/") + "/entfrm-biz/entfrm-" + table.getModuleName() + "/sql/" + VelocityUtil.getFileName(template, table);
                    sqlPath = localFile;
                } else {
                    localFile = table.getGenPath().replace("\\", "/") + "/entfrm-biz/entfrm-" + table.getModuleName() + "/src/" + VelocityUtil.getFileName(template, table);
                }
                IoUtil.write(FileUtil.getOutputStream(localFile), CommonConstants.UTF8, false, sw.toString());
                IoUtil.close(sw);
                //查询菜单是否创建
                List<Map<String, Object>> maps = jdbcTemplate.queryForList("select * from sys_menu where name = ? and del_flag='0'", table.getFunctionName());
                if (maps.size() == 0) {
                    //执行生成菜单脚本
                    if (StrUtil.isNotBlank(sqlPath)) {
                        try {
                            List<String> sqlList = StrUtil.loadSql(sqlPath);
                            jdbcTemplate.batchUpdate(StrUtil.join(sqlList.toArray(), ""));
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
            return tableName + "成功 ";
        } else {
            return tableName + "表不存在 ";
        }
    }

    /**
     * 设置主键列信息
     *
     * @param table   业务表信息
     * @param columns 业务字段列表
     */
    public void setPkColumn(Table table, List<Column> columns) {
        for (Column column : columns) {
            if (StrUtil.equals("1", column.getIsPk())) {
                table.setPkColumn(column);
                break;
            }
        }
    }

    /**
     * 加载主子表信息
     *
     * @param table 业务表信息
     */
    public void loadSubTable(Table table) {
        String subTableName = table.getSubTableName();
        if (StrUtil.isNotEmpty(subTableName)) {
            Table table1 = baseMapper.selectOne(new QueryWrapper<Table>().eq("table_name", subTableName));
            if(table1 != null){
                List<Column> columns = columnService.list(new QueryWrapper<Column>().eq("table_id", table1.getId()));
                table1.setColumns(columns);
                table.setSubTable(table1);
            }

        }
    }
}
