import request from '@/utils/request'

// 查询流程列表
export function listProcess(query) {
  return request({
    url: '/flowable/process/list',
    method: 'get',
    params: query
  })
}

// 改变流程配置
export function changeStatus(procDefId, status) {
  const data = {
    procDefId,
    status
  }
  return request({
    url: '/flowable/process/changeStatus',
    method: 'put',
    params: data
  })
}

// 删除流程配置
export function delProcess(id) {
  return request({
    url: '/flowable/process/remove/' + id,
    method: 'delete'
  })
}


