/**
 * @program: entfrm-ui
 *
 * @description: 流程分类管理 api
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2022/1/15
 */
import request from "@/utils/request";

// 查询流程分类管理列表
export function listCategory() {
  return request({
    url: '/workflow/extension/category/list',
    method: 'get'
  })
}

// 查询流程分类管理详细
export function getCategory(id) {
  return request({
    url: '/workflow/extension/category/' + id,
    method: 'get'
  })
}

// 新增流程分类管理
export function addCategory(data) {
  return request({
    url: '/workflow/extension/category/save',
    method: 'post',
    data: data
  })
}

// 编辑流程分类管理
export function editCategory(data) {
  return request({
    url: '/workflow/extension/category/update',
    method: 'put',
    data: data
  })
}

// 流程分类管理
export function delCategory(id) {
  return request({
    url: '/workflow/extension/category/remove/' + id,
    method: 'delete'
  })
}
