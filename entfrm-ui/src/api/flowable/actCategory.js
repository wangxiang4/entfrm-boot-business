import request from "@/utils/request";

/**
 * @program: entfrm-boot
 *
 * @description: 流程分类管理API
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2021-06-22
 **/

// 查询流程分类管理列表
export function listActCategory() {
  return request({
    url: '/flowable/extension/actCategory/list',
    method: 'get'
  })
}

// 查询流程分类管理详细
export function getActCategory(id) {
  return request({
    url: '/flowable/extension/actCategory/' + id,
    method: 'get'
  })
}

// 新增流程分类管理
export function addActCategory(data) {
  return request({
    url: '/flowable/extension/actCategory/save',
    method: 'post',
    data: data
  })
}

// 编辑流程分类管理
export function editActCategory(data) {
  return request({
    url: '/flowable/extension/actCategory/update',
    method: 'put',
    data: data
  })
}

// 流程分类管理
export function delActCategory(id) {
  return request({
    url: '/flowable/extension/actCategory/remove/' + id,
    method: 'delete'
  })
}
