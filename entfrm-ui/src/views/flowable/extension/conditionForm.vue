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
            <el-form-item label="名称" prop="name" :rules="[{required: true, message:'名称不能为空', trigger:'blur'}]">
              <el-input
                v-model="form.name"
                placeholder="请填写名称"/>
           </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="表达式" prop="expression" :rules="[{required: true, message:'表达式不能为空', trigger:'blur'}]">
              <el-input
                v-model="form.expression"
                placeholder="请填写表达式"/>
           </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remarks" :rules="[]">
              <el-input
                type="textarea"
                v-model="form.remarks"
                placeholder="请填写备注"/>
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
  import {getCondition,addCondition,editCondition} from "@/api/flowable/condition";
  export default {
    data () {
      return {
        title: '',
        method: '',
        visible: false,
        loading: false,
        form: {
          id: undefined,
          name: undefined,
          expression: undefined,
          remarks: undefined
        }
      }
    },
    methods: {
      init (method, id) {
        this.method = method
        this.form.id = id
        if (method === 'add') {
          this.title = `新建流程表达式`
        } else if (method === 'edit') {
          this.title = '修改流程表达式'
        } else if (method === 'view') {
          this.title = '查看流程表达式'
        }
        this.visible = true
        this.$nextTick(() => {
          this.$refs.form.resetFields()
          // 修改或者查看
          if (method === 'edit' || method === 'view') {
            getCondition(this.form.id)
              .then(response => this.form = response.data);
          }
        })
      },
      // 表单提交
      doSubmit () {
        this.$refs["form"].validate(valid => {
          if (valid) {
            this.loading = true
            if (this.method === 'edit') {
              editCondition(this.form).then(response => {
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
              addCondition(this.form).then(response => {
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
        });
      }
    }
  }
</script>
