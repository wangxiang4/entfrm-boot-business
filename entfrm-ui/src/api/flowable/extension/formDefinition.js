import request from '@/utils/request'

// 查询表单定义列表
export function listFormDefinition(query) {
  return request({
    url: '/flowable/extension/formDefinition/list',
    method: 'get',
    params: query
  })
}
