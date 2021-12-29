<template>
  <div class="app-container">
    <el-form :model="queryParams"
             :inline="true"
             v-show="showSearch"
             ref="queryForm"
             size="small"
             @keyup.enter.native="getList"
             @submit.native.prevent
    >
      <el-form-item prop="name">
        <el-input v-model="queryParams.name"
                  placeholder="名称"
                  clearable
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary"
                   icon="el-icon-search"
                   size="mini"
                   @click="getList"
        >搜索</el-button>
        <el-button icon="el-icon-refresh-right"
                   size="mini"
                   @click="handleResetQuery"
        >重置</el-button>
      </el-form-item>
    </el-form>
    <vxe-toolbar :refresh="{ query: getList }" export print custom>
      <template #buttons>
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
        </el-row>
      </template>
      <template #tools>
        <el-button class="mr10"
                   size="small"
                   circle
                   icon="el-icon-search"
                   :title="showSearch ? '隐藏搜索' : '显示搜索'"
                   @click="showSearch=!showSearch"
        />
      </template>
    </vxe-toolbar>
    <vxe-table resizable
               ref="xTree"
               border="inner"
               row-id="id"
               show-header-overflow
               show-overflow
               highlight-hover-row
               :print-config="{}"
               :export-config="{}"
               :tree-config="{ expandAll: true }"
               :loading="loading"
               :checkbox-config="{ labelField: '' }"
               :data="dataList"
               @checkbox-change="handleSelectionChange"
               @checkbox-all="handleSelectionChange"
    >
      <vxe-table-column type="checkbox" width="40px"/>
      <vxe-table-column title="名称" field="name" align="left" tree-node/>
      <vxe-table-column title="备注信息" field="remarks" align="center"/>
      <vxe-table-column title="操作" width="300px" fixed="right" align="center">
        <template  slot-scope="scope">
          <el-button type="text"
                     icon="el-icon-view"
                     size="mini"
                     @click="handleView(scope.row)"
          >查看</el-button>
          <el-button type="text"
                     icon="el-icon-edit"
                     size="mini"
                     @click="handleEdit(scope.row)"
          >修改</el-button>
          <el-button type="text"
                     size="mini"
                     icon="el-icon-delete"
                     @click="handleDel(scope.row)"
          >删除</el-button>
          <el-button type="text"
                     size="mini"
                     icon="el-icon-circle-plus-outline"
                     @click="handleAddChild(scope.row)"
          >添加下级</el-button>
        </template>
      </vxe-table-column>
    </vxe-table>
    <!-- 添加或修改参数配置对话框 -->
    <el-dialog :title="title"
               :visible.sync="open"
               :close-on-click-modal="false"
    >
      <el-form size="small"
               :model="form"
               ref="form"
               label-width="120px"
               :disabled="method=='view'"
               @keyup.enter.native="handleSubmitForm"
               @submit.native.prevent
      >
        <el-row :gutter="15">
          <el-col :span="24">
            <el-form-item label="上级流程分类"
                          prop="parentId"
                          :rules="[]"
            >
              <tree-select ref="parent"
                           :value="form.parentId"
                           :list="treeSelectList"
                           :props="treeSelectProps"
                           :clearable="true"
                           :accordion="true"
                           @getValue="(value) => { form.parentId = value }"
              />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="名称"
                          prop="name"
                          :rules="[{required: true, message:'名称不能为空', trigger:'blur'}]"
            >
              <el-input v-model="form.name" placeholder="请填写名称"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="排序"
                          prop="sort"
                          :rules="[
                            {required: true, message:'排序不能为空', trigger:'blur'},
                            {validator: validator.isNumberValidator, trigger:'blur'}
                          ]"
            >
              <el-input v-model="form.sort" placeholder="请填写排序"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注信息"
                          prop="remarks"
                          :rules="[]"
            >
              <el-input type="textarea"
                        v-model="form.remarks"
                        placeholder="请填写备注信息"
              />
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
/**
 * Copyright © 2020-2021 <a href="http://www.entfrm.com/">entfrm</a> All rights reserved.
 * author entfrm开发团队-王翔
 */
import { listActCategory, delActCategory, getActCategory, editActCategory, addActCategory } from '@/api/flowable/extension/actCategory'
import treeSelect from '@/components/TreeSelect'
import XEUtils from 'xe-utils'
export default {
  components: {
    treeSelect
  },
  data () {
    return {
      showSearch: true,
      queryParams: {
        name:undefined
      },
      dataList: [],
      loading: false,
      title: '',
      open: false,
      form: {},
      treeSelectProps:{
        // ID字段名
        id: 'id',
        // 显示名称
        label: 'name',
        // 子级字段名
        children: 'children'
      },
      treeSelectList:[],
      method: '',
      ids: [],
      single: true,
      multiple: true
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 多选框选中数据 */
    handleSelectionChange (evt) {
      const { records } = evt
      this.ids = records.map(item => item.id)
      this.single = records.length != 1
      this.multiple = !records.length
    },
    /** 处理重置按钮操作 */
    handleResetQuery () {
      this.resetForm("queryForm")
    },
    /** 表单重置,主要清除参数配置对话框缓存 */
    reset () {
      this.form = {
        id: undefined,
        parentId: 0,
        name: undefined,
        sort: undefined,
        remarks: undefined
      }
    },
    /** 获取数据列表 */
    getList () {
      this.loading = true
      listActCategory().then(response => {
        this.dataList = XEUtils.toArrayTree(response.data,{
          parentKey: 'parentId', key: 'id', children: 'children'
        })
        this.handleSearch()
        this.loading = false
      })
    },
    /** 获取流程分类列表 */
    getActCategoryList () {
      listActCategory().then(response => {
        this.treeSelectList = response.data
      })
    },
    /** 处理搜索树形结构数据 */
    handleSearch () {
      let filterName = XEUtils.toValueString(this.queryParams.name).trim()
      if (filterName) {
        let options = { children: 'children' }
        let searchProps = ['name']
        this.dataList = XEUtils.searchTree(this.dataList, item => searchProps.some(key => XEUtils.toValueString(item[key]).indexOf(filterName) > -1), options)
      }
      this.$nextTick(() => {
        this.$refs.xTree.setAllTreeExpand(true)
      })
    },
    /** 处理新增按钮操作 */
    handleAdd () {
      this.reset()
      this.getActCategoryList()
      this.title = '添加流程分类'
      this.method = 'add'
      this.open = true
    },
    /** 处理新增下级按钮操作 */
    handleAddChild (row) {
      const { id } = row
      this.reset()
      this.getActCategoryList()
      this.title = '添加下级流程分类'
      this.method = 'addChild'
      this.form.parentId = id
      this.open = true
    },
    /** 处理修改按钮操作 */
    handleEdit (row) {
      const { id } = row
      this.getActCategoryList()
      getActCategory(id).then(response => {
        this.form = response.data
        this.title = '修改流程分类'
        this.method = 'edit'
        this.open = true
      })
    },
    /** 处理查看按钮操作 */
    handleView (row) {
      const { id } = row
      this.getActCategoryList()
      getActCategory(id).then(response => {
        this.form = response.data
        this.title = '查看流程分类'
        this.method = 'view'
        this.open = true
      })
    },
    /** 处理删除按钮操作 */
    handleDel (row) {
      const { id } = row
      let ids = id || this.ids
      this.$confirm(`确定删除所选项吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        if(id){
          // 针对于行删除做处理需要查找子集删除
          let treeData = XEUtils.findTree(this.dataList, item => item.id === id, {children:'children'})
          ids = XEUtils.toTreeArray([treeData.item],{children:'children',data:'id'})
        }
        delActCategory(ids).then(()=>{
          this.loading = false
          this.msgSuccess("删除成功")
          this.getList()
        })
      }).catch(() => {})
    },
    /** 表单提交 */
    handleSubmitForm () {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          if (this.method == 'edit') {
            editActCategory(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("修改成功")
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addActCategory(this.form).then(response => {
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
    }
  }
}
</script>
