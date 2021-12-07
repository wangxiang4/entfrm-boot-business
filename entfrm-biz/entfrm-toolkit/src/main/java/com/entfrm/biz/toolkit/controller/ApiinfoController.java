package com.entfrm.biz.toolkit.controller;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.biz.toolkit.entity.Apiinfo;
import com.entfrm.biz.toolkit.entity.Column;
import com.entfrm.biz.toolkit.entity.Table;
import com.entfrm.biz.toolkit.service.ApiinfoService;
import com.entfrm.biz.toolkit.service.ColumnService;
import com.entfrm.biz.toolkit.service.TableService;
import com.entfrm.base.api.R;
import com.entfrm.base.util.ExcelUtil;
import com.entfrm.log.annotation.OperLog;
import com.entfrm.security.util.SecurityUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * @author entfrm
 * @date 2020-04-24 22:18:00
 * @description 接口Controller
 */
@Api("接口管理")
@RestController
@AllArgsConstructor
@RequestMapping("/api/apiinfo")
public class ApiinfoController {

    private final ApiinfoService apiinfoService;
    private final TableService tableService;
    private final ColumnService columnService;


    private QueryWrapper<Apiinfo> getQueryWrapper(Apiinfo apiinfo) {
        return new QueryWrapper<Apiinfo>()
                .like(StrUtil.isNotBlank(apiinfo.getName()), "name", apiinfo.getName())
                .eq(!StrUtil.isEmptyIfStr(apiinfo.getApplicationId()), "application_id", apiinfo.getApplicationId())
                .eq(StrUtil.isNotBlank(apiinfo.getStatus()), "status", apiinfo.getStatus())
                .orderByDesc("create_time");
    }

    @ApiOperation("接口列表")
    @PreAuthorize("@ps.hasPerm('apiinfo_view')")
    @GetMapping(value = "/list")
    public R list(Page page, Apiinfo apiinfo) {
        IPage<Apiinfo> apiinfoPage = apiinfoService.page(page, getQueryWrapper(apiinfo));
        return R.ok(apiinfoPage.getRecords(), apiinfoPage.getTotal());
    }

    @ApiOperation("接口查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(apiinfoService.getById(id));
    }

    @OperLog("接口快速新增")
    @ApiOperation("接口快速新增")
    @PreAuthorize("@ps.hasPerm('apiinfo_add')")
    @PostMapping("/quickSave")
    @Transactional
    public R quickSave(@Validated @RequestBody Apiinfo apiinfo) {
        Table table = tableService.getById(apiinfo.getTableId());
        if (table != null) {
            String type = apiinfo.getType();
            apiinfo.setType("other");
            apiinfo.setParentId(0);
            apiinfo.setRequestType("-");
            apiinfo.setRequestMethod("/" + apiinfo.getCode());
            apiinfo.setDeptId(SecurityUtil.getUser().getDeptId());
            apiinfoService.save(apiinfo);
            List<Column> columnList = columnService.list(new QueryWrapper<Column>().eq("table_id", apiinfo.getTableId()));
            if (columnList != null && columnList.size() > 0) {
                ArrayList<Map<String, Object>> fList = new ArrayList<>();
                ArrayList<Map<String, Object>> pList = new ArrayList<>();
                if (StrUtil.contains(type, "新增")) {
                    Apiinfo apiinfo1 = new Apiinfo();
                    apiinfo1.setApplicationId(apiinfo.getApplicationId());
                    apiinfo1.setName(apiinfo.getName() + "新增");
                    apiinfo1.setTableId(apiinfo.getTableId());
                    apiinfo1.setCode("save");
                    apiinfo1.setParentId(apiinfo.getId());
                    apiinfo1.setDeptId(SecurityUtil.getUser().getDeptId());
                    apiinfo1.setType("insert");
                    apiinfo1.setRequestType("post");
                    apiinfo1.setRequestMethod("/save");
                    fList = new ArrayList<>();
                    for (Column column : columnList) {
                        if ("1".equals(column.getIsAdd())) {
                            Map<String, Object> map = new HashMap<>();
                            map.put("name", column.getColumnComment());
                            map.put("checked", true);
                            map.put("columnName", column.getColumnName());
                            fList.add(map);
                        } else {
                            Map<String, Object> map = new HashMap<>();
                            map.put("name", column.getColumnComment());
                            map.put("checked", false);
                            map.put("columnName", column.getColumnName());
                            fList.add(map);
                        }
                    }
                    apiinfo1.setFdata(JSONUtil.toJsonStr(fList));
                    apiinfo1.setScripts(genScripts("insert", table, columnList));
                    apiinfoService.save(apiinfo1);
                }
                if (StrUtil.contains(type, "修改")) {
                    Apiinfo apiinfo1 = new Apiinfo();
                    apiinfo1.setApplicationId(apiinfo.getApplicationId());
                    apiinfo1.setName(apiinfo.getName() + "修改");
                    apiinfo1.setTableId(apiinfo.getTableId());
                    apiinfo1.setCode("update");
                    apiinfo1.setParentId(apiinfo.getId());
                    apiinfo1.setDeptId(SecurityUtil.getUser().getDeptId());
                    apiinfo1.setType("update");
                    apiinfo1.setRequestType("post");
                    apiinfo1.setRequestMethod("/update");
                    fList = new ArrayList<>();
                    for (Column column : columnList) {
                        if ("1".equals(column.getIsEdit())) {
                            Map<String, Object> map = new HashMap<>();
                            map.put("name", column.getColumnComment());
                            map.put("checked", true);
                            map.put("columnName", column.getColumnName());
                            fList.add(map);
                        } else {
                            Map<String, Object> map = new HashMap<>();
                            map.put("name", column.getColumnComment());
                            map.put("checked", false);
                            map.put("columnName", column.getColumnName());
                            fList.add(map);
                        }
                    }
                    apiinfo1.setFdata(JSONUtil.toJsonStr(fList));
                    apiinfo1.setScripts(genScripts("update", table, columnList));
                    apiinfoService.save(apiinfo1);
                }
                if (StrUtil.contains(type, "删除")) {
                    Apiinfo apiinfo1 = new Apiinfo();
                    apiinfo1.setApplicationId(apiinfo.getApplicationId());
                    apiinfo1.setName(apiinfo.getName() + "删除");
                    apiinfo1.setTableId(apiinfo.getTableId());
                    apiinfo1.setCode("remove");
                    apiinfo1.setParentId(apiinfo.getId());
                    apiinfo1.setDeptId(SecurityUtil.getUser().getDeptId());
                    apiinfo1.setType("delete");
                    apiinfo1.setRequestType("get");
                    apiinfo1.setRequestMethod("/remove");
                    fList = new ArrayList<>();
                    for (Column column : columnList) {
                        if ("id".equals(column.getColumnName())) {
                            Map<String, Object> map = new HashMap<>();
                            map.put("name", column.getColumnComment());
                            map.put("checked", true);
                            map.put("columnName", column.getColumnName());
                            fList.add(map);
                        } else {
                            Map<String, Object> map = new HashMap<>();
                            map.put("name", column.getColumnComment());
                            map.put("checked", false);
                            map.put("columnName", column.getColumnName());
                            fList.add(map);
                        }
                    }
                    apiinfo1.setFdata(JSONUtil.toJsonStr(fList));
                    apiinfo1.setScripts(genScripts("delete", table, columnList));
                    apiinfoService.save(apiinfo1);
                }
                if (StrUtil.contains(type, "列表")) {
                    Apiinfo apiinfo1 = new Apiinfo();
                    apiinfo1.setApplicationId(apiinfo.getApplicationId());
                    apiinfo1.setName(apiinfo.getName() + "列表");
                    apiinfo1.setTableId(apiinfo.getTableId());
                    apiinfo1.setCode("list");
                    apiinfo1.setParentId(apiinfo.getId());
                    apiinfo1.setDeptId(SecurityUtil.getUser().getDeptId());
                    apiinfo1.setType("select");
                    apiinfo1.setRequestType("get");
                    apiinfo1.setRequestMethod("/list");
                    fList = new ArrayList<>();
                    pList = new ArrayList<>();
                    for (Column column : columnList) {
                        if ("1".equals(column.getIsList())) {
                            Map<String, Object> map = new HashMap<>();
                            map.put("name", column.getColumnComment());
                            map.put("checked", true);
                            map.put("columnName", column.getColumnName());
                            fList.add(map);
                        } else {
                            Map<String, Object> map = new HashMap<>();
                            map.put("name", column.getColumnComment());
                            map.put("checked", false);
                            map.put("columnName", column.getColumnName());
                            fList.add(map);
                        }

                        if ("1".equals(column.getIsQuery())) {
                            Map<String, Object> map = new HashMap<>();
                            map.put("name", column.getColumnComment());
                            map.put("checked", true);
                            map.put("columnName", column.getColumnName());
                            pList.add(map);
                        } else {
                            Map<String, Object> map = new HashMap<>();
                            map.put("name", column.getColumnComment());
                            map.put("checked", false);
                            map.put("columnName", column.getColumnName());
                            pList.add(map);
                        }
                    }
                    apiinfo1.setFdata(JSONUtil.toJsonStr(fList));
                    apiinfo1.setPdata(JSONUtil.toJsonStr(pList));
                    apiinfo1.setScripts(genScripts("select", table, columnList));
                    apiinfoService.save(apiinfo1);
                }
            }
        }
        return R.ok();
    }

    //生成脚本
    private String genScripts(String type, Table table, List<Column> columnList) {
        switch (type) {
            case "insert":
                String sbf = "insert into " + table.getTableName() + " (";//字段
                String sbp = "";//参数
                for (Column column : columnList) {
                    if ("1".equals(column.getIsAdd())) {
                        sbf += column.getColumnName() + ",";
                        sbp += "?,";
                    }
                }
                sbf = sbf.substring(0, sbf.length() - 1) + ") values (";
                sbp = sbp.substring(0, sbp.length() - 1) + ")";
                return sbf + sbp;
            case "update":
                String sbu = "update " + table.getTableName() + " set ";
                for (Column column : columnList) {
                    if ("1".equals(column.getIsEdit())) {
                        sbu += column.getColumnName() + " = ? ,";
                    }
                }
                sbu = sbu.substring(0, sbu.length() - 1);
                return sbu;
            case "delete":
                String sbe = "delete " + table.getTableName() + " where id = ?";
                return sbe;
            case "select":
                String sbs = "select ";
                String sbw = "";
                for (Column column : columnList) {
                    if ("1".equals(column.getIsList())) {
                        sbs += column.getColumnName() + " " + column.getJavaField() + ", ";
                    }
                    if ("1".equals(column.getIsQuery())) {
                        //根据查询方式拼接sql未实现
                        sbw += column.getColumnName() + " = ? and ";
                    }
                }
                sbs = sbs.substring(0, sbs.length() - 2) + " from " + table.getTableName() + " where ";
                sbw = sbw.substring(0, sbw.length() - 4);
                return sbs + sbw;
            default:
                return "";
        }
    }

    @OperLog("接口新增")
    @ApiOperation("接口新增")
    @PreAuthorize("@ps.hasPerm('apiinfo_add')")
    @PostMapping("/save")
    public R save(@Validated @RequestBody Apiinfo apiinfo) {
        apiinfoService.save(apiinfo);
        return R.ok();
    }

    @OperLog("接口修改")
    @ApiOperation("接口修改")
    @PreAuthorize("@ps.hasPerm('apiinfo_edit')")
    @PutMapping("/update")
    public R update(@Validated @RequestBody Apiinfo apiinfo) {
        apiinfo.setCode(apiinfo.getRequestMethod().replace("/", ""));
        apiinfoService.updateById(apiinfo);
        //更新接口所属应用
        List<Apiinfo> apiinfoList = apiinfoService.list(new QueryWrapper<Apiinfo>().eq("parent_id", apiinfo.getId()));
        if (apiinfoList != null && apiinfoList.size() > 0) {
            for (Apiinfo apiinfo1 : apiinfoList) {
                if (apiinfo.getApplicationId() != apiinfo1.getApplicationId()) {
                    apiinfo1.setApplicationId(apiinfo.getApplicationId());
                    apiinfoService.updateById(apiinfo1);
                }
            }
        }
        return R.ok();
    }

    @OperLog("接口删除")
    @ApiOperation("接口删除")
    @PreAuthorize("@ps.hasPerm('apiinfo_del')")
    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable("id") Integer[] id) throws Exception {
        return R.ok(apiinfoService.removeByIds(Arrays.asList(id)));
    }

    @PreAuthorize("@ps.hasPerm('apiinfo_export')")
    @GetMapping("/export")
    public R export(Apiinfo apiinfo) {
        List<Apiinfo> list = apiinfoService.list(getQueryWrapper(apiinfo));
        ExcelUtil<Apiinfo> util = new ExcelUtil<Apiinfo>(Apiinfo.class);
        return util.exportExcel(list, "接口数据");
    }
}
