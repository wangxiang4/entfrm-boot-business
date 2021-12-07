<template>
  <div class="app-container">
    <el-form  :model="queryParams"
              :inline="true"
              v-show="showSearch"
              ref="queryForm"
              size="small"
              @keyup.enter.native="handleQuery()"
              @submit.native.prevent>
      <el-form-item prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="名称"
          clearable/>
      </el-form-item>
      <el-form-item>
        <el-button
          type="primary"
          icon="el-icon-search"
          size="mini"
          @click="handleQuery">搜索
        </el-button>
        <el-button
          icon="el-icon-refresh-right"
          size="mini"
          @click="resetQuery">重置
        </el-button>
      </el-form-item>
    </el-form>
    <vxe-toolbar :refresh="{query: getList}" export print custom>
      <template #buttons>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-plus"
              @click="add">新建
            </el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="danger"
              size="mini"
              icon="el-icon-delete"
              @click="del"
              :disabled="$refs.xTree && $refs.xTree.getCheckboxRecords().length === 0">删除
            </el-button>
          </el-col>
        </el-row>
      </template>
      <template #tools>
        <el-button
          class="mr10"
          size="small"
          circle
          icon="el-icon-search"
          :title="showSearch ? '隐藏搜索' : '显示搜索'"
          @click="showSearch=!showSearch"/>
      </template>
    </vxe-toolbar>
    <vxe-table
      resizable
      ref="xTree"
      border="inner"
      row-id="id"
      show-header-overflow
      show-overflow
      highlight-hover-row
      :print-config="{}"
      :export-config="{}"
      :tree-config="{expandAll: true}"
      :loading="loading"
      :checkbox-config="{labelField: ''}"
      :data="dataList">
      <vxe-table-column type="checkbox" width="40px"/>
      <vxe-table-column title="名称" field="name" align="left" tree-node/>
      <vxe-table-column title="备注信息" field="remarks" align="center"/>
      <vxe-table-column title="操作" width="300px" fixed="right" align="center">
        <template  slot-scope="scope">
          <el-button
            type="text"
            icon="el-icon-view"
            size="mini"
            @click="view(scope.row.id)">查看
          </el-button>
          <el-button
            type="text"
            icon="el-icon-edit"
            size="mini"
            @click="edit(scope.row.id)">修改
          </el-button>
          <el-button
            type="text"
            size="mini"
            icon="el-icon-delete"
            @click="del(scope.row.id)">删除
          </el-button>
          <el-button
            type="text"
            size="mini"
            icon="el-icon-circle-plus-outline"
            @click="addChild(scope.row.id)">添加下级
          </el-button>
        </template>
      </vxe-table-column>
    </vxe-table>
    <!-- 弹窗, 新增 / 修改 -->
    <act-category-form  ref="actCategoryForm" @refreshDataList="getList"/>
  </div>
</template>


<script>
import { listActCategory, delActCategory } from "@/api/flowable/actCategory"
import actCategoryForm from './actCategoryForm'
import XEUtils from 'xe-utils'
export default {
  data () {
    return {
      // 是否显示搜索
      showSearch: true,
      // 查询条件
      queryParams: {
        name:undefined
      },
      // vxe-table数据集合
      dataList: [],
      // 是否显示遮罩
      loading: false
    }
  },
  components: {
    actCategoryForm
  },
  created() {
    this.getList();
  },
  methods: {
    // 搜索按钮操作
    handleQuery() {
      this.getList();
    },
    // 重置按钮操作
    resetQuery() {
      this.resetForm("queryForm");
    },
    // 获取数据列表
    getList() {
      this.loading = true;
      listActCategory().then(response => {
        this.dataList = XEUtils.toArrayTree(response.data,{
          parentKey: 'parentId', key: 'id', children: 'children'
        });
        this.handleSearch();
        this.loading = false;
      });
    },
    // 搜索树形结构数据
    handleSearch() {
      let filterName = XEUtils.toValueString(this.queryParams.name).trim()
      if (filterName) {
        let options = { children: 'children' }
        let searchProps = ['name']
        this.dataList = XEUtils.searchTree(this.dataList, item => searchProps.some(key => XEUtils.toValueString(item[key]).indexOf(filterName) > -1),options)
      }
      this.$nextTick(() => {
        this.$refs.xTree.setAllTreeExpand(true)
      })
    },
    // 新增下级
    addChild(id) {
      this.$refs.actCategoryForm.init('addChild', {id: undefined, parentId: id})
    },
    // 新增
    add() {
      this.$refs.actCategoryForm.init('add', {id: undefined, parentId: 0})
    },
    // 修改
    edit(row) {
      const id = row.id
      this.$refs.actCategoryForm.init('edit', {id: id, parentId: 0})
    },
    // 查看
    view(id) {
      this.$refs.actCategoryForm.init('view', {id: id, parentId: 0})
    },
    // 删除
    del(row) {
      let id = row.id
      let ids = id || this.$refs.xTree.getCheckboxRecords().map(item =>item.id)
      this.$confirm(`确定删除所选项吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        if(id){
          // 针对于行删除做处理需要查找子集删除
          let treeData = XEUtils.findTree(this.dataList, item => item.id === id, {children:'children'})
          ids = XEUtils.toTreeArray([treeData.item],{children:'children',data:'id'})}
        delActCategory(ids).then(()=>{
          this.loading = false
          this.msgSuccess("删除成功");
          this.getList();
        });
      })
    }
  }
}
</script>

<style scoped>

</style>
