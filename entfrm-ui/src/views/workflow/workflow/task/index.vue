<template>
  <div class="app-container">
    <el-form v-show="showSearch"
             :model="queryParams"
             ref="queryForm"
             :inline="true"
             label-width="68px"
    >
      <el-form-item label="创建时间">
        <el-date-picker v-model="dateRange"
                        type="daterange"
                        size="small"
                        align="right"
                        value-format="yyyy-MM-dd hh:mm:ss"
                        unlink-panels
                        range-separator="至"
                        start-placeholder="开始日期"
                        end-placeholder="结束日期"
                        :picker-options="pickerOptions"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary"
                   icon="el-icon-search"
                   size="mini"
                   @click="handleQuery"
        >搜索</el-button>
        <el-button icon="el-icon-refresh-right"
                   size="mini"
                   @click="resetQuery"
        >重置</el-button>
      </el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8">
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
        <el-tooltip class="item"
                    effect="dark"
                    placement="top"
                    :content="showSearch ? '隐藏搜索' : '显示搜索'"
        >
          <el-button size="mini"
                     circle
                     icon="el-icon-search"
                     @click="showSearch=!showSearch"
          />
        </el-tooltip>
      </div>
    </el-row>
    <el-table v-loading="loading" :data="dataList">
      <el-table-column type="selection" header-align="center" width="50" align="center"/>
      <el-table-column prop="vars.title" show-overflow-tooltip label="实例标题"/>
      <el-table-column prop="processDefName" show-overflow-tooltip label="流程名称"/>
      <el-table-column prop="taskInfo.name" label="当前环节">
        <template slot-scope="scope">
          <el-tag>{{scope.row.taskInfo.name}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="vars.userName" label="流程发起人"/>
      <el-table-column prop="taskInfo.createTime" show-overflow-tooltip label="创建时间">
        <template slot-scope="scope">{{parseTime(scope.row.taskInfo.createTime)}}</template>
      </el-table-column>
      <el-table-column fixed="right"
                       header-align="center"
                       align="center"
                       width="180"
                       label="操作"
      >
        <template slot-scope="scope">
          <el-button type="text"
                     size="small"
                     @click="handleTodo(scope.row)"
          >办理</el-button>
          <el-button type="text"
                     size="small"
                     @click="handleTrace(scope.row)"
          >进度</el-button>
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
import { listTodoTask, getProcessInsFlowChart, getTaskDefinition } from "@/api/workflow/workflow/task"
export default {
  name: "Task",
  data() {
    return {
      loading: true,
      total: 0,
      dataList: [],
      queryParams: {
        current: 1,
        size: 10
      },
      dateRange: [],
      showSearch: true,
      visible: false,
      pickerOptions: {
        shortcuts: [{
          text: '最近一周',
          onClick (picker) {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 7)
            picker.$emit('pick', [start, end])
          }
        }, {
          text: '最近一个月',
          onClick (picker) {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 30)
            picker.$emit('pick', [start, end])
          }
        }, {
          text: '最近三个月',
          onClick (picker) {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 90)
            picker.$emit('pick', [start, end])
          }
        }]
      }
    }
  },
  created() {
    this.getList()
    window.router = this.$router
  },
  activated() {
    this.getList()
  },
  methods: {
    /** 查询代表任务列表 */
    getList() {
      this.loading = true
      listTodoTask(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.dataList = response.data
        this.total = response.total
        this.loading = false
      }).catch(() => { this.loading = false })
    },
    /** 处理搜索按钮操作 */
    handleQuery() {
      this.queryParams.current = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.dateRange = []
    },
    handleTrace (row) {
      const { processInsId } = row.taskInfo
      getProcessInsFlowChart(processInsId).then(response => {
        this.visible = true
        this.$nextTick(() => {
          this.$refs.flowableChart.setHighlightImportDiagram(response)
        })
      })
    },
    handleTodo(row) {
      const { taskInfo, vars } = row
      getTaskDefinition({
        taskId: taskInfo.id,
        taskName: taskInfo.name,
        taskDefKey: taskInfo.taskDefKey,
        processInsId: taskInfo.processInsId,
        processDefId: taskInfo.processDefId,
        processDefKey: taskInfo.processDefKey
      }).then(({ data }) => {
        this.$router.push({
          path: '/workflow/task/taskForm',
          query: {
            title: `审批【${taskInfo.name || ''}】`,
            formTitle: `${vars.title}`,
            formType: data.formType,
            formKey: data.formKey,
            formReadOnly: data.formReadOnly,
            processInsId: data.processInsId,
            processDefId: data.processDefId,
            processDefKey: data.processDefKey,
            taskId: data.taskId,
            taskDefKey: data.taskDefKey,
            businessId: data.businessId
          }
        })
      })
    }
  }
}
</script>
