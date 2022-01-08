import request from '@/utils/request'

// 设置流程分类
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

