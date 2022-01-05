import request from "@/utils/request";

/**
 * @program: entfrm-boot
 *
 * @description: 常用按钮请求-API
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2021-06-20
 **/

// 查询常用按钮列表
export function listButton(query) {
  return request({
    url: '/workflow/extension/button/list',
    method: 'get',
    params: query
  })
}

// 查询常用按钮详细
export function getButton(id) {
  return request({
    url: '/workflow/extension/button/' + id,
    method: 'get'
  })
}

// 新增常用按钮
export function addButton(data) {
  return request({
    url: '/workflow/extension/button/save',
    method: 'post',
    data: data
  })
}

// 编辑常用按钮
export function editButton(data) {
  return request({
    url: '/workflow/extension/button/update',
    method: 'put',
    data: data
  })
}


// 删除常用按钮
export function delButton(id) {
  return request({
    url: '/workflow/extension/button/remove/' + id,
    method: 'delete'
  })
}

