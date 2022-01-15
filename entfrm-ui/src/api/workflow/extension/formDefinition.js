/**
 * @program: entfrm-ui
 *
 * @description: 表单定义 api
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2022/1/15
 */
import request from '@/utils/request'

// 查询表单定义列表
export function listFormDefinition(query) {
  return request({
    url: '/workflow/extension/formDefinition/list',
    method: 'get',
    params: query
  })
}

// 查询表单定义详细
export function getFormDefinition(id) {
  return request({
    url: '/workflow/extension/formDefinition/' + id,
    method: 'get'
  })
}

// 新增表单定义
export function addFormDefinition(data) {
  return request({
    url: '/workflow/extension/formDefinition/save',
    method: 'post',
    data: data
  })
}

// 编辑表单定义
export function editFormDefinition(data) {
  return request({
    url: '/workflow/extension/formDefinition/update',
    method: 'put',
    data: data
  })
}

// 删除表单定义
export function delFormDefinition(id) {
  return request({
    url: '/workflow/extension/formDefinition/remove/' + id,
    method: 'delete'
  })
}
