import request from '@/utils/request'

// 查询任务列表
export function listTask(query) {
  return request({
    url: '/workflow/task/list',
    method: 'get',
    params: query
  })
}


// 查询任务详细
export function getTskDef(data) {
  return  request({
    url: '/workflow/task/getTskDef',
    method: 'get',
    params: data
  })
}




// 外置表单审批
export function audit(data) {
  return request({
    url: '/workflow/task/audit',
    method: 'post',
    data: data
  })
}


// 动态表单审批
export function submitTaskFormData(data) {
  return request({
    url: '/workflow/form/submitTaskFormData',
    method: 'put',
    data: data
  })
}


// 获取动态表单数据
export function getFormData(code,procInsId) {
  return request({
    url: '/workflow/form/getTaskFormData',
    method: 'get',
    params: {code,procInsId}
  })
}



// 获取可驳回的节点
export function backNodes(data) {
  return request({
    url: '/workflow/task/backNodes',
    method: 'post',
    params: data
  })
}


//驳回
export function back(data) {
  return request({
    url: '/workflow/task/back',
    method: 'post',
    params: data
  })
}




