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

// 查询历史流程定义列表
export function listHistoryProcessDefinition(query) {
  return request({
    url: '/workflow/process/historyList',
    method: 'get',
    params: query
  })
}

// 查询正在运行流程定义列表
export function listRunProcessDefinition(query) {
  return request({
    url: '/workflow/process/runList',
    method: 'get',
    params: query
  })
}

// 查询我发起的流程实例列表
export function selfProcessInstanceList(query) {
  return request({
    url: '/workflow/process/selfProcessInstanceList',
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

// 流程撤回
export function undoProcessInstance(processInsId) {
  return request({
    url: '/workflow/process/undoProcessInstance/' + processInsId,
    method: 'put'
  })
}

// 删除历史流程实例
export function removeHistoryProcessIns(processInsIds) {
  return request({
    url: '/workflow/process/removeHistoryProcessIns/' + processInsIds,
    method: 'delete'
  })
}

// 删除流程实例
export function removeProcessInstance(query) {
  return request({
    url: '/workflow/process/removeProcessInstance/',
    method: 'delete',
    params: query
  })
}
