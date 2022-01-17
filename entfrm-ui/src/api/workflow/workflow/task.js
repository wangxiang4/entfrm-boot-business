/**
 * @program: entfrm-ui
 *
 * @description: 待办任务 api
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2022/1/15
 */
import request from '@/utils/request'

// 查询部门下拉树结构
export function deptTree () {
  return request({
    url: '/system/dept/deptTree',
    method: 'get'
  })
}

// 查询用户列表
export function listUser (query) {
  return request({
    url: '/system/user/list',
    method: 'get',
    params: query
  })
}

// 获取用户详细
export function getUser (userIds) {
  return request({
    url: '/system/user/getByIds/' + userIds,
    method: 'get'
  })
}

// 待办任务列表
export function listTodoTask (query) {
  return request({
    url: '/workflow/task/list',
    method: 'get',
    params: query
  })
}

// 历史任务列表
export function listHistoryList (query) {
  return request({
    url: '/workflow/task/historyList',
    method: 'get',
    params: query
  })
}

// 可回滚任务列表
export function rollBackTaskList (taskId) {
  return request({
    url: '/workflow/task/rollBackTaskList/' + taskId,
    method: 'get'
  })
}

// 获取任务定义信息
export function getTaskDefinition (query) {
  return request({
    url: '/workflow/task/getTaskDefinition',
    method: 'get',
    params: query
  })
}

// 获取流程实例工作流图
export function getProcessInsFlowChart (processInsId) {
  return request({
    url: '/workflow/task/getFlowChart/' + processInsId,
    method: 'get'
  })
}

// 获取已办流转任务列表
export function getHistoryFlowChangeList (processInsId) {
  return request({
    url: '/workflow/task/historyFlowChangeList/' + processInsId,
    method: 'get'
  })
}

// 审批任务
export function auditTask (data) {
  return request({
    url: '/workflow/task/auditTask',
    method: 'post',
    data: data
  })
}

// 驳回任务
export function rejectTask (data) {
  return request({
    url: '/workflow/task/rejectTask',
    method: 'post',
    data: data
  })
}

// 回滚任务
export function undoTask (data) {
  return request({
    url: '/workflow/task/undoTask',
    method: 'post',
    data: data
  })
}

// 转移任务
export function transferTask (query) {
  return request({
    url: '/workflow/task/transferTask',
    method: 'post',
    params: query
  })
}

// 委托任务
export function delegateTask (query) {
  return request({
    url: '/workflow/task/delegateTask',
    method: 'post',
    params: query
  })
}
