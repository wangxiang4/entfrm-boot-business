/**
 * @program: entfrm-ui
 *
 * @description: 流程抄送 api
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2022/1/15
 */
import request from '@/utils/request'

// 查询流程抄送列表
export function listWorkflowCopy(query) {
  return request({
    url: '/workflow/extension/workflowCopy/list',
    method: 'get',
    params: query
  })
}

// 删除流程抄送
export function delWorkflowCopy(id) {
  return request({
    url: '/workflow/extension/workflowCopy/remove/' + id,
    method: 'delete'
  })
}

// 保存流程抄送
export function workflowCopySave (userIds, data) {
  return request({
    url: '/workflow/extension/workflowCopy/save/' + userIds,
    method: 'post',
    data: data
  })
}
