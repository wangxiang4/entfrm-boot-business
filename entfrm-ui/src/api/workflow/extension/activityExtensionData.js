/**
 * @program: entfrm-ui
 *
 * @description: 活动扩展数据 api
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2022/1/15
 */
import request from '@/utils/request'

// 查找活动扩展数据
export function findByDefIdAndTaskId (query) {
  return request({
    url: '/workflow/extension/activityExtensionData/findByDefIdAndTaskId',
    method: 'get',
    params: query
  })
}
