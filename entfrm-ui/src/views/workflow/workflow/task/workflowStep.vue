<template>
  <el-card class="box-card" shadow="hover" style="margin-top:5px">
    <div slot="header" class="clearfix">
      <span>流转记录</span>
    </div>
    <el-steps :active="historyTaskStepNodeList.length">
      <el-step v-for="(node, index) in historyTaskStepNodeList"
               :key="index"
               :title="node.activityName" finish-status="success"
               :description="node.assigneeName + node.time"
      />
    </el-steps>
    <el-table size="small" :data="historyTaskStepNodeList" style="width: 100%">
      <el-table-column prop="histIns.activityName" label="执行环节" width="180"/>
      <el-table-column prop="assigneeName" label="执行人" width="180"/>
      <el-table-column prop="histIns.startTime" label="开始时间">
      <template slot-scope="scope">
        {{scope.row.histIns.startTime | formatDate}}
      </template>
    </el-table-column>
      <el-table-column prop="histIns.endTime" label="结束时间">
        <template slot-scope="scope">
          {{scope.row.histIns.endTime | formatDate}}
        </template>
      </el-table-column>
      <el-table-column prop="comment.status" label="办理状态"/>
      <el-table-column prop="comment.message" label="审批意见"/>
      <el-table-column prop="durationTime" label="任务历时">
        <template slot-scope="scope">
          {{scope.row.durationTime || '0秒'}}
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>
<script>
import { parseTime } from '@/utils/entfrm'

export default {
  name: 'WorkflowStep',
  props: {
    historyTaskList: {
      type: Array,
      default: []
    }
  },
  computed: {
    historyTaskStepNodeList () {
      const taskStepNode = []
      this.historyTaskMap.forEach((item) => {
        const obj = {activityName: '', assigneeName: '', time: ''}
        item.forEach((node) => {
          obj.activityName = node.historicActivityInstance.activityName
          obj.assigneeName += (node.assigneeName || '') + ','
          obj.time = (!node.historicActivityInstance.startTime ? '--' : this.parseTime(node.histIns.startTime, 'YYYY-MM-DD HH:mm:ss'))
        })
        taskStepNode.push(obj)
      })
      return taskStepNode
    },
    historyTaskMap () {
      let map = new Map()
      this.historyTaskList.forEach((task) => {
        const key = task.historicActivityInstance.activityId + parseInt(task.historicActivityInstance.startTime / 1000)
        const val = map.get(key)
        if (val) {
          val.push(task)
        } else {
          const array = []
          array.push(task)
          map.set(key, array)
        }
      })
      return map
    }
  }
}
</script>
