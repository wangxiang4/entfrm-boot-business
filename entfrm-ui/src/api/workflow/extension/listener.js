/**
 * @program: entfrm-ui
 *
 * @description: 监听器请求 api
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2022/1/15
 */
import request from "@/utils/request";

// 查询监听器列表
export function listListener(query) {
  return request({
    url: '/workflow/extension/listener/list',
    method: 'get',
    params: query
  })
}

// 查询监听器详细
export function getListener(id) {
  return request({
    url: '/workflow/extension/listener/' + id,
    method: 'get'
  })
}

// 新增监听器
export function addListener(data) {
  return request({
    url: '/workflow/extension/listener/save',
    method: 'post',
    data: data
  })
}

// 编辑监听器
export function editListener(data) {
  return request({
    url: '/workflow/extension/listener/update',
    method: 'put',
    data: data
  })
}


// 删除监听器
export function delListener(id) {
  return request({
    url: '/workflow/extension/listener/remove/' + id,
    method: 'delete'
  })
}

