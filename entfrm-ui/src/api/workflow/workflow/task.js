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

/** 启动任务流程定义 */
export function startTaskProcessDefinition (data) {
  return request({
    url: '/workflow/process/startProcessDefinition',
    method: 'post',
    data: data
  })
}

/** 启动表单流程定义 */
export function startFormProcessDefinition (data) {
  return request({
    url: '/workflow/form/startProcessDefinition',
    method: 'post',
    data: data
  })
}

/** 提交表单任务 */
export function auditFormTask (data) {
  return request({
    url: '/workflow/form/auditTask',
    method: 'post',
    data: data
  })
}

/** 可回滚任务列表 */
export function rollBackTaskList (taskId) {
  return request({
    url: '/workflow/form/rollBackTaskList/' + taskId,
    method: 'get'
  })
}

/** 获取任务定义信息 */
export function getTaskDefinition (query) {
  return request({
    url: '/workflow/task/getTaskDefinition/',
    method: 'get',
    params: query
  })
}

// 获取流程开始事件表单数据
export function getProcessStartEventFormData (processDefId) {
  return request({
    url: '/workflow/form/getProcessStartEventFormData/' + processDefId,
    method: 'get'
  })
}
