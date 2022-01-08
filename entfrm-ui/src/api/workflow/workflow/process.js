import request from '@/utils/request'

// 设置流程分类
export function setProcessCategory(query) {
  return request({
    url: '/workflow/process/setProcessCategory',
    method: 'put',
    params: query
  })
}



