<template>
  <div class="app-container">
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="danger"
                   size="mini"
                   icon="el-icon-delete"
                   :disabled="multiple"
                   @click="handleDiscard"
        >作废</el-button>
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
      <el-table-column prop="vars.title" label="标题" show-overflow-tooltip/>
      <el-table-column prop="processDefName" label="流程名称" show-overflow-tooltip/>
      <el-table-column prop="status" label="当前节点">
        <template slot-scope="scope">
          <el-tag>{{scope.row.taskName}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="mesName" label="流程状态" width="150">
        <template slot-scope="scope">
          <el-tag :type="scope.row.mesLevel"
                  effect="dark"
                  size="small"
          >{{scope.row.mesName}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="vars.userName" label="流程发起人"/>
      <el-table-column align="center" width="180" label="操作">
        <template slot-scope="scope">
          <el-button type="text"
                     size="mini"
                     icon="el-icon-view"
                     @click="handleProcessView(scope.row)"
          >详情</el-button>
          <el-button type="text"
                     icon="el-icon-view"
                     size="mini"
                     @click="handleTrace(scope.row)"
          >进度</el-button>
          <el-button type="text"
                     size="mini"
                     icon="el-icon-delete"
                     @click="handleDiscard(scope.row)"
          >作废</el-button>
        </template>
      </el-table-column>
    </el-table>
    <pagination v-show="total>0"
                :total="total"
                :page.sync="queryParams.current"
                :limit.sync="queryParams.size"
                @pagination="getList"
    />
    <el-dialog title="查看进度"
               :close-on-click-modal="true"
               :visible.sync="visible"
               width="70%"
    >
      <flowable-chart ref="flowableChart" style="height:calc(100vh - 170px)"/>
    </el-dialog>
  </div>
</template>

<script>
import { getProcessInsFlowChart, getTaskDefinition } from '@/api/workflow/workflow/task'
import { listRunProcessDefinition, removeProcessInstance } from '@/api/workflow/workflow/process'

export default {
  name: 'HistoryProcess',
  data () {
    return {
      queryParams: {
        current: 1,
        size: 10
      },
      ids: [],
      multiple: true,
      dataList: [],
      visible: false,
      total: 0,
      loading: false
    }
  },
  activated () {
    this.getList()
  },
  created(){
    this.getList()
  },
  methods: {
    /** 获取查询列表 */
    getList () {
      this.loading = true
      listRunProcessDefinition(this.queryParams).then(response => {
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
      this.ids = selection.map(item => item.processInsId)
      this.multiple = !selection.length
    },
    /** 处理流程图跟踪 */
    handleTrace (row) {
      const { processInsId } = row
      getProcessInsFlowChart(processInsId).then(response => {
        this.visible = true
        this.$nextTick(() => {
          this.$refs.flowableChart.setHighlightImportDiagram(response)
        })
      })
    },
    /** 处理丢弃流程实例 */
    handleDiscard (row) {
      const ids = row.processInsId || this.ids.join(',')
      this.$prompt('作废原因', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(({ value }) => {
        this.loading = true
        return removeProcessInstance({
          processInsIds: ids,
          reason: value
        }).then(response => {
          this.msgSuccess("作废成功")
          this.getList()
        })
      }).catch(() => { this.loading = false })
    },
    /** 处理流程查看 */
    handleProcessView(row) {
      const { vars, activityId } = row
      getTaskDefinition({
        taskDefKey: activityId,
        processInsId: row.processInsId,
        processDefId: row.processDefId
      }).then(({ data }) => {
        this.$router.push({
          path: '/workflow/task/taskFormView',
          query: {
            title: vars.title,
            formTitle: vars.title,
            formType: data.formType,
            formKey: data.formKey,
            taskDefKey: data.taskDefKey,
            processInsId: data.processInsId,
            processDefId: data.processDefId,
            businessId: data.businessId
          }
        })
      })
    }
  }
}
</script>
