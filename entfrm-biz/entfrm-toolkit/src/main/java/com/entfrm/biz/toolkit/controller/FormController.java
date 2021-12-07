package com.entfrm.biz.toolkit.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.base.util.ExcelUtil;
import com.entfrm.biz.toolkit.dto.FormDto;
import com.entfrm.biz.toolkit.entity.Column;
import com.entfrm.biz.toolkit.entity.Form;
import com.entfrm.biz.toolkit.entity.Table;
import com.entfrm.biz.toolkit.service.ColumnService;
import com.entfrm.biz.toolkit.service.FormService;
import com.entfrm.biz.toolkit.service.TableService;
import com.entfrm.biz.toolkit.util.BuilderUtil;
import com.entfrm.log.annotation.OperLog;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * @author entfrm
 * @date 2021-03-11 21:57:03
 * @description 表单Controller
 */
@Api("表单管理")
@RestController
@AllArgsConstructor
@RequestMapping("/toolkit/form")
public class FormController {

    private final JdbcTemplate jdbcTemplate;
    private final FormService formService;
    private final TableService tableService;
    private final ColumnService columnService;

    private QueryWrapper<Form> getQueryWrapper(Form form) {
        return new QueryWrapper<Form>()
                .like(StrUtil.isNotBlank(form.getName()), "name", form.getName())
                .eq(StrUtil.isNotBlank(form.getType()), "type", form.getType())
                .like(StrUtil.isNotBlank(form.getTableName()), "table_name", form.getTableName())
                .between(StrUtil.isNotBlank(form.getBeginTime()) && StrUtil.isNotBlank(form.getEndTime()), "create_time", form.getBeginTime(), form.getEndTime())
                .orderByDesc("id");
    }

    @ApiOperation("表单列表")
    //@PreAuthorize("@ps.hasPerm('form_view')")
    @GetMapping("/list")
    public R list(Page page, Form form) {
        IPage<Form> formPage = formService.page(page, getQueryWrapper(form));
        return R.ok(formPage.getRecords(), formPage.getTotal());
    }

    @ApiOperation("表单查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(formService.getById(id));
    }

    @OperLog("表单新增")
    @ApiOperation("表单新增")
    @PreAuthorize("@ps.hasPerm('form_add')")
    @PostMapping("/save")
    @Transactional
    public R save(@Validated @RequestBody Form form) {
        formService.save(form);
        return R.ok();
    }

    @OperLog("表单修改")
    @ApiOperation("表单修改")
    @PreAuthorize("@ps.hasPerm('form_edit')")
    @PutMapping("/update")
    public R update(@Validated @RequestBody Form form) {
        if ("0".equals(form.getAutoCreate())) {
            Table table = tableService.getOne(new QueryWrapper<Table>().eq("table_name", CommonConstants.PREFIX + form.getTableName()));
            if(table == null){
                table = BuilderUtil.createForm(form);
                tableService.save(table);
                if (table.getColumns() != null && table.getColumns().size() > 0) {
                    for (Column column : table.getColumns()) {
                        column.setTableId(table.getId());
                        columnService.save(column);
                    }
                }
                //创建SQL脚本
                jdbcTemplate.execute(BuilderUtil.createTable(table));
            }else {
                //todo 更新表结构
            }
        }
        formService.updateById(form);
        return R.ok();
    }

    @OperLog("表单删除")
    @ApiOperation("表单删除")
    @PreAuthorize("@ps.hasPerm('form_del')")
    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable("id") Integer[] id) {
        return R.ok(formService.removeByIds(Arrays.asList(id)));
    }


    @PreAuthorize("@ps.hasPerm('form_export')")
    @GetMapping("/export")
    public R export(Form form) {
        List<Form> list = formService.list(getQueryWrapper(form));
        ExcelUtil<Form> util = new ExcelUtil<Form>(Form.class);
        return util.exportExcel(list, "表单数据");
    }

    @ApiOperation("动态表单列表")
    @GetMapping("/dynamicFormList")
    public R dynamicFormList(Page page, Form form, @RequestParam("params") String params) {
        IPage<Map> formPage = formService.mapFormPage(page, form, params);
        return R.ok(formPage.getRecords(), formPage.getTotal());
    }

    @ApiOperation("动态表单查询")
    @GetMapping("/dynamicForm")
    public R dynamicFormById(String tableName, Integer id) {
        Form form = formService.getOne(new QueryWrapper<Form>().eq("table_name", tableName));
        return R.ok(formService.queryData(tableName, id), form.getData());
    }

    @PostMapping("dynamicFormSave")
    public R dynamicFormSave(@RequestBody FormDto formDto) throws Exception{
        Form form = formService.getById(formDto.getFormId());
        List<Column> columns = BuilderUtil.createColumns(form.getData());
        formService.saveData(form, columns, formDto.getData());
        return R.ok("保存数据成功");
    }

    @ApiOperation("动态表单删除")
    @DeleteMapping("/dynamicFormRemove")
    public R dynamicFormRemove(String tableName, Integer[] ids) {
        formService.removeData(tableName, ids);
        return R.ok();
    }

    @GetMapping("/column/{tableName}")
    public R column(@PathVariable String tableName) {
        Table table = tableService.getOne(new QueryWrapper<Table>().eq("table_name", CommonConstants.PREFIX + tableName));
        List<Column> columnList = columnService.list(new QueryWrapper<Column>().eq("table_id", table.getId()));
        return R.ok(columnList);
    }

}
