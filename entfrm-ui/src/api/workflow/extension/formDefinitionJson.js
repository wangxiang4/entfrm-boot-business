/**
 * @program: entfrm-ui
 *
 * @description: 表单定义json结构 api
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2021-06-20
 **/
import request from "@/utils/request";

// 查询表单定义json列表
export function listFormDefinitionJson(query) {
  return request({
    url: '/workflow/extension/formDefinitionJson/list',
    method: 'get',
    params: query
  })
}

// 查询表单定义json详细
export function getFormDefinitionJson(id) {
  return request({
    url: '/workflow/extension/formDefinitionJson/' + id,
    method: 'get'
  })
}

// 新增表单定义json
export function addFormDefinitionJson(data) {
  return request({
    url: '/workflow/extension/formDefinitionJson/save',
    method: 'post',
    data: data
  })
}

// 编辑表单定义json
export function editFormDefinitionJson(data) {
  return request({
    url: '/workflow/extension/formDefinitionJson/update',
    method: 'put',
    data: data
  })
}

// 删除表单定义json
export function delFormDefinitionJson(id) {
  return request({
    url: '/workflow/extension/formDefinitionJson/remove/' + id,
    method: 'delete'
  })
}

// 设置主版本
export function setPrimaryVersion(id) {
  return request({
    url: '/workflow/extension/formDefinitionJson/setPrimaryVersion/' + id,
    method: 'put'
  })
}


