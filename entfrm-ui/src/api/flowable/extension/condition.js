import request from "@/utils/request";

/**
 * @program: entfrm-boot
 *
 * @description: 流程表达式请求-API
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2021-06-20
 **/

// 查询流程表达式列表
export function listCondition(query) {
  return request({
    url: '/flowable/extension/condition/list',
    method: 'get',
    params: query
  })
}

// 查询流程表达式详细
export function getCondition(id) {
  return request({
    url: '/flowable/extension/condition/' + id,
    method: 'get'
  })
}

// 新增流程表达式
export function addCondition(data) {
  return request({
    url: '/flowable/extension/condition/save',
    method: 'post',
    data: data
  })
}

// 编辑流程表达式
export function editCondition(data) {
  return request({
    url: '/flowable/extension/condition/update',
    method: 'put',
    data: data
  })
}


// 删除流程表达式
export function delCondition(id) {
  return request({
    url: '/flowable/extension/condition/remove/' + id,
    method: 'delete'
  })
}

