<template>
  <div>
    <el-input :placeholder="placeholder"
              :size="size"
              :disabled="disabled"
              :readonly="readonly"
              v-model="userNames"
              class="input-with-select"
    >
      <el-button slot="append"
                 icon="el-icon-search"
                 :disabled="disabled"
                 :readonly="readonly"
                 @click="initUserSelectDialog"
      />
    </el-input>
    <user-select-dialog ref="userSelectDialog"
                        :limit="limit"
                        :selectData="selectData"
                        @doSubmit="handleDialogSelectUser"
    />
  </div>
</template>
<script>
/**
 * @program: entfrm-ui
 *
 * @description: 通用用户选择组件(输入框)
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2021-06-22
 */
import UserSelectDialog from './UserSelectDialog'
import { getUser } from '@/api/workflow/workflow/task'
export default {
  name: 'UserSelect',
  components: { UserSelectDialog },
  props: {
    limit: Number,
    value: String,
    size: {
      type: String,
      default: 'small'
    },
    placeholder: {
      type: String,
      default: '请选择'
    },
    readonly: {
      type: Boolean,
      default: false
    },
    disabled: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      userIds: this.value,
      userNames: '',
      selectData: []
    }
  },
  watch: {
    value: {
      handler (newVal) {
        if (newVal) {
          getUser(newVal).then(({ data }) => {
            if (data.length) this.selectData = data
          })
        }
      },
      immediate: true
    },
    selectData: {
      handler (newVal) {
        this.userNames = newVal.map(user => user.userName).join(',')
      },
      immediate: true,
      deep: false
    }
  },
  methods: {
    /** 处理对话框选中的用户 */
    handleDialogSelectUser (userList) {
      this.selectData = userList
      this.userIds = userList.map(user => user.id).join(',')
      this.userNames = userList.map(user => user.userName).join(',')
      this.$emit('getValue', this.userIds, this.userNames)
    },
    /** 初始化用户选择弹出框 */
    initUserSelectDialog() {
      this.$refs.userSelectDialog.init()
    }
  }
}
</script>
<style>
 .el-tag + .el-tag {
    margin-left: 5px;
    margin-bottom: 5px;
  }
</style>


