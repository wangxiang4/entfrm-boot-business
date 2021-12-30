import request from '@/utils/request'

// 查询表单定义列表
export function listFormDefinition(query) {
  return request({
    url: '/flowable/extension/formDefinition/list',
    method: 'get',
    params: query
  })
}

// 查询表单定义详细
export function getFormDefinition(id) {
  return request({
    url: '/flowable/extension/formDefinition/' + id,
    method: 'get'
  })
}

// 新增表单定义
export function addFormDefinition(data) {
  return request({
    url: '/flowable/extension/formDefinition/save',
    method: 'post',
    data: data
  })
}

// 编辑表单定义
export function editFormDefinition(data) {
  return request({
    url: '/flowable/extension/formDefinition/update',
    method: 'put',
    data: data
  })
}

// 删除表单定义
export function delFormDefinition(id) {
  return request({
    url: '/flowable/extension/formDefinition/remove/' + id,
    method: 'delete'
  })
}
