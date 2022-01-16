/**
 * @program: entfrm-ui
 *
 * @description: 流程定义 api
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2022/1/15
 */
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

// 启动流程定义
export function startProcessDefinition (data) {
  return request({
    url: '/workflow/process/startProcessDefinition',
    method: 'post',
    data: data
  })
}

// 获取流程定义工作流图
export function getProcessDefFlowChart (processDefId) {
  return request({
    url: '/workflow/process/getFlowChart/' + processDefId,
    method: 'get'
  })
}

// 查询流程状态
export function queryProcessStatus (processInsId) {
  return request({
    url: '/workflow/process/queryProcessStatus/' + processInsId,
    method: 'get'
  })
}
