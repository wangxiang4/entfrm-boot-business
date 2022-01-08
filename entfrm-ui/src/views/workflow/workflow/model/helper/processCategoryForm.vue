<template>
  <el-dialog v-loading="loading"
             title="请选择流程分类"
             :visible.sync="visible"
             width="70vh"
             :close-on-click-modal="false"
  >
    {{selectCategoryName}}
    <el-tree class="filter-tree"
             :data="categoryTreeData"
             :props="{
                       value: 'id',             // ID字段名
                       label: 'name',           // 显示名称
                       children: 'children'     // 子级字段名
                     }"
             default-expand-all
             :expand-on-click-node="false"
             @node-click="handleNodeClick"
    />
    <span slot="footer" class="dialog-footer">
      <el-button size="small"
                 @click="visible = false"
      >关闭</el-button>
      <el-button size="small"
                 type="primary"
                 @click="handleSubmitForm"
      >确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
import { listCategory } from '@/api/workflow/extension/category'
import { setProcessCategory } from '@/api/workflow/workflow/process'
import XEUtils from 'xe-utils'
export default {
  name: 'ProcessCategoryForm',
  data () {
    return {
      loading: false,
      visible: false,
      categoryTreeData: [],
      selectCategoryName: '',
      form: {}
    }
  },
  methods: {
    init (id) {
      this.visible = true
      this.form.processDefId = id
      this.form.category = ''
      this.$nextTick(() => {
        this.selectCategoryName = ''
        this.refreshTree()
      })
    },
    refreshTree () {
      this.loading = true
      listCategory().then(response => {
        this.categoryTreeData = XEUtils.toArrayTree(response.data,{
          parentKey: 'parentId', key: 'id', children: 'children', sortKey: 'sort'
        })
        this.loading = false
      }).catch(() => { this.loading = false })
    },
    handleNodeClick (data) {
      this.form.category = data.name
      this.selectCategoryName = '已选类型: ' + data.name
    },
    handleSubmitForm () {
      if (this.form.category) {
        setProcessCategory(this.form).then(response => {
          if (response.code === 0) {
            this.msgSuccess("设置流程分类成功!")
            this.visible = false
            this.$emit('refresh')
          } else this.msgError(response.msg)
          this.loading = false
        }).catch(() => { this.loading = false })
      } else {
        this.$message.error('请选择一个分类!')
      }
    }
  }
}
</script>
