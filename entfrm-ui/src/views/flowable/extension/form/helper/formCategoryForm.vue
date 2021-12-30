<template>
<div>
  <el-dialog :title="title"
             :visible.sync="visible"
             :close-on-click-modal="false"
  >
    <el-form v-loading="loading"
             ref="form"
             size="small"
             :model="form"
             :disabled="method=='view'"
             label-width="120px"
    >
      <el-row :gutter="15">
        <el-col :span="24">
          <el-form-item label="父级编号"
                        prop="parentId"
                        :rules="[]"
          >
            <tree-select ref="parent"
                         :value="form.parentId"
                         :list="treeSelectList"
                         :props="{
                           value: 'id',           // ID字段名
                           label: 'name',         // 显示名称
                           children: 'children'   // 子级字段名
                         }"
                         :clearable="true"
                         :accordion="true"
                         @getValue="(value) => {form.parentId=value}"/>
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
                 @click="visible = false"
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
import treeSelect from '@/components/TreeSelect'
import { listFormCategory, getFormCategory, addFormCategory, editFormCategory } from '@/api/flowable/extension/formCategory'
export default {
  components: {
    treeSelect
  },
  data () {
    return {
      title: '',
      method: '',
      visible: false,
      loading: false,
      form: {
        id: undefined,
        parentId: undefined,
        name: undefined,
        sort: undefined,
        remarks: undefined
      },
      treeSelectList:[]
    }
  },
  methods: {
    /** 窗口传递数据 */
    setData (method, data = {}) {
      // todo: setData赋值
      this.method = method
      if (method == 'add') {
        this.title = '新建表单分类'
      } else if (method == 'addChild') {
        this.title = '添加下级表单分类'
      } else if (method == 'edit') {
        this.title = '修改表单分类'
      } else if (method == 'view') {
        this.title = '查看表单分类'
      }
      // 打开窗口
      this.loading = true
      this.visible = true
      this.$nextTick(() => {
        this.$refs.form.resetFields()
        this.form.parentId = data.parentId
        // 查询关联数据
        const chain = [
          listFormCategory().then(response => {
            this.treeSelectList = response.data
          })
        ]
        if (method == 'edit' || method == 'view') {
          chain.push(getFormCategory(data.id).then(response => {
            this.form = response.data
          }))
        }
        // 加载完毕
        Promise.all(chain).then(() => { this.loading = false })
      })
    },
    /** 处理表单提交 */
    handleSubmitForm () {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          this.loading = true
          if (this.method == 'edit') {
            editFormCategory(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("修改成功")
                this.visible = false
                this.loading = false
                this.$emit('refresh')
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addFormCategory(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("新增成功")
                this.visible = false
                this.loading = false
                this.$emit('refresh')
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
