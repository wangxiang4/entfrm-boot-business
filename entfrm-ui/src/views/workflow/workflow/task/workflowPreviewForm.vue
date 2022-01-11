<template>
 <div v-loading="loading" style="min-height:50px">
   <loquat-form v-if="visible"
                ref="loquatForm"
                :v-model="formData"
                style="height:calc(100vh - 190px)"
                :option="options"
   />
 </div>
</template>

<script>
import { getFormDefinitionJson } from '@/api/workflow/extension/formDefinitionJson'
import { startFormProcessDefinition, auditFormTask } from '@/api/workflow/workflow/task'

export default {
  name: 'WorkflowPreviewForm',
  props: {
    taskFormData: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
      visible: false,
      loading: false,
      formData: {},
      options: {}
    }
  },
  methods: {
    init (formJsonId) {
      if (formJsonId) {
        this.loading = true
        this.visible = false
        this.formData = {}
        getFormDefinitionJson(formJsonId).then(({data}) => {
          try {
            if (!data.json) throw new Error('当前数据没有json结构体')
            this.options = eval('(' + data.json + ')')
            const disableIds = []
            const hideIds = []
            this.taskFormData.forEach((item) => {
              if (item.value !== undefined) {
                this.formData[`${item.id}`] = item.value
              }
              if (item.readable === false) {
                hideIds.push(`${item.id}`)
              }
              if (item.writable === false) {
                disableIds.push(`${item.id}`)
              }
            })
            this.$refs.loquatForm.setHideIds(hideIds)
            this.$refs.loquatForm.setDisableIds(disableIds)
          } catch (e) { this.msgError(e) }
          this.loading = false
          this.visible = true
        }).catch(() => { this.loading = false })
      } else {
        this.$message.info('没有关联流程表单!')
        this.visible = true
      }
    },
    startFormProcessDefinition (data, callback) {
      this.loading = true
      const processVarsity = Object.assign(data.vars, this.formData)
      startFormProcessDefinition({
        ...data,
        vars: processVarsity
      }).then(response => {
        this.visible = false
        this.loading = false
        this.$message.success(response.msg)
        callback(response)
      }).then(() => { this.loading = false })
    },
    auditFormTask (data, callback) {
      this.loading = true
      const processVarsity = Object.assign(data.vars, this.formData)
      auditFormTask({
        data,
        vars: processVarsity
      }).then(response => {
        this.visible = false
        this.loading = false
        this.$message.success(response.msg)
        callback(response)
      }).then(() => { this.loading = false })
    }
  }
}
</script>
