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
      <el-table-column prop="vars.title" show-overflow-tooltip min-width="180px" label="流程标题"/>
      <el-table-column prop="processDefName" show-overflow-tooltip label="流程名称"/>
      <el-table-column prop="taskName" show-overflow-tooltip label="当前节点"/>
      <el-table-column prop="mesName" label="流程状态">
        <template slot-scope="scope">
          <el-tag :type="scope.row.mesLevel" effect="dark" size="small">{{scope.row.mesName}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="startTime" show-overflow-tooltip label="发起时间 / 结束时间">
        <template slot-scope="scope">
          <p style="margin:0;padding:0;">{{scope.row.startTime | formatDate}}</p>
          <p style="margin:0;padding:0;color:#999!important;">{{scope.row.endTime | formatDate}}</p>
        </template>
      </el-table-column>
      <el-table-column fixed="right"
                       header-align="center"
                       align="center"
                       width="150"
                       label="操作"
      >
        <template slot-scope="scope">
          <el-button type="text"
                     size="small"
                     @click="handleProcessView(scope.row)"
          >历史</el-button>
          <el-button v-if="scope.row.mesCode == '_workflow_process_waiting'"
                     type="text"
                     size="small"
                     @click="handleRevoke(scope.row)"
          >撤销</el-button>
          <el-button v-if="scope.row.mesCode == '_workflow_process_revoke' || scope.row.mesCode == '_workflow_process_reject'"
                     type="text"
                     color="red"
                     size="small"
                     @click="handleRestartSubmit(scope.row)"
          >编辑</el-button>
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
import { getTaskDefinition } from "@/api/workflow/workflow/task"
import { selfProcessInstanceList, undoProcessInstance } from '@/api/workflow/workflow/process'

export default {
  name: "ApplyProcess",
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
  },
  activated() {
    this.getList()
  },
  methods: {
    /** 查询列表 */
    getList() {
      this.loading = true
      selfProcessInstanceList(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
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
      const { vars } = row
      getTaskDefinition({
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
            processDefKey: data.processDefKey,
            processInsId: data.processInsId,
            processDefId: data.processDefId,
            businessId: data.businessId
          }
        })
      })
    },
    /** 处理撤销申请 */
    handleRevoke(row) {
      this.$confirm(`确定要撤销该流程吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        undoProcessInstance(row.processInsId).then(({ data }) => {
            this.$message.success(data)
            this.getList()
        })
      }).catch(() => { this.loading = false })
    },
    /** 处理重新提交 */
    handleRestartSubmit (row) {
      const { vars, processInsId, processDefId, processDefKey } = row
      getTaskDefinition( { processDefId: processDefId }).then(({ data }) => {
        this.$router.push({
          path: '/workflow/task/taskForm',
          query: {
            status: 'start',
            title: vars.title,
            formTitle: vars.title,
            formType: data.formType,
            formKey: data.formKey,
            processDefId: processDefId,
            processDefKey: processDefKey,
            processInsId: processInsId
          }
        })
      })
    }
  }
}
</script>
