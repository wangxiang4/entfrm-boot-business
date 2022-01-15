<template>
  <el-card class="box-card" shadow="hover">
    <div slot="header" class="clearfix">
      <span>流程信息</span>
    </div>
    <el-timeline v-if="historyFlowChangeList.length" :reverse="true">
      <el-timeline-item  v-for="(historyFlowChange, index) in historyFlowChangeList"
                         color="#3f9eff"
                         :key="index"
                         :timestamp="parseTime(getHistoricActivityInstance(historyFlowChange).endTime, '{y}-{m}-{d}')"
                         placement="top"
      >
        <el-card class="workflow">
          <h4>{{getHistoricActivityInstance(historyFlowChange).activityName}}</h4>
          <el-row :gutter="25">
            <el-col class="tip" style="margin-left:10px" :span="11">
              <div class="item">
                <span class="label">审批人 : </span>
                <span class="value">{{historyFlowChange.assigneeName}}</span>
              </div>
              <div class="item">
                <span class="label">办理状态 : </span>
                <span class="value">
                  <el-tag :type="historyFlowChange.activityCommentInfo.mesLevel"
                          effect="dark"
                          size="small"
                  >{{historyFlowChange.activityCommentInfo.mesName}}</el-tag>
                </span>
              </div>
              <div class="item">
                <span class="label">审批意见 : </span>
                <el-tooltip effect="dark"
                            :content="historyFlowChange.activityCommentInfo.message"
                            placement="top-start"
                >
                  <span class="value">{{historyFlowChange.activityCommentInfo.message}}</span>
                </el-tooltip>
              </div>
              <div class="item">
                <span class="label">开始时间 : </span>
                <span class="value">{{getHistoricActivityInstance(historyFlowChange).startTime | formatDate}}</span>
              </div>
              <div class="item">
                <span class="label">结束时间 : </span>
                <span class="value">{{getHistoricActivityInstance(historyFlowChange).endTime | formatDate}}</span>
              </div>
              <div class="item">
                <span class="label">用时 : </span>
                <span class="value">{{historyFlowChange.durationTime || '0秒'}}</span>
              </div>
            </el-col>
          </el-row>
        </el-card>
      </el-timeline-item>
    </el-timeline>
  </el-card>
</template>
<script>
export default {
  name: 'WorkflowTimeLine',
  props: {
    historyFlowChangeList: {
      type: Array,
      default: []
    }
  },
  methods: {
    getHistoricActivityInstance (historyFlowChange) {
      return historyFlowChange.historicActivityInstance || {}
    }
  }
}
</script>
<style lang="scss">
.workflow{
  .item {
    height: 32px;
    line-height: 32px;
    margin-bottom: 8px;

    .label {
      display: inline-block;
      height: 100%;
      width: 70px;
      font-size: 14px;
      color: #5e6d82;
      text-align: end;
      vertical-align: top;

      &::after {
          display: inline-block;
          width: 100%;
          content: '';
          height: 0;
      }
    }

    .value {
      padding-left: 10px;
      font-size: 14px;
      max-width: calc(100% - 90px);
      color: #5e6d82;
      display: inline-block;
      overflow:hidden;
      white-space:nowrap;
      text-overflow: ellipsis
    }
  }
}
</style>
