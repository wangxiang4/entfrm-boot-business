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

// 启动任务流程定义
export function startTaskProcessDefinition (data) {
  return request({
    url: '/workflow/process/startProcessDefinition',
    method: 'post',
    data: data
  })
}

// 启动表单流程定义
export function startFormProcessDefinition (data) {
  return request({
    url: '/workflow/form/startProcessDefinition',
    method: 'post',
    data: data
  })
}

// 提交表单任务
export function auditFormTask (data) {
  return request({
    url: '/workflow/form/auditTask',
    method: 'post',
    data: data
  })
}

// 可回滚任务列表
export function rollBackTaskList (taskId) {
  return request({
    url: '/workflow/form/rollBackTaskList/' + taskId,
    method: 'get'
  })
}

// 获取任务定义信息
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

// 获取流程实例工作流图
export function getProcessInsFlowChart (processInsId) {
  return request({
    url: '/workflow/task/getFlowChart/' + processInsId,
    method: 'get'
  })
}


// 获取流程定义工作流图
export function getProcessDefFlowChart (processDefId) {
  return request({
    url: '/workflow/process/getFlowChart/' + processDefId,
    method: 'get'
  })
}

// 获取任务表单数据
export function getTaskFormData (taskId) {
  return request({
    url: '/workflow/form/getTaskFormData/' + taskId,
    method: 'get'
  })
}

// 查找活动扩展数据
export function findByDefIdAndTaskId (query) {
  return request({
    url: '/workflow/extension/activityExtensionData/findByDefIdAndTaskId',
    method: 'get',
    params: query
  })
}

// 获取已办流转任务列表
export function getHistoryFlowChangeList (processInsId) {
  return request({
    url: '/workflow/task/historyFlowChangeList/' + processInsId,
    method: 'get'
  })
}

// 流程抄送保存
export function workflowCopySave (userIds, data) {
  return request({
    url: '/workflow/extension/workflowCopy/save/' + userIds,
    method: 'post',
    data: data
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

// 加签任务
export function addSignTask (data) {
  return request({
    url: '/workflow/task/addSignTask',
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

// 代表任务列表
export function listTodoTask (query) {
  return request({
    url: '/workflow/task/list',
    method: 'get',
    params: query
  })
}
