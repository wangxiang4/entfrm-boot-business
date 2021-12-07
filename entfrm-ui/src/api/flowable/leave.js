import request from '@/utils/request'

// 查询请假列表
export function listLeave(query) {
  return request({
    url: '/flowable/leave/list',
    method: 'get',
    params: query
  })
}

// 查询请假详细
export function getLeave(leaveId) {
  return request({
    url: '/flowable/leave/' + leaveId,
    method: 'get'
  })
}

// 新增请假配置
export function addLeave(data) {
  return request({
    url: '/flowable/leave/save',
    method: 'post',
    data: data
  })
}

// 删除请假配置
export function delLeave(id) {
  return request({
    url: '/flowable/leave/remove/' + id,
    method: 'delete'
  })
}

// 启动请假流程
export function startProcess(id) {
  return request({
    url: '/flowable/leave/startProcess/'+id,
    method: 'get'
  })
}

// 导出请假数据
export function exportLeave(query) {
  return request({
    url: '/flowable/leave/export',
    method: 'get',
    params: query
  })
}

// 请假修改
export function editLeave(data) {
  return request({
    url: '/flowable/leave/update',
    method: 'put',
    data: data
  })
}
