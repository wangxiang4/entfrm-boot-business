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
          <el-form-item label="监听器类型" prop="listenerType" :rules="[{required: true, message:'监听器类型不能为空', trigger:'blur'}]">
            <el-radio-group v-model="form.listenerType" @change="handleClear">
              <el-radio :label="1">执行监听器</el-radio>
              <el-radio :label="2">任务监听器</el-radio>
            </el-radio-group>
         </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="事件" prop="event" :rules="[{required: true, message:'事件不能为空', trigger:'blur'}]">
            <el-select v-model="form.event" placeholder="请选择">
                <el-option
                  v-for="item in events"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"/>
            </el-select>
         </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="值类型" prop="valueType" :rules="[{required: true, message:'值类型不能为空', trigger:'blur'}]">
            <el-radio-group v-model="form.valueType">
                <el-radio :label="1">类</el-radio>
                <el-radio :label="2">表达式</el-radio>
                <el-radio :label="3">委托表达式</el-radio>
            </el-radio-group>
         </el-form-item>
        </el-col>
        <el-col :span="24">
            <el-form-item :label="valueLabel" prop="value" :rules="[{required: true, message:'值不能为空', trigger:'blur'}]">
			        <el-input
                v-model="form.value"
                placeholder="请填写值"/>
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
import {getListener,addListener,editListener} from "@/api/flowable/extension/listener";
export default {
  data () {
    return {
      title: '',
      method: '',
      visible: false,
      loading: false,
      valueLabel: '类',
      events: [
        {label: 'start', value: 'start'},
        {label: 'take', value: 'take'},
        {label: 'end', value: 'end'}
      ],
      form: {
        id: undefined,
        name: undefined,
        listenerType: 1,
        event: undefined,
        valueType: 1,
        value: undefined
      }
    }
  },
  watch: {
    'form.listenerType'(val) {
      if (val === 1) {
        this.events = [
          {label: 'start', value: 'start'},
          {label: 'take', value: 'take'},
          {label: 'end', value: 'end'}
        ]
      } else {
        this.events = [
          {label: 'start', value: 'start'},
          {label: 'assignment', value: 'assignment'},
          {label: 'complete', value: 'complete'},
          {label: 'delete', value: 'delete'}
        ]
      }
    },
    'form.valueType'(val) {
      if (val === 1) {
        this.valueLabel = '类'
      } else if (val === 2) {
        this.valueLabel = '表达式'
      } else {
        this.valueLabel = '委托表达式'
      }
    }
  },
  methods: {
    handleClear(){
      this.$set(this.form,'event',undefined)
    },
    init (method, id) {
      this.method = method
      this.form.id = id
      if (method === 'add') {
        this.title = `新建监听器`
      } else if (method === 'edit') {
        this.title = '修改监听器'
      } else if (method === 'view') {
        this.title = '查看监听器'
      }
      this.visible = true
      this.$nextTick(() => {
        this.$refs.form.resetFields()
        // 修改或者查看
        if(method === 'edit' || method === 'view'){
          getListener(this.form.id).then(({data}) => {
            this.form = data
          })
        }
      })
    },
    // 表单提交
    doSubmit () {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          this.loading = true
          if (this.method === 'edit') {
            editListener(this.form).then(response => {
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
            addListener(this.form).then(response => {
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
