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

// 流程抄送保存
export function workflowCopySave (userIds, data) {
  return request({
    url: '/workflow/extension/workflowCopy/save/' + userIds,
    method: 'post',
    data: data
  })
}
