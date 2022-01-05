<template>
  <div class="app-container">

    <el-form :task="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="任务名称" prop="taskName">
        <el-input
          v-model="queryParams.taskName"
          placeholder="请输入任务名称"
          clearable
          size="small"
          style="width: 240px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh-right" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">

      <div class="top-right-btn">
        <el-tooltip class="item" effect="dark" content="刷新" placement="top">
          <el-button size="mini" circle icon="el-icon-refresh" @click="handleQuery"/>
        </el-tooltip>
        <el-tooltip class="item" effect="dark" :content="showSearch ? '隐藏搜索' : '显示搜索'" placement="top">
          <el-button size="mini" circle icon="el-icon-search" @click="showSearch=!showSearch"/>
        </el-tooltip>
      </div>
    </el-row>

    <el-table v-loading="loading" :data="taskList">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="实例标题" show-overflow-tooltip align="center" prop="vars.title"/>
      <el-table-column label="流程名称" show-overflow-tooltip align="center" prop="processDefinitionName"/>
      <el-table-column label="当前环节" show-overflow-tooltip align="center" prop="task.name"/>
      <el-table-column label="流程发起人" align="center" prop="vars.applyUserId"/>
      <el-table-column label="创建时间" align="center" prop="task.createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.task.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-success"
            @click="handleCheck(scope.row)"
            v-hasPerm="['task_check']"
          >办理
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.current"
      :limit.sync="queryParams.size"
      @pagination="getList"
    />

    <!-- 任务审批对话框 -->
    <el-dialog title="任务审批" :visible.sync="showCheckDialog" width="760px">

      <avue-form
        v-if="formType==='1'"
        ref="form"
        :option="formRenderData"
        v-model="formData"/>
      <component v-if="formType==='2'" ref="form" :businessId="businessId" :is="componentPath"/>

      <el-form :model="auditForm" label-width="100px" size="mini">
        <el-row>
          <el-col :span="24">
            <el-form-item label="审批意见：" >
              <el-input v-model="auditForm.message" type="textarea" :disabled="false" rows="3" placeholder="请输入审批意见"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submit(submitAgree)"  plain>同意</el-button>
        <el-button type="primary" @click="submit(submitReject)" plain>驳回</el-button>
        <el-button @click="showCheckDialog = false">关 闭</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import {listTask, getTskDef, audit, submitTaskFormData, getFormData, backNodes, back} from "@/api/workflow/task";
const _import = require('@/router/import-' + process.env.NODE_ENV)
export default {
  name: "Task",
  components:{

  },
  data() {
    return {
      submitAgree:{code:"_flowable_agree",name:"同意"},
      submitReject:{code:"_flowable_reject",name:"驳回"},
      // 遮罩层
      loading: true,
      // 总条数
      total: 0,
      // 任务表格数据
      taskList: [],
      // 是否显示审批弹出层
      showCheckDialog: false,
      // 查询任务
      queryParams: {
        current: 1,
        size: 10,
        taskName: undefined
      },
      // 显示搜索条件
      showSearch: true,
      //表单类型
      formType:0,
      //动态表单数据
      formData:{},
      //业务表单ID
      businessId:'',
      //组件路径
      componentPath:'',
      //渲染表单数据
      formRenderData:{},
      //审核表单
      auditForm:{}
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询任务列表 */
    getList() {
      this.loading = true;
      listTask(this.queryParams).then(response => {
          this.taskList = response.data;
          this.total = response.total;
          this.loading = false;
        }
      );
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.current = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
    },
    reset() {
      this.formData = {}
      this.formRenderData = {}
    },
    /** 流程审批按钮操作 */
    handleCheck(row) {
      this.reset();
      this.taskId=row.task.id
      this.taskName=row.task.name
      this.taskDefKey=row.task.taskDefinitionKey
      this.procInsId=row.task.processInstanceId
      this.procDefId=row.task.processDefinitionId
      this.procDefKey=row.task.processDefKey
      getTskDef( {
        taskId: this.taskId,
        taskName: this.taskName,
        taskDefKey: this.taskDefKey,
        procInsId: this.procInsId,
        procDefId: this.procDefId,
        procDefKey: this.procDefKey,
        status: row.status
      }).then(({data}) => {

        this.formType = data.formType
        if (!data.formType||!data.formUrl){
          this.msgError("没有关联流程表单!");
          return
        }
        if(data.formType==1){
          getFormData(data.formUrl,data.procInsId).then(response=>{
            this.formData= response.data.formData
            this.formRenderData= response.data.formRenderData
          })
        }else{
          this.businessId=data.businessId
          this.componentPath= _import(`error${data.formUrl}`)
        }
        this.formData.taskId=row.taskId
        this.showCheckDialog=true

      });
    },
    submit (currentBtn) {
      // 存储流程变量
      let vars = {}
      //评论区域存储按钮状态
      this.auditForm.type = currentBtn.code // 提交类型
      this.auditForm.status = currentBtn.name // 按钮文字
      switch (currentBtn.code) {
        // 同意
        case '_flowable_agree':
          this.agree()
          break
        // 驳回
        case '_flowable_reject':
          this.reject()
          break
        // 自定义按钮提交
        default:
          this.commit(vars)
      }
    },
    /** 同意 **/
    agree (vars) {
      this.commit(vars) // 同意
    },
    /** 自定义按钮提交 **/
    commit (vars) {
      if (this.formType === '2') {
        // 外置表单
        this.$refs.form.saveForm((businessTable, businessId) => {
          audit({
            taskId: this.taskId,
            taskDefKey: this.taskDefKey,
            procInsId: this.procInsId,
            procDefId: this.procDefId,
            vars: vars,
            comment: this.auditForm,
            assignee: this.auditForm.assignee
          }).then(({data}) => {
              this.msgSuccess(data)
              this.showCheckDialog=false
              this.getList()
          })
        })
      } else {
        // 动态表单
        submitTaskFormData({
          procInsId: this.procInsId,
          taskId: this.taskId,
          assignee: this.auditForm.assignee,
          comment: this.auditForm,
          data: JSON.stringify(this.formData)
        }).then(({data}) => {
          this.msgSuccess(data)
          this.showCheckDialog=false
          this.getList()
        })
      }
    },
    /** 驳回 **/
    reject () {
      this.$confirm(`确定驳回流程吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        backNodes({
          taskId: this.taskId,
          ...this.auditForm
        }).then(({data}) => {
          if (data.length > 0) {
            let backTaskDefKey = data[data.length - 1].taskDefKey
            this.back(backTaskDefKey)
          }
        })
      })
    },
    //驳回
    back(backTaskDefKey) {
      back({
        taskId: this.taskId,
        backTaskDefKey: backTaskDefKey,
        ...this.auditForm
      }).then(({data}) => {
        this.msgSuccess(data)
        this.showCheckDialog=false
        this.getList()
      })
    }
  }

};
</script>


<style lang='scss'>

</style>
