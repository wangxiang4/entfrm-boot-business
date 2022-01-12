<template>
  <div>
    <h4 style="text-align:center">{{formTitle}}</h4>
    <el-tabs type="border-card" v-model="taskSelectedTab">
      <el-tab-pane label="表单信息" name="formInfo">
        <component v-if="formType === '2'"
                   ref="form"
                   :is="formPath"
                   :formReadOnly="formReadOnly"
                   :businessId="businessId"
        />
        <workflow-preview-form v-if="formType !== '2'" ref="form" :taskFormData="taskFormData"/>
      </el-tab-pane>
      <el-tab-pane v-if="processInsId" label="流程信息" name="processInfo">
        <workflow-time-line :historicTaskList="historicTaskList"/>
      </el-tab-pane>
      <el-tab-pane label="流程图" name="processChart">
         <el-card class="box-card" shadow="hover">
            <div slot="header" class="clearfix">
              <span>流程图</span>
            </div>
            <flowable-chart :options="processChat" style="height:100vh"/>
          </el-card>
      </el-tab-pane>
      <el-tab-pane label="流转记录" v-if="processInsId" name="flowRecord">
        <workflow-step :historicTaskList="historicTaskList"/>
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
    <div class="workflow-form__footer">
      <template v-for="(button, index) in buttons">
        <template v-show="button.isHide === '0'">
          <el-button v-if="button.code !== '_flow_print'"
                     plain
                     type="primary"
                     :key="index"
                     @click="submit(button, buttons)"
          >{{button.name}}</el-button>
          <el-button v-if="button.code === '_flow_print'"
                     plain
                     type="primary"
                     v-print="printInfo"
                     :key="index"
                     @click="submit(button, buttons)"
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
  findByDefIdAndTaskIdAndKey,
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
      formKey: '',
      formType: '',
      formPath: '',
      formReadOnly: false,
      taskSelectedTab: 'formInfo',
      historicTaskList: [],
      processDefId: '',
      processInsId: '',
      processDefKey: '',
      taskId: '',
      taskDefKey: '',
      taskFormData: [],
      status: '',
      formTitle: '',
      businessId: '',
      buttons: [],
      isCC: false,
      isAssign: false,
      printInfo: {
        id: 'print',
        popTitle: '',
        extraCss: '',
        extraHead: '<meta http-equiv="Content-Language" content="zh-cn"/>'
      },
      auditForm: {
        message: '',
        mesCode: '',
        mesName: '',
        userIds: null,
        assignee: null
      },
      processChat: {}
    }
  },
  activated () {
    this.init()
    this.$nextTick(() => {
      // 加载流程图数据
      if (this.processInsId) {
        getProcessInsFlowChart(this.processInsId).then(response => {
          this.processChat = response
        })
      } else {
        getProcessDefFlowChart(this.processDefId).then(({data}) => {
          this.processChat = { bpmnXml: data }
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
        this.buttons = [{ code: '_flow_start', name: '启动', isHide: '0' }]
      } else if (this.processDefKey && this.taskDefKey) {
        // 获取流程设计器配置按钮
        findByDefIdAndTaskIdAndKey({
          processDefId: this.processDefKey,
          activityDefId: this.taskDefKey
        }).then(({ data }) => {
          this.buttons = data.workflowButtonList
        })
      }
      // 读取历史任务列表
      if (this.processInsId) {
        getHistoryFlowChangeList(this.processInsId).then(({ data }) => {
          this.historicTaskList = data
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
            this.$router.push('/workflow/workflow/task/TodoList')
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
          this.$router.push('/workflow/workflow/task/TodoList')
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
        this.$router.push('/workflow/workflow/task/TodoList')
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
        this.$router.push('/workflow/workflow/task/TodoList')
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
        this.$router.push('/flowable/task/TodoList')
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
          this.$router.push('/workflow/workflow/task/TodoList')
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
              this.$router.push('/workflow/workflow/task/TodoList')
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
            this.$router.push('/workflow/workflow/task/TodoList')
            this.cc(data)
          }
        })
      }
    },
    submit (currentBtn, buttons) {
      // 存储流程变量
      let vars = {}
      // 把当前操作对应的自定义按钮(以_flow_开头的是系统按钮，排除在外）的编码，存储为对应的流程变量，值设置为true，其余自定义按钮编码对应的流程变量值为false。
      buttons.forEach((btn) => {
        if (btn.code && !btn.code.startsWith('_flow_')) {
          vars[btn.code] = false
        }
      })
      if (currentBtn.code && !currentBtn.code.startsWith('_flow_')) {
        vars[currentBtn.code] = true
      }
      // 流程标题
      vars.title = this.formTitle
      // 指定的下一步骤处理人
      vars.assignee = this.auditForm.assignee
      // 提交类型
      this.auditForm.mesCode = currentBtn.code
      // 按钮文字
      this.auditForm.mesName = currentBtn.name
      switch (currentBtn.code) {
        case '_flow_start': // 自动流程
          this.start(vars)
          break
        case '_flow_save': // 保存草稿
          this.save()
          break
        case '_flow_agree': // 同意
          this.agree()
          break
        case '_flow_reject': // 驳回
          this.reject()
          break
        case '_flow_back': // 驳回到任意步骤
          this.turnBack()
          break
        case '_flow_add_multi_instance': // 加签
          this.addMultiInstance()
          break
        case '_flow_del_multi_instance': // 减签
          this.delMultiInstance()
          break
        case '_flow_transfer': // 转办
          this.transfer()
          break
        case '_flow_delegate':// 外派
          this.delegate()
          break
        case '_flow_stop':// 终止
          this.stop()
          break
        case '_flow_print':// 打印
          this.print()
          break
        default:
          this.commit(vars) // 自定义按钮提交
      }
    }
  }
}
</script>
