<template>
  <div class="app-container">
    <el-form v-show="showSearch"
             :model="queryParams"
             ref="queryForm"
             :inline="true"
             label-width="68px"
    >
      <el-form-item label="完成时间">
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
      <el-table-column prop="name" show-overflow-tooltip label="任务">
        <template slot-scope="scope">
          {{scope.row.name}}
          <el-button v-if="scope.row.rollBack"
                     type="warning"
                     size="mini"
                     @click="callback(scope.row)"
          >回滚任务</el-button>
        </template>
      </el-table-column>
      <el-table-column prop="vars.title" show-overflow-tooltip label="实例标题"/>
      <el-table-column prop="processDefName" show-overflow-tooltip label="流程名称"/>
      <el-table-column prop="mesName" label="办理状态">
        <template slot-scope="scope">
          <el-tag>{{scope.row.mesName}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="vars.userName" label="流程发起人"/>
      <el-table-column prop="endTime" show-overflow-tooltip label="完成时间">
        <template slot-scope="scope">{{scope.row.endTime | formatDate}}</template>
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
                     @click="handleProcessView(scope.row)"
          >历史</el-button>
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
import { listHistoryList, getTaskDefinition, undoTask } from "@/api/workflow/workflow/task"
export default {
  name: "HistoryTask",
  data() {
    return {
      loading: false,
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
  },
  activated() {
    this.getList()
  },
  methods: {
    /** 查询已办任务列表 */
    getList() {
      this.loading = true
      listHistoryList(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
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
    /** 处理流程查看 */
    handleProcessView(row) {
      getTaskDefinition({
        taskDefKey: row.taskDefKey,
        processInsId: row.processInsId,
        processDefId: row.processDefId
      }).then(({ data }) => {
        this.$router.push({
          path: '/workflow/task/taskFormView',
          query: {
            taskId: row.id,
            taskDefKey: data.taskDefKey,
            title: `${row.processDefName}【${row.name}】`,
            formTitle: `${row.processDefName}`,
            formType: data.formType,
            formKey: data.formKey,
            processDefKey: data.processDefKey,
            processInsId: data.processInsId,
            processDefId: data.processDefId,
            businessId: data.businessId
          }
        })
      })
    },
    /** 处理回滚任务 */
    handleRollBackTask(row) {
      this.$confirm(`确定回滚该已办任务吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        const { taskInfo } = row
        undoTask({
          processInsId: row.processInsId,
          currentTaskId: taskInfo.id,
          currentTaskDefKey: taskInfo.taskDefKey,
          undoTaskId: row.id,
          undoTaskDefKey: row.taskDefKey
        }).then(({ data }) => {
          this.$message.success(data)
          this.getList()
        })
      }).catch(() => { this.loading = false })
    }
  }
}
</script>
