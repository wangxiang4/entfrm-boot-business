/**
 * @program: entfrm-ui
 *
 * @description: 表单分类管理 api
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2022/1/15
 */
import request from "@/utils/request";

// 查询表单分类管理列表
export function listFormCategory() {
  return request({
    url: '/workflow/extension/formCategory/list',
    method: 'get'
  })
}

// 查询表单分类管理详细
export function getFormCategory(id) {
  return request({
    url: '/workflow/extension/formCategory/' + id,
    method: 'get'
  })
}

// 新增表单分类管理
export function addFormCategory(data) {
  return request({
    url: '/workflow/extension/formCategory/save',
    method: 'post',
    data: data
  })
}

// 编辑表单分类管理
export function editFormCategory(data) {
  return request({
    url: '/workflow/extension/formCategory/update',
    method: 'put',
    data: data
  })
}

// 删除表单分类管理
export function delFormCategory(id) {
  return request({
    url: '/workflow/extension/formCategory/remove/' + id,
    method: 'delete'
  })
}
