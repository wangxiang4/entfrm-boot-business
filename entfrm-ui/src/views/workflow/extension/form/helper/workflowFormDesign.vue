<template>
  <div>
    <el-dialog v-loading="loading"
               title="设计流程表单"
               center
               fullscreen
               class="design"
               :visible.sync="visible"
               :close-on-click-modal="false"
    >
      <loquat-form-design v-if="visible"
                          ref="loquat-form-design"
                          style="height:calc(100vh - 133px)"
                          :toolbar="['clear', 'preview']"
                          :options="options"
                          :custom-fields="customFields"
      />
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="handleSubmitForm(0)">保存草稿</el-button>
        <el-button type="primary" @click="handleSubmitForm(1)">保存并发布</el-button>
        <el-button @click="visible = false">放弃</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getFormDefinitionJson, editFormDefinitionJson, addFormDefinitionJson } from '@/api/workflow/extension/formDefinitionJson'
export default {
  name: 'WorkflowFormDesign',
  data () {
    return {
      visible: false,
      loading: false,
      options: {},
      customFields: [{
        title: '自定义字段',
        list: [
          {
            title: '分割线',
            type: 'custom',
            component: 'el-divider',
            icon: 'iconfont icon-divider',
            label: '',
            propExclude: true,
            labelWidth: 0,
            params: {
              html: '<h3 style="color:red">分割线标题</h3>',
              contentPosition: 'left'
            }
          },
          {
            title: '警告',
            type: 'custom',
            component: 'el-alert',
            icon: 'el-icon-warning',
            label: '',
            propExclude: true,
            labelWidth: 0,
            params: {
              title: '警告警告警告警告',
              type: 'success'
            },
            events: {
              close () {
                console.log('alert关闭事件')
              }
            }
          }
        ]
      }],
      form: {}
    }
  },
  methods: {
    /** 表单重置,主要用于清除对话框缓存 */
    reset () {
      this.form = {
        id: undefined,
        formDefinitionId: undefined,
        json: undefined,
        version: undefined,
        status: undefined,
        isPrimary: undefined
      }
    },
    /** 初始化数据 */
    init (data = {}) {
      // 打开窗口
      this.visible = true
      this.$nextTick(() => {
        this.reset()
        this.options = {}
        this.form.id = data.id
        this.form.formDefinitionId = data.formDefinitionId
        if (this.form.id) {
          this.loading = true
          // 查看表单定义json详细
          getFormDefinitionJson(this.form.id).then(response => {
            this.form = response.data
            this.form.json && (this.options = this.form.json)
            this.loading = false
          }).catch(() =>  this.loading = false)
        }
      })
    },
    /** 处理表单提交 */
    handleSubmitForm (status) {
      this.form.json = this.$refs['loquat-form-design'].getWidgetFormJson()
      this.form.status = status
      this.form.isPrimary = '1'
      this.loading = true
      if (this.form.id != undefined) {
        editFormDefinitionJson(this.form).then(response => {
          if (response.code === 0) {
            this.msgSuccess("保存流程表单成功")
            this.visible = false
            this.$emit('refresh')
          } else this.msgError(response.msg)
          this.loading = false
        }).catch(() => this.loading = false)
      } else {
        addFormDefinitionJson(this.form).then(response => {
          if (response.code === 0) {
            this.msgSuccess("保存流程表单成功")
            this.visible = false
            this.$emit('refresh')
          } else this.msgError(response.msg)
          this.loading = false
        }).catch(() => this.loading = false)
      }
    }
  }
}
</script>
