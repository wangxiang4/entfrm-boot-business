<template>
  <div>
    <el-input :placeholder="placeholder"
              :size="size"
              :disabled="disabled"
              :readonly="readonly"
              v-model="label"
              class="input-with-select"
    >
      <el-button slot="append"
                 icon="el-icon-search"
                 :disabled="disabled"
                 :readonly="readonly"
                 @click="showUserSelect"
      />
    </el-input>
    <user-select-dialog ref="userSelect"
                        :limit="limit"
                        :selectData="selectData"
                        @doSubmit="selectUsersToInput"
    />
  </div>
</template>
<script>
import UserSelectDialog from './UserSelectDialog'
import { getUser } from '@/api/system/user'
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
      label: '',
      labelValue: this.value,
      selectData: []
    }
  },
  watch: {
    value: {
      handler (newVal) {
        if (newVal) {
          getUser(newVal).then(({data}) => {
            if (data.length != 0) {
              this.selectData = data
            }
          })
        }
      },
      immediate: true,
      deep: false
    },
    selectData: {
      handler (newVal) {
        this.label = newVal.map(user => user.userName).join(',')
      },
      immediate: true,
      deep: false
    }
  },
  methods: {
    selectUsersToInput (users) {
      this.selectData = users
      this.labelValue = users.map(user => user.id).join(',')
      this.label = users.map(user => user.userName).join(',')
      this.$emit('getValue', this.labelValue, this.label)
    },
    showUserSelect () {
      this.$refs.userSelect.init()
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


