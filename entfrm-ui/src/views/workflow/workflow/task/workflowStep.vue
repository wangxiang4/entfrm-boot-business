<template>
  <el-card class="box-card" shadow="hover" style="margin-top:5px">
    <div slot="header" class="clearfix">
      <span>流转记录</span>
    </div>
    <el-steps :active="historyFlowChangeStepList.length">
      <el-step v-for="(historyFlowChangeStep, index) in historyFlowChangeStepList"
               :key="index"
               :title="historyFlowChangeStep.activityName" finish-status="success"
               :description="historyFlowChangeStep.assigneeName + historyFlowChangeStep.time"
      />
    </el-steps>
    <el-table size="small" :data="historyFlowChangeList" style="width: 100%">
      <el-table-column prop="historicActivityInstance.activityName" label="执行环节"/>
      <el-table-column prop="assigneeName" label="执行人"/>
      <el-table-column prop="historicActivityInstance.startTime" label="开始时间">
      <template slot-scope="scope">
        {{getHistoricActivityInstance(scope.row).startTime | formatDate}}
      </template>
    </el-table-column>
      <el-table-column prop="historicActivityInstance.endTime" label="结束时间">
        <template slot-scope="scope">
          {{getHistoricActivityInstance(scope.row).endTime | formatDate}}
        </template>
      </el-table-column>
      <el-table-column prop="activityCommentInfo.mesName" label="办理状态"/>
      <el-table-column prop="activityCommentInfo.message" label="审批意见"/>
      <el-table-column prop="durationTime" label="任务历时">
        <template slot-scope="scope">
          {{scope.row.durationTime || '0秒'}}
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>
<script>
export default {
  name: 'WorkflowStep',
  props: {
    historyFlowChangeList: {
      type: Array,
      default: []
    }
  },
  computed: {
    historyFlowChangeStepList() {
      const historyFlowChangeStepList = []
      this.historyFlowChangeList.forEach((item) => {
        historyFlowChangeStepList.push({
          activityName: this.getHistoricActivityInstance(item).activityName,
          assigneeName: (item.assigneeName || '') + ',',
          time: (!this.getHistoricActivityInstance(item).startTime ? '--' : this.parseTime(this.getHistoricActivityInstance(item).startTime))
        })
      })
      return historyFlowChangeStepList
    }
  },
  methods: {
    getHistoricActivityInstance (historyFlowChange) {
      return historyFlowChange.historicActivityInstance || {}
    }
  }
}
</script>
