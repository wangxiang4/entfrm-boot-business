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
                         @save="handleSubmitModel"
      />
    </el-dialog>
  </div>
</template>

<script>
import { getModel, getModelXml, editModel, addModel, getModelJson, deployModel } from '@/api/workflow/workflow/model'

export default {
  name: 'WorkflowFormDesign',
  data () {
    return {
      loading: false,
      visible: false,
      bpmnXml: '',
      form: {}
    }
  },
  methods: {
    /** 表单重置,主要用于清除对话框缓存 */
    reset () {
      this.form = {
        id: undefined,
        key: undefined,
        name: undefined,
        description: undefined,
        createdBy: undefined,
        lastUpdatedBy: undefined,
        lastUpdated: undefined,
        latestVersion: undefined,
        version: undefined,
        modelType: undefined
      }
    },
    /** 初始化数据 */
    init (data = {}) {
      this.visible = true
      this.$nextTick(() => {
        this.reset()
        this.bpmnXml = ''
        this.form.id = data.id
        if (this.form.id) {
          // 查看模型详细
          this.loading = true
          getModel(this.form.id).then(response => {
            this.form = response.data
            return getModelXml(this.form.id)
          }).then(response => {
            this.bpmnXml = response.data
            this.loading = false
          }).catch(() => this.loading = false)
        }
      })
    },
    /** 处理模型提交 */
    handleSubmitModel (bpmnModeler, operateCode) {
      if (bpmnModeler) {
        // 获取根流程业务对象
        const root = bpmnModeler.get('canvas').getRootElement().businessObject
        this.loading = true
        if (this.form.id != undefined) {
          bpmnModeler.saveXML({
            format: true
          }).then(({ xml }) => {
            // 处理模型修改
            editModel(this.form.id, {
              key: root.id,
              name: root.name,
              json_xml: xml,
              // 这个字段为后期版本冲突功能做准备
              newversion: false,
              description: '',
              comment: '',
              lastUpdated: this.form.lastUpdated
            }).then(response => {
              this.form = response
              return operateCode === 1 && deployModel({
                id: response.id,
                category: '未分类'
              })
            }).then(() => {
              return getModelJson(this.form.id)
            }).then(response => {
              // ---------------------处理活动扩展元素存储-----------------------------
              console.log('模型json数据:', response)
            }).then(() => {
              this.msgSuccess("保存流程模型成功!")
              this.loading = false
              this.$emit('refresh')
            }).catch(() => {
              this.msgSuccess("保存流程模型失败!")
              this.loading = false
            })
          })
        } else {
          // 处理模型新增
          addModel({
            key: root.id,
            name: root.name,
            modelType: 0,
            description: ''
          }).then(response => {
            this.form = response
            this.handleSubmitModel(bpmnModeler, operateCode)
          }).catch(() => this.loading = false)
        }
      } else {
        this.msgError("bpmn建模对象不存在,请检查!")
      }
    }
  }
}
</script>
