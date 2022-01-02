<template>
  <div class="app-container flex-main">
    <el-row :gutter="10">
      <!--表单流程分类查询-->
      <el-col :span="5" :xs="24">
        <div>
          <el-row :gutter="5">
            <el-col :span="20">
              <el-input v-model="name"
                        placeholder="输入表单分类名称"
                        clearable
                        size="small"
                        prefix-icon="el-icon-search"
                        style="margin-bottom: 20px"
              />
            </el-col>
            <el-col :span="4">
              <el-button type="primary"
                         circle
                         size="small"
                         icon="el-icon-plus"
                         @click="handleAddFormCategory"
              />
            </el-col>
          </el-row>
        </div>
        <div>
          <el-tree ref="formCategoryTree"
                   node-key="id"
                   :data="formCategoryTreeData"
                   :props="{
                             value: 'id',             // ID字段名
                             label: 'name',           // 显示名称
                             children: 'children'     // 子级字段名
                           }"
                   default-expand-all
                   highlight-current
                   :filter-node-method="formCategoryFilterNode"
                   :expand-on-click-node="false"
                   @node-click="handleFormCategoryNodeClick"
          >
            <span class="custom-tree-node" slot-scope="{ node, data }">
              <span>{{ node.label }}</span>
              <span>
                <el-button type="text" class="tree-item-button" icon="el-icon-plus" @click="handleAddChildFormCategory(data)"/>
                <el-button type="text" class="tree-item-button" icon="el-icon-edit-outline" @click="handleEditFormCategory(data)"/>
                <el-button type="text" class="tree-item-button" icon="el-icon-delete" @click="handleDelFormCategory(data)"/>
              </span>
            </span>
          </el-tree>
        </div>
      </el-col>
      <!--流程表单数据-->
      <el-col :span="19" :xs="24">
        <el-form v-show="showSearch"
                 ref="queryForm"
                 :model="queryParams"
                 :inline="true"
                 label-width="68px"
        >
          <el-form-item label="表单分类" prop="categoryId">
            <tree-select :value="queryParams.categoryId"
                         :list="formCategoryTreeData"
                         :props="{
                           value: 'id',             // ID字段名
                           label: 'name',           // 显示名称
                           children: 'children'     // 子级字段名
                         }"
                         :clearable="true"
                         :accordion="true"
                         @getValue="(value) => { queryParams.categoryId = value }"
            />
          </el-form-item>
          <el-form-item label="表单名称" prop="name">
            <el-input v-model="queryParams.name"
                      placeholder="请输入表单名称"
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
          <el-col :span="1.5">
            <el-button type="primary"
                       icon="el-icon-plus"
                       size="mini"
                       @click="handleAdd"
            >新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning"
                       icon="el-icon-edit-outline"
                       size="mini"
                       :disabled="single"
                       @click="handleEdit"
            >修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger"
                       icon="el-icon-delete"
                       size="mini"
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
        <el-table v-loading="loading" :data="formDefinitionList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" size="small" header-align="center" align="center" width="50"/>
          <el-table-column label="表单名称"  prop="name" show-overflow-tooltip/>
          <el-table-column label="分类"  prop="formCategory.name" show-overflow-tooltip/>
          <el-table-column label="版本号" prop="formDefinitionJson.version" show-overflow-tooltip/>
          <el-table-column label="状态" prop="formDefinitionJson.status" show-overflow-tooltip>
            <template slot-scope="scope">
              <el-tag v-if="scope.row.formDefinitionJson.status === '1'"
                      size="small"
                      type="success"
              >已发布</el-tag>
              <el-tag v-else
                      size="small"
                      type="danger"
              >未发布</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="是否主版本" prop="formDefinitionJson.isPrimary" show-overflow-tooltip>
            <template slot-scope="scope">
              <el-tag v-if="scope.row.formDefinitionJson.isPrimary === '1'"
                      size="small"
                      type="success"
              >主版本</el-tag>
              <el-tag v-else
                      size="small"
                      type="danger"
              >非主版本</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" width="240" class-name="small-padding fixed-width">
            <template slot-scope="scope">
              <el-button type="text"
                         icon="el-icon-view"
                         size="small"
                         @click="handleFlowFormDesign(scope.row)"
              >设计</el-button>
              <el-button type="text"
                         icon="el-icon-edit"
                         size="small"
                         @click="handleEdit(scope.row)"
              >修改</el-button>
              <el-button type="text"
                         icon="el-icon-edit"
                         size="small"
                         @click="handleVersionManage(scope.row)"
              >版本管理</el-button>
              <el-button type="text"
                         icon="el-icon-delete"
                         size="small"
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
      </el-col>
    </el-row>
    <workFlow-form-design ref="flowFormDesign" @refresh="getList"/>
    <form-category-form ref="formCategoryForm" @refresh="getFormCategoryTree"/>
    <!-- 添加或修改参数配置对话框 -->
    <el-dialog :title="title"
               :visible.sync="open"
               :close-on-click-modal="false"
    >
      <el-form ref="form"
               size="small"
               :model="form"
               :disabled="method=='view'"
               label-width="120px"
               @keyup.enter.native="handleSubmitForm"
               @submit.native.prevent
      >
        <el-row :gutter="15">
          <el-col :span="24">
            <el-form-item label="分类"
                          prop="categoryId"
                          :rules="[{ required: true, message: '分类不能为空', trigger: 'blur' }]"
            >
              <tree-select ref="category"
                           :value="form.categoryId"
                           :list="formCategoryTreeData"
                           :props="{
                             value: 'id',             // ID字段名
                             label: 'name',           // 显示名称
                             children: 'children'     // 子级字段名
                           }"
                          :clearable="true"
                          :accordion="true"
                          @getValue="(value) => { form.categoryId = value }"
              />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="表单名称"
                          prop="name"
                          :rules="[{ required: true, message: '表单名称不能为空', trigger: 'blur' }]"
            >
              <el-input v-model="form.name" placeholder="请填写表单名称"/>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button size="small"
                   @click="open = false"
        >关闭</el-button>
        <el-button v-if="method != 'view'"
                   size="small"
                   type="primary"
                   @click="handleSubmitForm"
        >确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { listFormDefinition, getFormDefinition, addFormDefinition, editFormDefinition, delFormDefinition } from '@/api/flowable/extension/formDefinition'
import { listFormCategory, delFormCategory } from '@/api/flowable/extension/formCategory'
import formCategoryForm from './helper/formCategoryForm'
import treeSelect from '@/components/TreeSelect'
import flowFormDesign from './helper/flowFormDesign'
import XEUtils from 'xe-utils'
export default {
  name: 'Form',
  components: { formCategoryForm, treeSelect, flowFormDesign },
  data () {
    return {
      // 遮罩层
      loading: true,
      // 表单分类搜索名称
      name: undefined,
      // 查询表单定义条件
      queryParams: {
        current: 1,
        size: 10,
        name: undefined,
        categoryId: undefined
      },
      // 表单定义数据
      formDefinitionList: [],
      // 表单定义分类树形数据
      formCategoryTreeData: [],
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 参数配置对话框标题
      title: '',
      // 参数配置对话框显示
      open: false,
      // 参数配置对话框表单
      form: {},
      // 参数配置对话框操作
      method: ''
    }
  },
  watch: {
    name (val) {
      this.$refs.formCategoryTree.filter(val)
    }
  },
  created() {
    this.getList()
    this.getFormCategoryTree()
  },
  methods: {
    /** 查询表单定义列表 */
    getList() {
      this.loading = true
      listFormDefinition(this.queryParams).then(response => {
          this.formDefinitionList = response.data
          this.total = response.total
          this.loading = false
      })
    },
    /** 表单重置,主要清除参数配置对话框缓存 */
    reset () {
      this.form = {
        id: undefined,
        categoryId: undefined,
        name: undefined,
        remarks: undefined
      }
    },
    /** 查询表单分类树 */
    getFormCategoryTree () {
      listFormCategory().then(response => {
        this.formCategoryTreeData = XEUtils.toArrayTree(response.data,{
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
    /** 处理多选框选中数据 */
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    /** 设置表单分类树形结构筛选节点逻辑 */
    formCategoryFilterNode (value, data) {
      if (!value) return true
      return data.name.indexOf(value) !== -1
    },
    /** 处理表单分类节点点击操作 */
    handleFormCategoryNodeClick (node) {
      this.queryParams.categoryId = node.id
      this.handleQuery()
    },
    /** 处理添加表单分类 */
    handleAddFormCategory () {
      this.$refs.formCategoryForm.setData('add')
    },
    /** 处理添加子项表单分类 */
    handleAddChildFormCategory (node) {
      this.$refs.formCategoryForm.setData('addChild', { parentId: node.id })
    },
    /** 处理修改表单分类 */
    handleEditFormCategory (node) {
      this.$refs.formCategoryForm.setData('edit', { id: node.id })
    },
    /** 处理删除表单分类 */
    handleDelFormCategory (node) {
      this.$confirm(`确定删除所选项吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        if(node.id){
          // 针对于行删除做处理需要查找子集删除
          const treeData = XEUtils.findTree(this.formCategoryTreeData, item => item.id === node.id, { children:'children' })
          const ids = XEUtils.toTreeArray([treeData.item], { children:'children', data:'id' })
          delFormCategory(ids).then(response => {
            this.loading = false
            this.msgSuccess("删除成功")
            this.getFormCategoryTree()
          })
        }
      }).catch(() => {})
    },
    /** 处理新增按钮操作 */
    handleAdd () {
      this.reset()
      this.getFormCategoryTree()
      this.title = '添加流程表单'
      this.method = 'add'
      this.open = true
    },
    /** 处理修改按钮操作 */
    handleEdit (row) {
      const id = row.id || this.ids
      this.getFormCategoryTree()
      getFormDefinition(id).then(response => {
        this.form = response.data
        this.title = '修改流程表单'
        this.method = 'edit'
        this.open = true
      })
    },
    /** 处理查看按钮操作 */
    handleView (row) {
      const id = row.id || this.ids
      this.getFormCategoryTree()
      getFormDefinition(id).then(response => {
        this.form = response.data
        this.title = "查看流程表单"
        this.method = 'view'
        this.open = true
      })
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
        delFormDefinition(ids).then(response => {
          this.loading = false
          this.msgSuccess("删除成功")
          this.getList()
        })
      }).catch(() => {})
    },
    /** 处理表单提交 */
    handleSubmitForm () {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.method == 'edit') {
            editFormDefinition(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("修改成功")
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addFormDefinition(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("新增成功")
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          }
        }
      })
    },
    /** 处理版本管理 */
    handleVersionManage (row) {
      this.$router.push({ name: 'FormDefinitionJson', params: { id: row.id } })
    },
    /** 处理工作流表单设计 */
    handleFlowFormDesign (row) {
      const formDefinitionJson = row.formDefinitionJson || {}
      this.$refs.flowFormDesign.setData({ id: formDefinitionJson.id, formDefinitionId: row.id })
    }
  }
}
</script>
