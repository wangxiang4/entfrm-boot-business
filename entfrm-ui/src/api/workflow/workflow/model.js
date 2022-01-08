import request from '@/utils/request'

// 查询模型列表
export function listModel(query) {
  return request({
    url: '/workflow/model/list',
    method: 'get',
    params: query
  })
}

// 查询模型xml
export function getModelXml(modelId) {
  return request({
    url: '/workflow/model/getBpmnXml/' + modelId,
    method: 'get'
  })
}

// 查询模型详细
export function getModel(modelId) {
  return request({
    url: `/app/rest/models/` + modelId,
    method: 'get'
  })
}

// 删除模型
export function delModel(ids) {
  return request({
    url: '/workflow/model/remove/' + ids,
    method: 'delete'
  })
}

// 部署模型
export function deployModel(query) {
  return request({
    url: '/workflow/model/deploy',
    method: 'post',
    params: query
  })
}
