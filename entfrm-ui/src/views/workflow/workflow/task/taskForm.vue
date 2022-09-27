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
      <el-card v-if="!processInsId || taskId || status === 'reStart'" style="margin-top:10px;margin-bottom:66px;">
        <el-form ref="auditForm" :model="auditForm" size="small" label-width="120px">
          <el-col :span="16">
            <el-form-item v-if="!processInsId || status === 'reStart'" label="流程标题" prop="formTitle">
              <el-input v-model="formTitle" placeholder="请输入流程标题"/>
            </el-form-item>
            <el-form-item v-if="taskId" label="审批信息" prop="message">
              <el-input v-model="auditForm.message" type="textarea" :rows="3" placeholder="请输入审批意见"/>
            </el-form-item>
          </el-col>
          <el-col :span="16">
            <el-form-item>
              <el-checkbox v-model="isCC">是否抄送</el-checkbox>
            </el-form-item>
          </el-col>
          <el-col :span="16">
            <el-form-item v-if="isCC" label="抄送给" prop="userIds" :rules="[{required: true, message: '用户不能为空', trigger: 'blur'}]">
              <user-select :value="auditForm.userIds" @getValue="(value) => { auditForm.userIds=value }"/>
            </el-form-item>
          </el-col>
          <el-col :span="16">
            <el-form-item>
              <el-checkbox v-model="isAssign">指定下一步处理者(不设置就使用默认处理人)</el-checkbox>
            </el-form-item>
          </el-col>
          <el-col :span="16">
            <el-form-item v-if="isAssign" label="指定" prop="assignee" :rules="[{required: true, message: '用户不能为空', trigger: 'blur'}]">
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
    <roll-back-task-select ref="rollBackTaskSelect" @getRollBackTaskDefKey="handleRollBackTask"/>
    <user-select-dialog ref="transferTaskSelect" title="选择转办用户" :limit="1" @doSubmit="handleTransferTask"/>
    <user-select-dialog ref="delegateTaskSelect" title="选择委派用户" :limit="1" @doSubmit="handleDelegateTask"/>
  </div>
</template>

<script>
import userSelect from '@/components/UserSelect'
import workflowPreviewForm from './workflowPreviewForm'
import rollBackTaskSelect from './rollBackTaskSelect'
import workflowStep from './workflowStep'
import workflowTimeLine from './workflowTimeLine'
import userSelectDialog from '@/components/UserSelect/UserSelectDialog'
import { getProcessInsFlowChart, getHistoryFlowChangeList, auditTask, rejectTask, rollBackTaskList, transferTask, delegateTask } from '@/api/workflow/workflow/task'
import { getProcessStartEventFormData, getFormTaskData } from '@/api/workflow/workflow/form'
import { getProcessDefFlowChart, startProcessDefinition } from '@/api/workflow/workflow/process'
import { findByDefIdAndTaskId } from '@/api/workflow/extension/activityExtensionData'
import { workflowCopySave } from '@/api/workflow/extension/workflowCopy'
import { stopProcessInstance } from '@/api/workflow/workflow/process'

export default {
  name: 'TaskForm',
  components: {
    userSelect,
    userSelectDialog,
    workflowPreviewForm,
    rollBackTaskSelect,
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
        // 抄送用户ID
        userIds: '',
        // 任务代理人ID
        assignee: ''
      }
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
          this.$refs.flowableChart.setHighlightImportDiagram({ bpmnXml: data })
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
        // 获取启动事件表单数据
        if (this.status === 'start' || this.status === 'reStart') {
          getProcessStartEventFormData(this.processDefId).then(({data}) => {
            this.taskFormData = data
          })
        // 获取任务表单数据
        } else {
          getFormTaskData(this.taskId).then(({ data }) => {
            this.taskFormData = data
          })
        }
      }
      // 设置启动按钮配置
      if (this.status === 'start' || this.status === 'reStart') {
        this.buttons = [{ code: '_workflow_activity_start', name: '启动', isHide: '0' }]
      // 获取bpmn设计器按钮配置
      } else if (this.processDefKey && this.taskDefKey) {
        findByDefIdAndTaskId({
          processDefId: this.processDefKey,
          activityDefId: this.taskDefKey
        }).then(({ data }) => {
          this.buttons = data.workflowButtonList
        })
      }
      // 获取历史任务流转列表
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
      this.auditForm.assignee = ''
      this.auditForm.userIds = ''
      this.auditForm.message = ''
    },
    /** 流程抄送 */
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
      this.$notify({
        title: '提示',
        message: `功能正在开发中...`,
        type: 'warning'
      });
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
            ...vars
          }).then(({ data }) => {
            this.$message.success(data.msg)
            this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
            this.$router.push('/workflow/transaction/todo')
            this.cc({ processInsId: data })
          })
        })
      // 动态表单
      } else {
        this.$refs.form.startFormProcessDefinition({ processDefId: this.processDefId, ...vars }, ({ data }) => {
          this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
          this.$router.push('/workflow/transaction/todo')
          this.cc({ processInsId: data })
        })
      }
    },
    /** 同意任务 */
    agree (vars) {
      this.commit(vars)
    },
    /** 驳回任务 */
    reject () {
      this.$confirm(`确定驳回任务吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        rollBackTaskList(this.taskId).then(({ data }) => {
          if (data.length > 0) {
            const backTaskDefKey = data[data.length - 1].taskDefKey
            this.handleRollBackTask(backTaskDefKey)
          }
        })
      }).catch(function (){})
    },
    /** 转办 */
    transfer () {
      this.$refs.transferTaskSelect.init()
    },
    /** 委托 */
    delegate () {
      this.$refs.delegateTaskSelect.init()
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
          this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
          this.$router.push('/workflow/transaction/todo')
          this.cc({ processInsId: this.processInsId })
        })
      }).catch(function() {})
    },
    /** 打印 */
    print () {
      console.warn("---工作流表单打印成功,此处可以做一些打印回调逻辑处理!---")
    },
    /** 驳回到任意节点 */
    rollBack () {
      this.$refs.rollBackTaskSelect.init(this.taskId)
    },
    /** 加签 */
    addMultiInstance () {
      // flowable开源版加签会导致模板数量急剧扩大,需要经过内部讨论是否有比较好的解决方案:http://www.pangubpm.com/doc58.html
      this.$notify({
        title: '提示',
        message: `功能正在开发中...`,
        type: 'warning'
      });
    },
    /** 减签 */
    delMultiInstance () {
      this.$notify({
        title: '提示',
        message: `功能正在开发中...`,
        type: 'warning'
      });
    },
    /** 自定义按钮提交 */
    commit (vars) {
      // 外置表单审批
      if (this.formType === '2') {
        this.$refs.form.saveForm((businessTable, businessId) => {
          auditTask({
            taskId: this.taskId,
            taskDefKey: this.taskDefKey,
            processInsId: this.processInsId,
            processDefId: this.processDefId,
            activityCommentInfo: this.auditForm,
            assignee: this.auditForm.assignee,
            vars: vars,
          }).then(({ data }) => {
            this.$message.success(data)
            this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
            this.$router.push('/workflow/transaction/todo')
            this.cc({ processInsId: this.processInsId })
          })
        })
      // 动态表单审批
      } else {
        this.$refs.form.auditFormTask({
          taskId: this.taskId,
          processInsId: this.processInsId,
          activityCommentInfo: this.auditForm,
          assignee: this.auditForm.assignee,
          vars: vars,
        }, () => {
          this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
          this.$router.push('/workflow/transaction/todo')
          this.cc({ processInsId: this.processInsId })
        })
      }
    },
    /** 处理回退到任意节点 */
    handleRollBackTask (backTaskDefKey) {
      rejectTask({
        currentTaskId: this.taskId,
        rollBackTaskDefKey: backTaskDefKey,
        comment: this.auditForm
      }).then(({ data }) => {
        this.$message.success(data)
        this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
        this.$router.push('/workflow/transaction/todo')
        this.cc({ processInsId: this.processInsId })
      })
    },
    /** 处理转派任务 */
    handleTransferTask (userList) {
      transferTask({ taskId: this.taskId, userId: userList[0].id }).then(({ data }) => {
        this.$message.success(data)
        this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
        this.$router.push('/workflow/transaction/todo')
        this.cc({ processInsId: this.processInsId })
      })
    },
    /** 处理任务委派 */
    handleDelegateTask(userList) {
      delegateTask({
        taskId: this.taskId,
        userId: userList[0].id
      }).then(({ data }) => {
        this.$message.success(data)
        this.$store.dispatch('tagsView/delView', {fullPath: this.$route.fullPath})
        this.$router.push('/workflow/transaction/todo')
        this.cc({ processInsId: this.processInsId })
      })
    },
    submit (button) {
      // 设置流程变量
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
          this.rollBack()
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
