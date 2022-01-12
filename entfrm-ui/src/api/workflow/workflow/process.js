import request from '@/utils/request'

// 查询流程定义列表
export function listProcessDefinition(query) {
  return request({
    url: '/workflow/process/list',
    method: 'get',
    params: query
  })
}


// 设置流程定义分类
export function setProcessCategory(query) {
  return request({
    url: '/workflow/process/setProcessCategory',
    method: 'put',
    params: query
  })
}

// 设置激活或挂起流程
export function setProcessInstanceStatus(query) {
  return request({
    url: '/workflow/process/setProcessInstanceStatus',
    method: 'put',
    params: query
  })
}

// 流程终止
export function stopProcessInstance(query) {
  return request({
    url: '/workflow/process/stopProcessInstance',
    method: 'put',
    params: query
  })
}
