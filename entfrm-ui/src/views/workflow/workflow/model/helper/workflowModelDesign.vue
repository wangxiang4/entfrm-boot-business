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
      this.loading = true
      this.visible = true
      this.$nextTick(() => {
        this.reset()
        this.bpmnXml = ''
        this.form.id = data.id
        // 查询关联数据
        const chain = []
        if (this.form.id) {
          // 查看模型详细
          chain.push(getModel(this.form.id).then(response => {
            this.form = response.data
          }))
          // 查询模型xml
          chain.push(getModelXml(this.form.id).then(response => {
            this.bpmnXml = response.data
          }))
        }
        // 加载完毕
        Promise.all(chain).then(() => { this.loading = false })
      })
    },
    /** 处理保存并发布 */
    handleSaveAndDeploy (id, code) {
      code === 1 && deployModel({
        id: id,
        category: '未分类'
      })
    },
    /** 处理活动属性扩展 */
    handleActivityExtension () {

    },
    /** 处理模型提交 */
    handleSubmitModel (bpmnModeler, operateCode) {
      if (bpmnModeler) {
        bpmnModeler.saveXML({
          format: true
        }).then(({ xml }) => {
          // 获取根流程业务对象
          const root = bpmnModeler.get('canvas')
            .getRootElement().businessObject
          const chain = []
          this.loading = true
          if (this.form.id != undefined) {
            // 处理模型编辑
            chain.push(editModel(this.form.id, {
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
              this.handleSaveAndDeploy(response.id, operateCode)
              this.handleActivityExtension()
            }))
          } else {
            // 处理模型新增
            chain.push(addModel({
              key: root.id,
              name: root.name,
              modelType: 0,
              description: ''
            }).then(response => {
              this.form = response
              this.handleSaveAndDeploy(response.id, operateCode)
              this.handleActivityExtension()
            }))
          }
          Promise.all(chain).then(() => {
            this.msgSuccess("保存流程模型成功")
            this.loading = false
            this.$emit('refresh')
          }).catch(() => this.loading = false)
        })
      } else {
        this.msgError("bpmn建模对象不存在,请检查!")
      }
    }
  }
}
</script>
