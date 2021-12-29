import request from "@/utils/request";

/**
 * @program: entfrm-boot
 *
 * @description: 监听器请求-API
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2021-06-20
 **/

// 查询监听器列表
export function listListener(query) {
  return request({
    url: '/flowable/extension/listener/list',
    method: 'get',
    params: query
  })
}

// 查询监听器详细
export function getListener(id) {
  return request({
    url: '/flowable/extension/listener/' + id,
    method: 'get'
  })
}

// 新增监听器
export function addListener(data) {
  return request({
    url: '/flowable/extension/listener/save',
    method: 'post',
    data: data
  })
}

// 编辑监听器
export function editListener(data) {
  return request({
    url: '/flowable/extension/listener/update',
    method: 'put',
    data: data
  })
}


// 删除监听器
export function delListener(id) {
  return request({
    url: '/flowable/extension/listener/remove/' + id,
    method: 'delete'
  })
}

