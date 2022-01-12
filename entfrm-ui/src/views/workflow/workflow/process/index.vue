<template>
  <div class="app-container flex-main">
    <el-row :gutter="10">
      <!--流程分类查询-->
      <el-col :span="4" :xs="24">
        <div>
          <el-row :gutter="5">
              <el-input v-model="name"
                        placeholder="输入流程分类名称"
                        clearable
                        size="small"
                        prefix-icon="el-icon-search"
                        style="margin-bottom: 20px"
              />
          </el-row>
        </div>
        <div>
          <el-tree ref="categoryTree"
                   node-key="id"
                   :data="categoryTreeData"
                   :props="{
                             value: 'id',             // ID字段名
                             label: 'name',           // 显示名称
                             children: 'children'     // 子级字段名
                           }"
                   default-expand-all
                   highlight-current
                   :filter-node-method="categoryFilterNode"
                   :expand-on-click-node="false"
                   @node-click="handleCategoryNodeClick"
          />
        </div>
      </el-col>
      <!--流程定义数据-->
      <el-col :span="20" :xs="24">
        <el-form v-show="showSearch"
                 ref="queryForm"
                 :model="queryParams"
                 :inline="true"
                 label-width="68px"
        >
          <el-form-item label="流程分类" prop="category">
            <tree-select :value="queryParams.categoryId"
                         :list="categoryTreeData"
                         :props="{
                           value: 'id',             // ID字段名
                           label: 'name',           // 显示名称
                           children: 'children'     // 子级字段名
                         }"
                         :clearable="true"
                         :accordion="true"
                         @getValue="(value, label) => { queryParams.categoryId = value, queryParams.category = label }"
            />
          </el-form-item>
          <el-form-item label="流程名称" prop="name">
            <el-input v-model="queryParams.name"
                      placeholder="请输入流程名称"
                      clearable
                      size="small"
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
          <div class="top-right-btn">
            <el-tooltip class="item"
                        effect="dark"
                        content="刷新"
                        placement="top"
            >
              <el-button size="mini"
                         circle icon="el-icon-refresh"
                         @click="handleQuery"
              />
            </el-tooltip>
            <el-tooltip class="item"
                        effect="dark"
                        :content="showSearch ? '隐藏搜索' : '显示搜索'"
                        placement="top"
            >
              <el-button size="mini"
                         circle
                         icon="el-icon-search"
                         @click="showSearch=!showSearch"
              />
            </el-tooltip>
          </div>
        </el-row>
        <el-table v-loading="loading" :data="processDefinitionList" :default-sort = "{prop:'deploymentTime',order:'descending'}">
          <el-table-column label="流程名称" prop="name" show-overflow-tooltip/>
          <el-table-column label="流程KEY" prop="key" show-overflow-tooltip/>
          <el-table-column label="流程分类" prop="category" align="center" show-overflow-tooltip/>
          <el-table-column label="流程版本" prop="version" align="center" show-overflow-tooltip>
            <template slot-scope="scope">
              <el-tag>{{scope.row.version}}</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="上次发布时间" prop="deploymentTime" show-overflow-tooltip>
            <template slot-scope="scope">
              {{parseTime(scope.row.deploymentTime)}}
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" width="120">
            <template slot-scope="scope">
              <el-button type="text"
                         icon="el-icon-view"
                         size="small"
                         @click="handleProcessDefinitionStart(scope.row)"
              >启动流程</el-button>
            </template>
          </el-table-column>
        </el-table>
        <pagination v-show="total>0"
                    :total="total"
                    :page.sync="queryParams.current"
                    :limit.sync="queryParams.size"
                    @pagination="getList"
        />
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { listProcessDefinition } from '@/api/workflow/workflow/process'
import { listCategory } from '@/api/workflow/extension/category'
import { getTaskDefinition } from '@/api/workflow/workflow/task'
import treeSelect from '@/components/TreeSelect'
import XEUtils from 'xe-utils'
import taskForm from '../task/taskForm'
export default {
  name: 'Form',
  components: { treeSelect, taskForm },
  data () {
    return {
      // 遮罩层
      loading: true,
      // 流程分类搜索名称
      name: undefined,
      // 查询流程定义条件
      queryParams: {
        current: 1,
        size: 10,
        name: undefined,
        category: undefined,
        categoryId: undefined
      },
      // 流程定义数据
      processDefinitionList: [],
      // 流程定义分类树形数据
      categoryTreeData: [],
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0
    }
  },
  watch: {
    name (val) {
      this.$refs.categoryTree.filter(val)
    }
  },
  created() {
    this.getList()
    this.getCategoryTree()
  },
  methods: {
    /** 查询流程定义列表 */
    getList() {
      this.loading = true
      listProcessDefinition(this.queryParams).then(response => {
          this.processDefinitionList = response.data
          this.total = response.total
          this.loading = false
      }).catch(() => { this.loading = false })
    },
    /** 查询流程分类树 */
    getCategoryTree () {
      listCategory().then(response => {
        this.categoryTreeData = XEUtils.toArrayTree(response.data,{
          parentKey: 'parentId', key: 'id', children: 'children', sortKey: 'sort'
        })
      })
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.current = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
    },
    /** 设置流程分类树形结构筛选节点逻辑 */
    categoryFilterNode (value, data) {
      if (!value) return true
      return data.name.indexOf(value) !== -1
    },
    /** 处理流程分类节点点击操作 */
    handleCategoryNodeClick (node) {
      this.queryParams.category = node.name
      this.queryParams.categoryId = node.id
      this.handleQuery()
    },
    /** 处理流程定义启动 */
    handleProcessDefinitionStart (row) {
      const tabTitle = `启动流程【${row.name}】`
      const formTitle = `${this.$store.getters.name} 在 ${this.parseTime(new Date(), '{y}-{m}-{d} {h}:{i}')} 发起了 [${row.name}]`
      getTaskDefinition( { processDefId: row.id }).then(({data}) => {
        this.$router.push({
          path: '/workflow/task/taskForm',
          query: {
            processDefId: row.id,
            processDefKey: row.key,
            status: 'start',
            title: tabTitle,
            formTitle: formTitle,
            formType: data.formType,
            formKey: data.formKey
          }
        })
      })
    }
  }
}
</script>
