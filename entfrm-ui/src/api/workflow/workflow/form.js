/**
 * @program: entfrm-ui
 *
 * @description: 动态表单 api
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2022/1/15
 */
import request from '@/utils/request'

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

// 获取流程开始事件表单数据
export function getProcessStartEventFormData (processDefId) {
  return request({
    url: '/workflow/form/getProcessStartEventFormData/' + processDefId,
    method: 'get'
  })
}

// 获取表单任务数据
export function getFormTaskData (taskId) {
  return request({
    url: '/workflow/form/getTaskFormData/' + taskId,
    method: 'get'
  })
}

// 获取历史表单任务数据
export function getHistoryFormTaskData (query) {
  return request({
    url: '/workflow/form/getHistoryFormTaskData',
    method: 'get',
    params: query
  })
}
