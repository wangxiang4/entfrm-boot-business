<template>
  <div>
    <el-dialog v-loading="loading"
               title="设计流程模型"
               center
               fullscreen
               class="design"
               :visible.sync="visible"
               :close-on-click-modal="false"
    >
      <flowable-designer ref="flowableDesigner"
                         style="height:calc(100vh - 57px)"
                         :bpmn-xml="bpmnXml"
                         @refresh="$emit('refresh')"
      />
    </el-dialog>
  </div>
</template>

<script>
import { getModel, getModelXml } from '@/api/workflow/workflow/model'
export default {
  name: 'WorkflowFormDesign',
  data () {
    return {
      loading: false,
      visible: false,
      bpmnXml: ''
    }
  },
  methods: {
    /** 初始化数据 */
    init (modelId) {
      this.visible = true
      this.$nextTick(() => {
        this.$refs.flowableDesigner.setBpmnXml('')
        this.$refs.flowableDesigner.reset()
        if (modelId) {
          this.loading = true
          getModel(modelId).then(response => {
            this.$refs.flowableDesigner.setModelData(response)
            return getModelXml(modelId)
          }).then(response => {
            this.bpmnXml = response
            this.loading = false
          }).catch(() => { this.loading = false })
        }
      })
    }
  }
}
</script>
