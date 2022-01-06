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
    url: '/workflow/getBpmnXml/' + modelId,
    method: 'get'
  })
}

// 查询模型json,后面需要做一些自定义元素数据保存
export function getModelJson(modelId) {
  return request({
    url: `/app/rest/models/${modelId}/editor/json`,
    method: 'get'
  })
}

// 查询模型详细
export function getModel(modelId) {
  return request({
    url: `/rest/models/` + modelId,
    method: 'get'
  })
}

// 创建模型
export function addModel(data) {
  return request({
    url: '/app/rest/models',
    method: 'post',
    data: data
  })
}

// 编辑模型
export function editModel(modelId, data) {
  return request({
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
    },
    url: `/app/rest/models/${modelId}/editor/json`,
    method: 'post',
    data: data
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
