<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!--表单流程分类查询-->
      <el-col :span="4" :xs="24">
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
              <el-button type="primary" @click="addTreeNode" size="small" icon="el-icon-plus" circle/>
            </el-col>
          </el-row>
        </div>
        <div>
          <el-tree class="filter-tree"
                   :data="formCategoryTreeData"
                   :props="{
                             value: 'id',             // ID字段名
                             label: 'name',           // 显示名称
                             children: 'children'     // 子级字段名
                           }"
                   default-expand-all
                   :filter-node-method="filterNode"
                   :expand-on-click-node="false"
                   highlight-current
                   node-key="id"
                   @node-click="handleNodeClick"
                   ref="formCategoryTree">
                    <span class="custom-tree-node" slot-scope="{ node, data}">
                      <span>{{ node.label }}</span>
                      <span>
                        <el-button type="text" class="tree-item-button" icon="el-icon-plus" @click="addChildTreeNode(data)"/>
                        <el-button type="text" class="tree-item-button" icon="el-icon-edit-outline" @click="editTreeNode(data)"/>
                        <el-button type="text" class="tree-item-button" icon="el-icon-delete" @click="delTreeNode(data)"/>
                      </span>
                    </span>
          </el-tree>
        </div>
      </el-col>
      <!--流程表单数据-->
      <el-col :span="20" :xs="24">
        <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
          <el-form-item label="表单名称" prop="formDefinition.name">
            <el-input
              v-model="queryParams.formDefinition.name"
              placeholder="请输入表单名称"
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
          <el-col :span="1.5">
            <el-button
              type="primary"
              icon="el-icon-plus"
              size="mini"
              @click="handleAdd"
              v-hasPerm="['user_add']"
            >新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="success"
              icon="el-icon-edit"
              size="mini"
              :disabled="single"
              @click="handleEdit"
              v-hasPerm="['user_edit']"
            >修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="danger"
              icon="el-icon-delete"
              size="mini"
              :disabled="multiple"
              @click="handleDel"
              v-hasPerm="['user_del']"
            >删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="info"
              icon="el-icon-upload2"
              size="mini"
              @click="handleImport"
              v-hasPerm="['user_import']"
            >导入</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="warning"
              icon="el-icon-download"
              size="mini"
              @click="handleExport"
              v-hasPerm="['user_export']"
            >导出</el-button>
          </el-col>

          <div class="top-right-btn">
            <el-tooltip class="item" effect="dark" content="刷新" placement="top">
              <el-button size="mini" circle icon="el-icon-refresh" @click="handleQuery" />
            </el-tooltip>
            <el-tooltip class="item" effect="dark" :content="showSearch ? '隐藏搜索' : '显示搜索'" placement="top">
              <el-button size="mini" circle icon="el-icon-search" @click="showSearch=!showSearch" />
            </el-tooltip>
          </div>
        </el-row>

        <el-table v-loading="loading" :data="formDefinitionList" border @selection-change="handleSelectionChange">
          <el-table-column type="selection" size="small" header-align="center" align="center" width="50"/>
          <el-table-column label="表单名称"  prop="name" show-overflow-tooltip/>
          <el-table-column label="分类"  prop="formCategory.name" show-overflow-tooltip/>
          <el-table-column label="版本号" prop="formDefinitionJson.version" show-overflow-tooltip/>
          <el-table-column label="状态" prop="formDefinitionJson.status" show-overflow-tooltip>
            <template slot-scope="scope">
              <el-tag v-if="scope.row.formDefinitionJson && scope.row.formDefinitionJson.status === '1'" size="small" type="success">已发布</el-tag>
              <el-tag v-else size="small" type="danger">未发布</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="是否主版本" prop="formDefinitionJson.isPrimary" show-overflow-tooltip>
            <template slot-scope="scope">
              <el-tag v-if="scope.row.formDefinitionJson && scope.row.formDefinitionJson.isPrimary === '1'" size="small" type="success">主版本</el-tag>
              <el-tag v-else size="small" type="danger">非主版本</el-tag>
            </template>
          </el-table-column>
          <el-table-column
            label="操作"
            align="center"
            width="180"
            class-name="small-padding fixed-width"
          >
            <template slot-scope="scope">
              <el-button
                size="mini"
                type="text"
                icon="el-icon-edit"
                @click="handleEdit(scope.row)"
                v-hasPerm="['user_edit']"
              >修改</el-button>
              <el-button
                v-if="scope.row.id !== 1"
                size="mini"
                type="text"
                icon="el-icon-delete"
                @click="handleDel(scope.row)"
                v-hasPerm="['user_del']"
              >删除</el-button>
              <el-button
                size="mini"
                type="text"
                icon="el-icon-key"
                @click="handleResetPwd(scope.row)"
                v-hasPerm="['user_reset']"
              >重置</el-button>
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
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { listFormDefinition } from '@/api/flowable/extension/formDefinition'
export default {
  data () {
    return {
      // 遮罩层
      loading: true,
      // 表单分类名称
      name: undefined,
      // 查询表单定义条件
      queryParams: {
        current: 1,
        size: 10,
        formDefinition: {
          name : undefined
        }
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
      multiple: true
    }
  },
  watch: {
    name(val) {
      this.$refs.tree.filter(val);
    }
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询表单定义列表 */
    getList() {
      this.loading = true;
      listFormDefinition(this.queryParams).then(response => {
          this.formDefinitionList = response.data;
          this.total = response.total;
          this.loading = false;
      });
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
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    // 树形结构筛选节点
    filterNode (value, data) {
      if (!value) return true
      return data.name.indexOf(value) !== -1
    },
    // 处理节点点击操作
    handleNodeClick (data) {
      // 本地处理表单定义数据过滤
      const formDefinitionList = this.formDefinitionList.filter(item => item.formCategory.id === data.id)
      this.formDefinitionList = formDefinitionList
      this.total = formDefinitionList.length
    },
  }
}
</script>
