<template>
  <div>
    <el-dialog
      :title="title"
      v-loading="loading"
      :close-on-click-modal="false"
      :visible.sync="visible">
      <el-form size="small"
               :model="form"
               :rules="dataRule"
               ref="form"
               label-width="120px"
               :disabled="method==='view'"
               @keyup.enter.native="doSubmit()"
               @submit.native.prevent>
        <el-row  :gutter="15">
          <el-col :span="24">
              <el-form-item label="名称" prop="name">
                <el-input
                  v-model="form.name"
                  placeholder="请填写名称"/>
             </el-form-item>
          </el-col>
          <el-col :span="24">
              <el-form-item label="编码" prop="code">
                <el-input
                  :readonly="isDefaultButton(form.code)"
                  v-model="form.code"
                  placeholder="请输入按钮编码"/>
             </el-form-item>
             <el-form-item>
                <div class="tip">
                  <p>注意：按钮编码不能重复，系统按钮以_flow_开头，自定义按钮不能以_flow_开头。
                    系统按钮和自定义按钮的区别是，系统按钮是绑定具体的action进行提交，如果你定义了系统按钮，必须在代码中实现对应的action方法。
                    自定义按钮无需在代码中添加action方法，触发自定义按钮时调用的是【同意】按钮对应的action，并把该按钮对应的code设置为true、其他自定义按钮对应的code设置为false作为流程变量进行提交。</p>
                </div>
             </el-form-item>
          </el-col>
          <el-col :span="24">
              <el-form-item label="排序" prop="sort">
                <el-input-number
                  v-model="form.sort"
                  placeholder="请填写排序"/>
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
import {addButton,editButton,getButton} from "@/api/flowable/button";
export default {
  data () {
    const validatePass = (rule, value, callback) => {
      if (this.method === 'add' && this.isDefaultButton(value)) {
        callback(new Error('请勿使用系统预设编码!'))
      } else {
        callback()
      }
    }
    return {
      title: '',
      method: '',
      visible: false,
      loading: false,
      form: {
        id: undefined,
        name: undefined,
        code: undefined,
        sort: 0
      },
      dataRule: {
        name: [
            {required: true, message: '名称不能为空', trigger: 'blur'}
          ],
        code: [
            {required: true, message: '编码不能为空', trigger: 'blur'},
            {validator: validatePass, trigger: 'blur'}
          ],
        sort: [
            {required: true, message: '排序不能为空', trigger: 'blur'}
          ]
      }
    }
  },
  methods: {
    init (method, id) {
      this.method = method
      this.form.id = id
      if (method === 'add') {
        this.title = `新建常用按钮`
      } else if (method === 'edit') {
        this.title = '修改常用按钮'
      } else if (method === 'view') {
        this.title = '查看常用按钮'
      }
      this.visible = true;
      this.$nextTick(() => {
        this.$refs.form.resetFields()
        // 修改或者查看
        if (method === 'edit' || method === 'view') {
          getButton(this.form.id)
            .then(response => this.form = response.data);
        }
      })
    },
    isDefaultButton (code) {
      let defaultButtons = [
        '_flow_save',
        '_flow_agree',
        '_flow_reject',
        '_flow_back',
        '_flow_add_multi_instance',
        '_flow_del_multi_instance',
        '_flow_transfer',
        '_flow_delegate',
        '_flow_stop',
        '_flow_print'
      ]
      return defaultButtons.filter((val) => {
        return code === val
      }).length > 0
    },
    // 表单提交
    doSubmit () {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.loading = true
          if (this.method === 'edit') {
            editButton(this.form).then(response => {
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
            addButton(this.form).then(response => {
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
