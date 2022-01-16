<template>
  <div class="app-container">
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="danger"
                   size="mini"
                   icon="el-icon-delete"
                   :disabled="multiple"
                   @click="handleDel"
        >删除</el-button>
      </el-col>
      <div class="top-right-btn">
        <el-tooltip class="item"
                    effect="dark"
                    content="刷新"
                    placement="top"
        >
          <el-button size="mini"
                     circle
                     icon="el-icon-refresh"
                     @click="handleQuery"
          />
        </el-tooltip>
      </div>
    </el-row>
    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" align="center" width="50"/>
      <el-table-column prop="processInsName" label="实例标题" show-overflow-tooltip/>
      <el-table-column prop="createTime" label="抄送日期">
        <template slot-scope="scope">{{ scope.row.createTime | formatDate }}</template>
      </el-table-column>
      <el-table-column prop="createBy" label="抄送发起人"/>
      <el-table-column align="center" width="200" label="操作">
        <template slot-scope="scope">
          <el-button type="text"
                     icon="el-icon-view"
                     size="mini"
                     @click="handleViewAudit(scope.row)"
          >查阅审批</el-button>
          <el-button type="text"
                     size="mini"
                     icon="el-icon-delete"
                     @click="handleDel(scope.row)"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <pagination v-show="total>0"
                :total="total"
                :page.sync="queryParams.current"
                :limit.sync="queryParams.size"
                @pagination="getList"
    />
  </div>
</template>

<script>
import { listWorkflowCopy, delWorkflowCopy } from '@/api/workflow/extension/workflowCopy'
import { getTaskDefinition } from '@/api/workflow/workflow/task'

export default {
  name: 'WorkflowCopy',
  data () {
    return {
      queryParams: {
        current: 1,
        size: 10
      },
      ids: [],
      multiple: true,
      dataList: [],
      total: 0,
      loading: false
    }
  },
  created(){
    this.getList()
  },
  methods: {
    /** 获取查询列表 */
    getList () {
      this.loading = true
      listWorkflowCopy(this.queryParams).then(response => {
        this.dataList = response.data
        this.total = response.total
        this.loading = false
      }).catch(() => { this.loading = false })
    },
    /** 处理搜索按钮操作 */
    handleQuery () {
      this.queryParams.current = 1
      this.getList()
    },
    /** 处理多选框选中数据 */
    handleSelectionChange (selection) {
      this.ids = selection.map(item => item.id)
      this.multiple = !selection.length
    },
    /** 处理删除按钮操作 */
    handleDel (row) {
      const ids = row.id || this.ids
      this.$confirm('是否确认删除所选项编号为"' + ids + '"的数据项?', "警告", {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        delWorkflowCopy(ids).then(response => {
          this.msgSuccess("删除成功")
          this.getList()
        })
      }).catch(() => { this.loading = false })
    },
    /** 处理查阅审批 */
    handleViewAudit (row) {
      getTaskDefinition({
        processInsId: row.processInsId,
        processDefId: row.processDefId
      }).then(({ data }) => {
        this.$router.push({
          path: '/workflow/task/taskFormView',
          query: {
            title: row.processInsName,
            formTitle: row.processInsName,
            formType: data.formType,
            formKey: data.formKey,
            processDefKey: data.processDefKey,
            taskDefKey: data.taskDefKey,
            processInsId: data.processInsId,
            processDefId: data.processDefId,
            taskId: data.taskId,
            businessId: data.businessId
          }
        })
      })
    }
  }
}
</script>
