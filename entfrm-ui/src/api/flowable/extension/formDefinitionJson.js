import request from "@/utils/request";

// 查询表单定义json列表
export function listFormDefinitionJson(query) {
  return request({
    url: '/flowable/extension/formDefinitionJson/list',
    method: 'get',
    params: query
  })
}

// 查询表单定义json详细
export function getFormDefinitionJson(id) {
  return request({
    url: '/flowable/extension/formDefinitionJson/' + id,
    method: 'get'
  })
}

// 删除表单定义json
export function delFormDefinitionJson(id) {
  return request({
    url: '/flowable/extension/formDefinitionJson/remove/' + id,
    method: 'delete'
  })
}

// 设置主版本
export function updatePrimaryVersion(id) {
  return request({
    url: '/flowable/extension/formDefinitionJson/updatePrimaryVersion/' + id,
    method: 'put'
  })
}


