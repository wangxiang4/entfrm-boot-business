<template>
<div>
  <el-dialog
    :title="title"
    v-loading="loading"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form size="small"
             :model="form"
             ref="form"
             label-width="120px"
             :disabled="method==='view'"
             @keyup.enter.native="doSubmit()"
             @submit.native.prevent>
      <el-row  :gutter="15">
        <el-col :span="24">
          <el-form-item label="上级流程分类" prop="parentId" :rules="[]">
            <tree-select
              ref="parent"
              :value="form.parentId"
              :list="treeSelectList"
              :props="treeProps"
              :clearable="true"
              :accordion="true"
              @getValue="(value) => {form.parentId=value}"/>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="名称" prop="name" :rules="[{required: true, message:'名称不能为空', trigger:'blur'}]">
            <el-input
              v-model="form.name"
              placeholder="请填写名称"/>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="排序" prop="sort"
             :rules="[
              {required: true, message:'排序不能为空', trigger:'blur'},
              {validator: validator.isNumberValidator, trigger:'blur'}
             ]">
            <el-input
              v-model="form.sort"
              placeholder="请填写排序"/>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="备注信息" prop="remarks" :rules="[]">
					  <el-input
              type="textarea"
              v-model="form.remarks"
              placeholder="请填写备注信息"/>
	        </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button size="small" @click="visible = false">关闭</el-button>
      <el-button size="small" type="primary" v-if="method != 'view'" @click="doSubmit()">确定</el-button>
    </span>
  </el-dialog>
</div>
</template>

<script>
import treeSelect from '@/components/TreeSelect'
import {listActCategory,addActCategory,editActCategory,getActCategory} from "@/api/flowable/actCategory";
export default {
  data () {
    return {
      title: '',
      method: '',
      visible: false,
      loading: false,
      form: {
        id: undefined,
        parentId: 0,
        name: undefined,
        sort: undefined,
        remarks: undefined
      },
      treeSelectList:[],
      treeProps:{
        // ID字段名
        value: 'id',
        // 显示名称
        label: 'name',
        // 子级字段名
        children: 'children'
      }
    }
  },
  components: {
    treeSelect
  },
  methods: {
    init (method, obj) {
      this.method = method
      this.form.id = obj.id
      if (method === 'add') {
        this.title = '新建流程分类'
      } else if (method === 'addChild') {
        this.title = '添加下级流程分类'
      } else if (method === 'edit') {
        this.title = '修改流程分类'
      } else if (method === 'view') {
        this.title = '查看流程分类'
      }
      this.visible = true
      this.$nextTick(() => {
        this.$refs.form.resetFields()
        this.form.parentId = obj.parentId
        listActCategory().then(response => {
          this.treeSelectList = response.data
        });
        // 修改或者查看
        if(method === 'edit' || method === 'view') {
          getActCategory(this.form.id).then(response => {
            this.form = response.data
          });
        }
      })
    },
    // 表单提交
    doSubmit () {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          this.loading = true
          if (this.method === 'edit') {
            editActCategory(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("修改成功");
                this.visible = false
                this.loading = false
                this.$emit('refreshDataList');
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addActCategory(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("新增成功");
                this.visible = false
                this.loading = false
                this.$emit('refreshDataList');
              } else {
                this.msgError(response.msg);
              }
            });
          }
        }
      })
    }
  }
}
</script>
