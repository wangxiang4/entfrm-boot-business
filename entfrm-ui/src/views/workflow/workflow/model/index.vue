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
        <el-button type="warning"
                   size="mini"
                   icon="el-icon-edit-outline"
                   :disabled="single"
                   @click="handleEdit"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger"
                   size="mini"
                   icon="el-icon-delete"
                   @click="handleDel"
                   :disabled="multiple"
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
      <el-table-column prop="key" show-overflow-tooltip label="流程KEY"/>
      <el-table-column prop="processDefinition.category" label="分类"/>
      <el-table-column prop="version" label="流程版本">
        <template slot-scope="scope">
          <el-tag>{{scope.row.processDefinition.version || '0'}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="version" label="流程状态">
        <template slot-scope="scope">
          <el-tag :type="scope.row.processDefinition.suspend===false?'success'
            :(scope.row.processDefinition.suspend===undefined?'primary':'danger')"
          >
            {{scope.row.processDefinition.suspend===false?'已发布' : (scope.row.processDefinition.suspend===undefined?'草稿':'已挂起')}}
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
              <el-dropdown-item v-if="scope.row.processDefinition.suspend===true">
                <el-button type="text"
                           size="small"
                           @click="handleProcessActive(scope.row)"
                >激活</el-button>
              </el-dropdown-item>
              <el-dropdown-item v-if="scope.row.processDefinition.suspend===false">
                <el-button type="text"
                           size="small"
                           @click="handleProcessSuspend(scope.row)"
                >挂起</el-button>
              </el-dropdown-item>
              <el-dropdown-item>
                <el-button type="text"
                           size="small"
                           @click="handleExportXml(scope.row)"
                >导出</el-button>
              </el-dropdown-item>
              <el-dropdown-item>
                <el-button type="text"
                           size="small"
                           @click="handleCopy(scope.row)"
                >复制</el-button>
              </el-dropdown-item>
              <el-dropdown-item>
                <el-button type="text"
                           size="small"
                           @click="handleDel(scope.row.id)"
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
  </div>
</template>

<script>
import { listModel, getModel, delModel, addModel, deployModel } from "@/api/workflow/workflow/model"
import workflowModelDesign from './helper/workflowModelDesign'
export default {
  name: "Model",
  components: { workflowModelDesign },
  data() {
    return {
      loading: true,
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
      showSearch: true
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询模型列表 */
    getList() {
      this.loading = true
      listModel(this.queryParams).then(response => {
          this.dataList = response.data
          this.total = response.total
          this.loading = false
      })
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
      this.ids = selection.map(item => item.id)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    /** 处理模型新增 */
    handleAdd() {
      this.$refs.modelDesign.init()
    },
    /** 处理模型编辑 */
    handleEdit(row) {
    },
    /** 处理模型删除 */
    handleDel(row) {
    },
    /** 处理模型设计 */
    handleDesign(row) {
    },
    /** 处理模型部署 */
    handleDeploy(row) {

    },
    /** 处理流程激活 */
    handleProcessActive(row) {

    },
    /** 处理流程挂起 */
    handleProcessSuspend(row) {

    },
    /** 处理模型导出 */
    handleExportXml(row) {

    },
    /** 处理模型复制 */
    handleCopy(row) {

    }
  }
}
</script>
