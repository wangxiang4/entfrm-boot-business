package com.entfrm.biz.toolkit.controller;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.entfrm.base.api.R;
import com.entfrm.base.util.StrUtil;
import com.entfrm.biz.toolkit.entity.Column;
import com.entfrm.biz.toolkit.entity.Table;
import com.entfrm.biz.toolkit.service.ColumnService;
import com.entfrm.biz.toolkit.service.TableService;
import com.entfrm.data.datasource.DSContextHolder;
import com.entfrm.data.enums.DataTypeEnum;
import com.entfrm.data.util.AliasUtil;
import com.entfrm.log.annotation.OperLog;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * @author yong
 * @date 2020/3/21
 * @description 数据表管理
 */
@RestController
@RequestMapping("/toolkit/datatable")
@AllArgsConstructor
public class DatatableController {

    private final JdbcTemplate jdbcTemplate;
    private final TableService tableService;
    private final ColumnService columnService;

    /**
     * **
     * 根据数据名称获取所有表名
     *
     * @param alias
     * @return
     */
    @GetMapping("/list")
    public R list(@RequestParam String alias, @RequestParam(required = false) String tableName) {
        DSContextHolder.setDSType(AliasUtil.getDsId(alias));
        StringBuilder sql = new StringBuilder();
        if (DataTypeEnum.MYSQL.getType().equals(AliasUtil.getDsType(alias))) {
            sql.append("select table_name tableName, table_comment tableComment, create_time createTime from information_schema.tables where table_schema=?")
                    .append(" and table_name not like 'sys_%' and table_name not like 'qrtz_%' and table_name not like 'act_%' and table_name not like 'dev_%' and table_type='base table'");
            if (StrUtil.isNotBlank(tableName)) {
                sql.append(" and table_name like '%" + tableName + "%'");
            }
        }

        List<Map<String, Object>> list = jdbcTemplate.queryForList(sql.toString(), AliasUtil.getDsName(alias));
        list.stream().forEach(map -> {
            Table table = tableService.getOne(new QueryWrapper<Table>().eq("table_name", map.get("tableName")));
            if (table != null) {
                map.put("isConfig", "1");
                map.put("genWay", table.getGenWay());
            } else {
                map.put("isConfig", "0");
            }
        });
        return R.ok(list);
    }

    @GetMapping("/tree")
    public R tree() {
        List<Table> tableList = tableService.list();
        return R.ok(tableList);
    }

    @GetMapping("/column/{tableId}")
    public R column(@PathVariable String tableId) {
        List<Column> columnList = columnService.list(new QueryWrapper<Column>().eq("table_id", tableId));
        return R.ok(columnList);
    }

    @OperLog("新建/配置表")
    @PreAuthorize("@ps.hasAnyPerm('datatable_add,datatable_config')")
    @PostMapping("/getGenTable")
    public R getGenTable(@RequestBody Table table) {
        return R.ok(tableService.getGenTable(table.getTableName(), table.getTableComment()));
    }

    @OperLog("表修改")
    @PreAuthorize("@ps.hasPerm('datatable_edit')")
    @PutMapping("/update")
    public R update(@RequestBody Table table) {
        tableService.validateEdit(table);
        tableService.updateTable(table);
        return R.ok();
    }

    @OperLog("预览代码")
    @PreAuthorize("@ps.hasPerm('datatable_view')")
    @GetMapping("/preview/{tableName}")
    public R preview(@PathVariable("tableName") String tableName) {
        Map<String, String> dataMap = tableService.previewCode(tableName);
        return R.ok(dataMap);
    }

    /**
     * 批量生成代码到本地
     */
    @OperLog("代码生成到本地")
    @PreAuthorize("@ps.hasPerm('datatable_gen')")
    @GetMapping("/batchGenToLocal/{tables}")
    public R batchGenToLocal(@PathVariable String tables) {
        String[] tableNames = Convert.toStrArray(tables);
        return R.ok(tableService.genToLocal(tableNames));
    }

    /**
     * 批量生成代码
     */
    @OperLog("代码生成")
    @PreAuthorize("@ps.hasPerm('datatable_gen')")
    @GetMapping("/batchGenCode/{tables}")
    @ResponseBody
    public void batchGenCode(HttpServletResponse response, @PathVariable String tables) throws IOException {
        String[] tableNames = Convert.toStrArray(tables);
        byte[] data = tableService.genCode(tableNames);
        genCode(response, data);
    }

    /**
     * 生成zip文件
     */
    private void genCode(HttpServletResponse response, byte[] data) throws IOException {
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=\"entfrm.zip\"");
        response.addHeader("Content-Length", "" + data.length);
        response.setContentType("application/octet-stream; charset=UTF-8");
        IoUtil.write(response.getOutputStream(), true, data);
    }

    @OperLog("表删除")
    @PreAuthorize("@ps.hasPerm('datatable_del')")
    @DeleteMapping("/remove")
    @Transactional
    public R remove(@RequestParam String alias, @RequestParam String tableName) {
        Table table = tableService.getOne(new QueryWrapper<Table>().eq("table_name", tableName));
        if (table != null) {
            //删除表列信息
            tableService.deleteTableByIds(table.getId() + "");
        }
        //删除数据库表
        DSContextHolder.setDSType(AliasUtil.getDsId(alias));
        StringBuilder sql = new StringBuilder();
        if (DataTypeEnum.MYSQL.getType().equals(AliasUtil.getDsType(alias))) {
            sql.append("drop table ").append(tableName);
        }

        return R.ok();
    }

    @OperLog("物理表删除")
    @PreAuthorize("@ps.hasPerm('datatable_drop')")
    @DeleteMapping("/drop")
    @Transactional
    public R drop(@RequestParam String alias, @RequestParam String tableName) {
        //删除数据库表
        DSContextHolder.setDSType(AliasUtil.getDsId(alias));
        StringBuilder sql = new StringBuilder();
        if (DataTypeEnum.MYSQL.getType().equals(AliasUtil.getDsType(alias))) {
            sql.append("drop table ").append(tableName).append(";");
        }
        jdbcTemplate.execute(sql.toString());
        return R.ok();
    }

}
