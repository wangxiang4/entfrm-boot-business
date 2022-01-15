<template>
  <div>
    <el-main style="min-height: 100vh">
      <h4 style="text-align:center">{{formTitle}}</h4>
      <el-tabs type="border-card" v-model="taskSelectedTab">
        <el-tab-pane label="表单信息" name="formInfo" id="printForm">
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
        <el-tab-pane label="流程图" name="processChart">
          <el-card class="box-card" shadow="hover">
            <div slot="header" class="clearfix"><span>流程图</span></div>
            <flowable-chart ref="flowableChart" style="height:100vh"/>
          </el-card>
        </el-tab-pane>
        <el-tab-pane v-if="processInsId" label="流转记录" name="flowRecord">
          <workflow-step :history-flow-change-list="historyFlowChangeList"/>
        </el-tab-pane>
      </el-tabs>
      <el-card v-if="!processInsId || taskId" style="margin-top:10px;margin-bottom:66px;">
        <el-form size="small"
                 ref="auditForm"
                 :model="auditForm"
                 label-width="120px"
        >
          <el-col :span="16">
            <el-form-item v-if="!processInsId"
                          label="流程标题"
                          prop="formTitle"
            >
              <el-input v-model="formTitle" placeholder="请输入流程标题"/>
            </el-form-item>
            <el-form-item v-if="taskId"
                          label="审批信息"
                          prop="message"
            >
              <el-input v-model="auditForm.message"
                        type="textarea"
                        :rows="3"
                        placeholder="请输入审批意见"
              />
            </el-form-item>
          </el-col>
          <el-col :span="16">
            <el-form-item>
              <el-checkbox v-model="isCC">是否抄送</el-checkbox>
            </el-form-item>
          </el-col>
          <el-col :span="16">
            <el-form-item v-if="isCC"
                          label="抄送给"
                          :rules="[{required: true, message: '用户不能为空', trigger: 'blur'}]"
                          prop="userIds"
            >
              <user-select :value="auditForm.userIds" @getValue="(value) => { auditForm.userIds=value }"/>
            </el-form-item>
          </el-col>
          <el-col :span="16">
            <el-form-item>
              <el-checkbox v-model="isAssign">指定下一步处理者(不设置就使用默认处理人)</el-checkbox>
            </el-form-item>
          </el-col>
          <el-col :span="16">
            <el-form-item v-if="isAssign"
                          :rules="[{required: true, message: '用户不能为空', trigger: 'blur'}]"
                          prop="assignee"
                          label="指定"
            >
              <user-select :limit="1" :value="auditForm.assignee" @getValue="(value) => {auditForm.assignee=value}"/>
            </el-form-item>
          </el-col>
        </el-form>
      </el-card>
    </el-main>
    <div class="workflow-form-footer">
      <template v-for="(button, index) in buttons">
        <template v-show="button.isHide === '0'">
          <!-- 渲染配置按钮 -->
          <el-button v-if="button.code !== '_workflow_activity_print'"
                     plain
                     type="primary"
                     :key="index"
                     @click="submit(button)"
          >{{button.name}}</el-button>
          <!-- 渲染打印按钮 -->
          <el-button v-if="button.code === '_workflow_activity_print'"
                     plain
                     type="primary"
                     v-print="printInfo"
                     :key="index"
                     @click="submit(button)"
          >{{button.name}}</el-button>
        </template>
      </template>
    </div>
    <roll-back-task-nodes ref="rollBackTaskNodes" @getRollBackTaskDefKey="back"/>
    <user-select-dialog title="选择转办用户"
                        ref="transferUserSelectDialog"
                        :limit="1"
                        @doSubmit="selectUsersToTransferTask"
    />
    <user-select-dialog title="选择委派用户"
                        ref="delegateUserSelectDialog"
                        :limit="1"
                        @doSubmit="selectUsersToDeleteTask"
    />
    <user-select-dialog title="选择加签用户"
                        ref="addSignTaskUserSelectDialog"
                        @doSubmit="selectUsersToAddSignTask"
    />
  </div>
</template>

<script>
import userSelect from '@/components/UserSelect'
import workflowPreviewForm from './workflowPreviewForm'
import rollBackTaskNodes from './rollBackTaskNodes'
import workflowStep from './workflowStep'
import workflowTimeLine from './workflowTimeLine'
import userSelectDialog from '@/components/UserSelect/UserSelectDialog'
import {
  getProcessStartEventFormData,
  getProcessDefFlowChart,
  getProcessInsFlowChart,
  getTaskFormData,
  findByDefIdAndTaskId,
  getHistoryFlowChangeList,
  workflowCopySave,
  startProcessDefinition,
  auditTask,
  rejectTask,
  rollBackTaskList,
  addSignTask,
  transferTask,
  delegateTask
} from '@/api/workflow/workflow/task'
import { stopProcessInstance } from '@/api/workflow/workflow/process'

export default {
  name: 'TaskForm',
  components: {
    userSelect,
    userSelectDialog,
    workflowPreviewForm,
    rollBackTaskNodes,
    workflowStep,
    workflowTimeLine
  },
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

      // 当前任务表单操作状态
      status: '',
      // 历史流转信息
      historyFlowChangeList: [],
      // 当前操作按钮配置信息
      buttons: [],
      // 是否抄送
      isCC: false,
      // 是否指定代理人
      isAssign: false,
      // 打印表单信息
      printInfo: {
        id: 'printForm',
        popTitle: '',
        extraCss: '',
        extraHead: '<meta http-equiv="Content-Language" content="zh-cn"/>'
      },
      // 审批表单信息
      auditForm: {
        message: '',
        mesCode: '',
        mesName: '',
        userIds: null,
        assignee: null
      }
    }
  },
  activated () {
    this.init()
    this.$nextTick(() => {
      // 加载流程图数据
      if (this.processInsId) {
        getProcessInsFlowChart(this.processInsId).then(response => {
          this.$refs.flowableChart.setHighlightImportDiagram(response)
        })
      } else {
        getProcessDefFlowChart(this.processDefId).then(({data}) => {
          this.$refs.flowableChart.setHighlightImportDiagram({ bpmnXml: data })
        })
      }
      // 读取外置表单
      if (this.formType === '2') {
        if (this.formKey === '/404') {
          this.formPath = ''
          this.$message.info('没有关联流程表单!')
        } else {
          this.formPath = require('@/views' + this.formKey + '.vue').default
        }
        // 读取动态表单
      } else {
        if (this.formKey === '/404') {
          this.$refs.form.init('')
        } else {
          this.$refs.form.init(this.formKey)
        }
        // 获取启动表单数据
        if (this.status === 'start') {
          getProcessStartEventFormData(this.processDefId).then(({data}) => {
            this.taskFormData = data
          })
          // 获取任务表单数据
        } else {
          getTaskFormData(this.taskId).then(({data}) => {
            this.taskFormData = data.taskFormData
          })
        }
      }
      // 读取按钮配置
      if (this.status === 'start') {
        this.buttons = [{ code: '_workflow_activity_start', name: '启动', isHide: '0' }]
      } else if (this.processDefKey && this.taskDefKey) {
        // 获取流程设计器配置按钮
        findByDefIdAndTaskId({
          processDefId: this.processDefKey,
          activityDefId: this.taskDefKey
        }).then(({ data }) => {
          this.buttons = data.workflowButtonList
        })
      }
      // 读取历史任务列表
      if (this.processInsId) {
        getHistoryFlowChangeList(this.processInsId).then(({ data }) => {
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
      this.status = this.$route.query.status
      this.formTitle = this.$route.query.formTitle
      this.businessId = this.$route.query.businessId
      this.formReadOnly = this.$route.query.formReadOnly
      this.printInfo.popTitle = this.formTitle
      this.isCC = false
      this.isAssign = false
      this.auditForm.assignee = null
      this.auditForm.userIds = null
      this.auditForm.message = ''
    },
    cc (data) {
      if (this.isCC && this.auditForm.userIds) {
        this.$refs['auditForm'].validate((valid) => {
          if (valid) {
            workflowCopySave(this.auditForm.userIds, {
              processDefId: this.processDefId,
              processInsId: data.processInsId,
              processDefName: '',
              processInsName: this.formTitle,
              taskName: ''
            })
          }
        })
      }
    },
    /** 暂存草稿 */
    save () {
    },
    /** 启动流程 */
    start (vars) {
      // 外置表单
      if (this.formType === '2') {
        this.$refs.form.saveForm((businessTable, businessId) => {
          startProcessDefinition({
            processDefKey: this.processDefKey,
            businessTable: businessTable,
            businessId: businessId,
            ...vars,
            title: this.formTitle,
            assignee: this.auditForm.assignee,
          }).then(({data}) => {
            this.$message.success(data.msg)
            this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
            this.$router.push('/workflow/transaction/TodoList')
            this.cc({ processInsId: data })
          })
        })
      // 动态表单
      } else {
        this.$refs.form.startFormProcessDefinition({
          processDefId: this.processDefId,
          ...vars,
          title: this.formTitle,
          assignee: this.auditForm.assignee
        }, ({data}) => {
          this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
          this.$router.push('/workflow/transaction/TodoList')
          this.cc({ processInsId: data })
        })
      }
    },
    /** 同意 */
    agree (vars) {
      this.commit(vars) // 同意
    },
    /** 驳回 */
    reject () {
      this.$confirm(`确定驳回流程吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        rollBackTaskList(this.taskId).then(({ data }) => {
          if (data.length > 0) {
            let backTaskDefKey = data[data.length - 1].taskDefKey
            this.back(backTaskDefKey)
          }
        })
      })
    },
    /** 驳回到任意节点 */
    turnBack () {
      this.$refs.taskBackNodes.init(this.taskId)
    },
    /** 回退到任意节点 */
    back (backTaskDefKey) {
      rejectTask({
        currentTaskId: this.taskId,
        rollBackTaskDefKey: backTaskDefKey,
        comment: this.auditForm
      }).then(({data}) => {
        this.$message.success(data.msg)
        this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
        this.$router.push('/workflow/transaction/TodoList')
        this.cc({ processInsId: data })
      })
    },
    /** 加签 */
    addMultiInstance () {
      // this.$refs.addSignTaskUserSelectDialog.init()
    },
    selectUsersToAddSignTask (users) {
      const userIds = users.map(user => user.id).join(',')
      addSignTask({
        taskId: this.taskId,
        userIds: userIds,
        comment: '',
        mark: false
      }).then(({ data }) => {
        this.$message.success(data)
      })
    },
    /** 减签 */
    delMultiInstance () {
    },
    /** 转办 */
    transfer () {
      this.$refs.transferUserSelectDialog.init()
    },
    selectUsersToTransferTask (user) {
      transferTask({
        askId: this.taskId, userId: user[0].id
      }).then(({ data }) => {
        this.$message.success(data)
        this.$router.push('/workflow/transaction/TodoList')
      })
    },
    /** 委托 */
    delegate () {
      this.$refs.delegateUserSelectDialog.init()
    },
    selectUsersToDeleteTask (user) {
      delegateTask({
        taskId: this.taskId,
        userId: user[0].id
      }).then(({ data }) => {
        this.$message.success(data)
        this.$router.push('/workflow/transaction/TodoList')
      })
    },
    /** 终止 */
    stop () {
      this.$confirm(`确定终止流程吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        stopProcessInstance({
          processInsId: this.processInsId,
          ...this.auditForm
        }).then(({ data }) => {
          this.$message.success(data)
          this.$router.push('/workflow/transaction/TodoList')
        })
      })
    },
    /** 打印 */
    print () {
    },
    /** 自定义按钮提交 */
    commit (vars) {
      // 外置表单
      if (this.formType === '2') {
        this.$refs.form.saveForm((businessTable, businessId) => {
          auditTask({
            taskId: this.taskId,
            taskDefKey: this.taskDefKey,
            processInsId: this.processInsId,
            processDefId: this.processDefId,
            vars: vars,
            activityCommentInfo: this.auditForm,
            assignee: this.auditForm.assignee
          }).then(({data}) => {
            if (data.success) {
              this.$message.success(data.msg)
              this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
              this.$router.push('/workflow/transaction/TodoList')
              this.cc(data)
            }
          })
        })
      // 动态表单
      } else {
        this.$refs.form.auditFormTask({
          taskId: this.taskId,
          processInsId: this.processInsId,
          vars: vars,
          activityCommentInfo: this.auditForm,
          assignee: this.auditForm.assignee
        }, ({ data }) => {
          if (data.success) {
            this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
            this.$router.push('/workflow/transaction/TodoList')
            this.cc(data)
          }
        })
      }
    },
    submit (button) {
      // 存储流程变量
      const vars = {}
      // 流程表单标题
      vars.title = this.formTitle
      // 指定的下一步骤处理人
      vars.assignee = this.auditForm.assignee
      // 操作类型
      this.auditForm.mesCode = button.code
      // 操作名称
      this.auditForm.mesName = button.name
      switch (button.code) {
        // 启动流程
        case '_workflow_activity_start':
          this.start(vars)
          break
        // 保存草稿
        case '_workflow_activity_save':
          this.save()
          break
        // 同意
        case '_workflow_activity_agree':
          this.agree()
          break
        // 驳回
        case '_workflow_activity_reject':
          this.reject()
          break
        // 驳回到任意步骤
        case '_workflow_activity_roll_back':
          this.turnBack()
          break
        // 加签
        case '_workflow_activity_add_multi_instance':
          this.addMultiInstance()
          break
        // 减签
        case '_workflow_activity_del_multi_instance':
          this.delMultiInstance()
          break
        // 转办
        case '_workflow_activity_transfer':
          this.transfer()
          break
        // 外派
        case '_workflow_activity_delegate':
          this.delegate()
          break
        // 终止
        case '_workflow_activity_stop':
          this.stop()
          break
        // 打印
        case '_workflow_activity_print':
          this.print()
          break
        // 自定义按钮提交
        default:
          this.commit(vars)
      }
    }
  }
}
</script>
