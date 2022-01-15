<template>
  <el-dialog title="退回任务"
             :close-on-click-modal="false"
             :visible.sync="visible"
             :appendToBody="true"
  >
    <el-select v-model="rollBackTaskDefKey"
               style="width:100%"
               placeholder="请选择驳回节点"
    >
      <el-option v-for="item in rollBackTaskList"
                 :key="item.taskDefKey"
                 :label="item.taskName"
                 :value="item.taskDefKey"
      />
    </el-select>
    <div slot="footer" class="dialog-footer">
        <el-button icon="el-icon-close" @click="visible = false">取消</el-button>
        <el-button icon="el-icon-check" type="primary" @click="doConfirm">确定</el-button>
    </div>
  </el-dialog>
</template>

<script>
import { rollBackTaskList } from '@/api/workflow/workflow/task'
export default {
  name: 'RollBackTaskSelect',
  data () {
    return {
      visible: false,
      rollBackTaskList: [],
      rollBackTaskDefKey: ''
    }
  },
  methods: {
    init (taskId) {
      this.visible = true
      rollBackTaskList(taskId).then(({ data }) => { this.rollBackTaskList = data })
    },
    doConfirm () {
      this.visible = false
      this.$emit('getRollBackTaskDefKey', this.rollBackTaskDefKey)
    }
  }
}
</script>

