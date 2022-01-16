<template>
  <div class="app-container">
    <el-form v-show="showSearch"
             :model="queryParams"
             ref="queryForm"
             :inline="true"
             label-width="68px"
    >
      <el-form-item label="流程名称" prop="name">
        <el-input v-model="queryParams.name"
                  placeholder="请输入流程名称"
                  clearable
                  size="small"
                  style="width: 240px"
                  @keyup.enter.native="handleQuery"
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
      <el-col :span="1.5">
        <el-button type="primary"
                   size="mini"
                   icon="el-icon-plus"
                   @click="handleAdd"
        >新建</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger"
                   size="mini"
                   icon="el-icon-delete"
                   :disabled="multiple"
                   @click="handleDel"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success"
                   size="mini"
                   icon="el-icon-edit"
                   :disabled="single"
                   @click="setProcessCategory"
        >设置分类</el-button>
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
    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="50" align="center"/>
      <el-table-column prop="name" show-overflow-tooltip label="流程名称"/>
      <el-table-column prop="modelKey" show-overflow-tooltip label="流程KEY"/>
      <el-table-column prop="processDefinition.category" label="分类"/>
      <el-table-column prop="processDefinition.version" label="流程版本">
        <template slot-scope="scope">
          <el-tag>{{getProcessDefinition(scope.row).version || 'V:0'}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="processDefinition.suspend" label="流程状态">
        <template slot-scope="scope">
          <el-tag :type="getProcessDefinition(scope.row).suspend===false?'success'
            :(getProcessDefinition(scope.row).suspend===undefined?'primary':'danger')"
          >
            {{getProcessDefinition(scope.row).suspend===false?'已发布'
            :(getProcessDefinition(scope.row).suspend===undefined?'草稿':'已挂起')}}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="lastUpdated" show-overflow-tooltip label="更新时间">
        <template slot-scope="scope">
          {{parseTime(scope.row.lastUpdated)}}
        </template>
      </el-table-column>
      <el-table-column fixed="right"
                       header-align="center"
                       align="center"
                       width="250"
                       label="操作"
      >
        <template slot-scope="scope">
          <el-button type="text"
                     size="small"
                     @click="handleDesign(scope.row)"
          >设计</el-button>
          <el-button type="text"
                     size="small"
                     @click="handleDeploy(scope.row)"
          >发布</el-button>
          <el-dropdown size="small" style="margin-left: 10px">
            <el-button type="text" size="small">
              更多<i class="el-icon-arrow-down el-icon--right"></i>
            </el-button>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item v-if="getProcessDefinition(scope.row).suspend===true">
                <el-button type="text"
                           size="mini"
                           @click="handleProcessActive(scope.row)"
                >激活</el-button>
              </el-dropdown-item>
              <el-dropdown-item v-if="getProcessDefinition(scope.row).suspend===false">
                <el-button type="text"
                           size="mini"
                           @click="handleProcessSuspend(scope.row)"
                >挂起</el-button>
              </el-dropdown-item>
              <el-dropdown-item>
                <el-button type="text"
                           size="mini"
                           @click="handleExportXml(scope.row)"
                >导出</el-button>
              </el-dropdown-item>
              <el-dropdown-item>
                <el-button type="text"
                           size="mini"
                           @click="handleCopy(scope.row)"
                >复制</el-button>
              </el-dropdown-item>
              <el-dropdown-item>
                <el-button type="text"
                           size="mini"
                           @click="handleDel(scope.row)"
                >删除</el-button>
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </template>
      </el-table-column>
    </el-table>
    <pagination v-show="total>0"
                :total="total"
                :page.sync="queryParams.current"
                :limit.sync="queryParams.size"
                @pagination="getList"
    />
    <workflow-model-design ref="modelDesign" @refresh="getList"/>
    <process-category-form ref="categoryForm" @refresh="getList"/>
  </div>
</template>

<script>
import { listModel, delModel, deployModel, copyModel } from "@/api/workflow/workflow/model"
import { setProcessInstanceStatus } from '@/api/workflow/workflow/process'
import workflowModelDesign from './helper/workflowModelDesign'
import processCategoryForm from './helper/processCategoryForm'
export default {
  name: "Model",
  components: { workflowModelDesign, processCategoryForm },
  data() {
    return {
      loading: true,
      selections: [],
      ids: [],
      single: true,
      multiple: true,
      total: 0,
      dataList: [],
      queryParams: {
        current: 1,
        size: 10,
        name: undefined
      },
      processDefinition: {},
      showSearch: true
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 流程定义校验 */
    getProcessDefinition (row = {}) {
      return row.processDefinition || {}
    },
    /** 查询模型列表 */
    getList() {
      this.loading = true
      listModel(this.queryParams).then(response => {
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
      this.resetForm("queryForm")
    },
    /** 处理多选框选中数据 */
    handleSelectionChange(selection) {
      this.selections = selection
      this.ids = selection.map(item => item.id)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    /** 处理模型新增 */
    handleAdd() {
      this.$refs.modelDesign.init()
    },
    /** 设置流程分类 */
    setProcessCategory() {
      const row = this.selections[0]
      if (row.processDefinition) {
        this.$refs.categoryForm.init(row.modelKey)
      } else {
        this.$message.error('未发布的流程不能设置分类,请先发布流程')
      }
    },
    /** 处理模型删除 */
    handleDel(row) {
      const { id } = row
      let ids = id || this.ids
      this.$confirm(`确定删除该流程吗?删除流程会级联删除已经存在的实例与历史数据，且不可恢复，请谨慎操作!`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        return delModel(ids).then(()=>{
          this.msgSuccess("删除成功")
          this.getList()
        })
      }).catch(() => { this.loading = false })
    },
    /** 处理模型设计 */
    handleDesign(row) {
      const { id } = row
      this.$refs.modelDesign.init(id)
    },
    /** 处理模型部署 */
    handleDeploy(row) {
      const { id } = row
      this.$confirm(`确认要发布流程吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        const category = this.getProcessDefinition(row).category
        return deployModel({ id, category: category || '未分类'}).then(() => {
          this.msgSuccess("发布成功")
          this.getList()
        })
      }).catch(() => { this.loading = false })
    },
    /** 处理流程激活 */
    handleProcessActive(row) {
      this.$confirm(`确定要激活该流程吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        const { modelKey } = row
        return setProcessInstanceStatus({ processDefKeys: modelKey, status: 'active'}).then(() => {
          this.msgSuccess("激活成功")
          this.getList()
        })
      }).catch(() => { this.loading = false })
    },
    /** 处理流程挂起 */
    handleProcessSuspend(row) {
      this.$confirm(`确认要挂起该流程吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        const { modelKey } = row
        return setProcessInstanceStatus({ processDefKeys: modelKey, status: 'suspend'}).then(() => {
          this.msgSuccess("挂起成功")
          this.getList()
        })
      }).catch(() => { this.loading = false })
    },
    /** 处理模型导出 */
    handleExportXml(row) {
      const { id } = row
      window.location.href = `${process.env.VUE_APP_BASE_API}/workflow/model/bpmnXmlDownload/${id}`
    },
    /** 处理模型复制 */
    handleCopy(row) {
      const { id } = row
      this.$confirm(`确定复制该流程吗？`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        return copyModel(id).then(() => {
          this.msgSuccess("复制成功")
          this.getList()
        })
      }).catch(() => { this.loading = false })
    }
  }
}
</script>
