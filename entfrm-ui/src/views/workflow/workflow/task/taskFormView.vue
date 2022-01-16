<template>
  <div>
    <h4 style="text-align:center">{{formTitle}}</h4>
    <img v-if="processCode == '_workflow_process_waiting'" class="process-status-img" src="../../../../assets/workflow/waiting.png"/>
    <img v-if="processCode == '_workflow_process_agree'" class="process-status-img" src="../../../../assets/workflow/agree.png"/>
    <img v-if="processCode == '_workflow_process_revoke'" class="process-status-img" src="../../../../assets/workflow/revoke.png"/>
    <img v-if="processCode == '_workflow_process_reject'" class="process-status-img" src="../../../../assets/workflow/reject.png"/>
    <img v-if="processCode == '_workflow_process_stop'" class="process-status-img" src="../../../../assets/workflow/stop.png"/>
    <img v-if="processCode == '_workflow_process_deleted'" class="process-status-img" src="src/assets/workflow/deleted.png"/>
    <el-tabs type="border-card" v-model="taskSelectedTab">
      <el-tab-pane label="表单信息" name="formInfo">
        <!-- 动态表单:内置使用枇杷表单设计器 -->
        <workflow-preview-form v-if="formType !== '2'"
                               ref="form"
                               :taskFormData="taskFormData"
        />
        <!-- 外置表单:内置使用用户自定义的vue页面,手动填写页面路径即可 -->
        <component v-if="formType === '2'"
                   ref="form"
                   :is="formPath"
                   :formReadOnly="formReadOnly"
                   :businessId="businessId"
        />
      </el-tab-pane>
      <el-tab-pane v-if="processInsId" label="流程信息" name="processInfo">
        <workflow-time-line :history-flow-change-list="historyFlowChangeList"/>
      </el-tab-pane>
      <el-tab-pane label="流程图"  name="processChart">
        <el-card class="box-card" shadow="hover">
          <div slot="header" class="clearfix"><span>流程图</span></div>
          <flowable-chart ref="flowableChart" style="height:100vh"/>
        </el-card>
      </el-tab-pane>
      <el-tab-pane v-if="processInsId" label="流转记录" name="flowRecord">
        <workflow-step :history-flow-change-list="historyFlowChangeList"/>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import workflowPreviewForm from './workflowPreviewForm'
import workflowStep from './workflowStep'
import workflowTimeLine from './workflowTimeLine'
import { getHistoryFlowChangeList, getProcessInsFlowChart } from '@/api/workflow/workflow/task'
import { getProcessDefFlowChart } from '@/api/workflow/workflow/process'
import { getHistoryFormTaskData } from '@/api/workflow/workflow/form'
import { queryProcessStatus } from '@/api/workflow/workflow/process'

export default {
  name: 'TaskFormView',
  components: { workflowPreviewForm, workflowStep, workflowTimeLine },
  data () {
    return {
      // 流程表单标题
      formTitle: '',
      // 流程表单key
      formKey: '',
      // 表单类型(1:动态表单,2:外置表单)
      formType: '',
      // 外置表单路径
      formPath: '',
      // 外置表单是否只读
      formReadOnly: false,
      // 外置表单业务数据绑定ID
      businessId: '',
      // 动态表单字段配置数据
      taskFormData: [],

      // 设置选择任务选项卡
      taskSelectedTab: 'formInfo',
      // 流程任务ID
      taskId: '',
      // 流程任务定义key
      taskDefKey: '',

      // 流程定义ID
      processDefId: '',
      // 流程实例ID
      processInsId: '',
      // 流程定义Key
      processDefKey: '',
      // 流程操作编码
      processCode: '_workflow_process_waiting',

      // 历史流转信息
      historyFlowChangeList: []
    }
  },
  activated () {
    this.init()
    this.$nextTick(() => {
      // 获取流程图数据
      if (this.processInsId) {
        getProcessInsFlowChart(this.processInsId).then(response => {
          this.$refs.flowableChart.setHighlightImportDiagram(response)
        })
      } else {
        getProcessDefFlowChart(this.processDefId).then(({data}) => {
          this.$refs.flowableChart.setHighlightImportDiagram({bpmnXml: data})
        })
      }
      // 初始化外置表单
      if (this.formType === '2') {
        if (this.formKey === '/404') {
          this.formPath = ''
          this.$message.info('没有关联流程表单!')
        } else {
          this.formPath = require('@/views' + this.formKey + '.vue').default
        }
        // 初始化动态表单
      } else {
        if (this.formKey === '/404') {
          this.$refs.form.init('')
        } else {
          this.$refs.form.init(this.formKey)
        }
        getHistoryFormTaskData({
          processInsId: this.processInsId,
          processDefId: this.processDefId,
          taskDefKey: this.taskDefKey
        }).then(({data}) => {
          this.taskFormData = data
        })
      }
      // 获取当前流程状态
      queryProcessStatus(this.processInsId).then(({data}) => {
        this.processCode = data && data.mesCode
      })
      // 获取历史任务流转列表
      if (this.processInsId) {
        getHistoryFlowChangeList(this.processInsId).then(({data}) => {
          this.historyFlowChangeList = data
        })
      }
    })
  },
  methods: {
    init () {
      this.taskSelectedTab = 'formInfo'
      this.processDefId = this.$route.query.processDefId
      this.processInsId = this.$route.query.processInsId
      this.processDefKey = this.$route.query.processDefKey
      this.formType = this.$route.query.formType
      this.formKey = this.$route.query.formKey
      this.taskId = this.$route.query.taskId
      this.taskDefKey = this.$route.query.taskDefKey
      this.formTitle = this.$route.query.formTitle
      this.businessId = this.$route.query.businessId
      this.formReadOnly = true
    }
  }
}
</script>
<style lang="scss">
.process-status-img {
    height: 180px;
    position: absolute;
    z-index: 999;
    top: 1px;
    right: 1px;
}
</style>
