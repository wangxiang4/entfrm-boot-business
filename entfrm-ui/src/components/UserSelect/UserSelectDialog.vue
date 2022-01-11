<template>
  <div>
    <el-dialog :title="title"
               class="userDialog"
               width="155vh"
               :close-on-click-modal="false"
               :append-to-body="true"
               :visible.sync="visible"
    >
      <el-container style="height: 500px">
        <el-aside width="200px">
          <el-card class="org">
            <div slot="header" class="clearfix">
              <el-input v-model="filterText" placeholder="请输入组织机构过滤" size="small"/>
            </div>
            <el-tree ref="officeTree"
                     :data="officeTreeData"
                     :props="{
                       value: 'id',             // ID字段名
                       label: 'name',           // 显示名称
                       children: 'children'     // 子级字段名
                     }"
                     default-expand-all
                     highlight-current
                     node-key="id"
                     :render-content="renderContent"
                     :filter-node-method="filterNode"
                     :expand-on-click-node="false"
                     @node-click="handleNodeClick"
            />
          </el-card>
        </el-aside>
        <el-container>
          <el-header style="text-align:left;font-size:12px;height:30px">
            <el-form ref="searchForm"
                     :model="searchForm"
                     size="small"
                     :inline="true"
                     @keyup.enter.native="refreshList()"
                     @submit.native.prevent
            >
              <el-form-item prop="userName">
                <el-input size="small"
                          v-model="searchForm.userName"
                          placeholder="用户名称"
                          clearable
                />
              </el-form-item>
              <el-form-item>
                <el-button type="primary"
                           size="small"
                           icon="el-icon-search"
                           @click="refreshList()"
                >查询</el-button>
                <el-button size="small"
                           icon="el-icon-refresh-right"
                           @click="resetSearch()"
                >重置</el-button>
              </el-form-item>
            </el-form>
          </el-header>
          <el-main>
            <el-table :data="dataList"
                      v-loading="loading"
                      size="small"
                      ref="userTable"
                      @selection-change="selectionChangeHandle"
                      height="calc(100% - 60px)"
                      style="width: 100%;"
            >
              <el-table-column v-if="limit <= 1" header-align="center" align="center" width="50">
                <template slot-scope="scope">
                  <el-radio :label="scope.row.id"
                            :value="dataListAllSelections[0]&&dataListAllSelections[0].id"
                            @change.native="getTemplateRow(scope.$index,scope.row)"
                  ><span/></el-radio>
                </template>
              </el-table-column>
              <el-table-column v-else type="selection" width="50" align="center"/>
              <el-table-column label="用户编号" align="center" prop="id"/>
              <el-table-column label="用户名称" align="center" prop="userName" :show-overflow-tooltip="true"/>
              <el-table-column label="用户昵称" align="center" prop="nickName" :show-overflow-tooltip="true"/>
              <el-table-column label="机构名称" align="center" prop="deptName" :show-overflow-tooltip="true"/>
            </el-table>
            <el-pagination :page-sizes="[5, 10, 50, 100]"
                           :current-page="searchForm.current"
                           :page-size="searchForm.size"
                           :total="total"
                           layout="total, sizes, prev, pager, next, jumper"
                           @size-change="sizeChangeHandle"
                           @current-change="currentChangeHandle"
            />
          </el-main>
        </el-container>
        <el-aside width="200px">
          <el-tag v-for="tag in dataListAllSelections"
                  :key="tag.id"
                  closable
                  :disable-transitions="false"
                  @close="del(tag)"
          >{{tag.userName}}</el-tag>
        </el-aside>
      </el-container>
      <span slot="footer" class="dialog-footer">
        <el-button size="small" @click="visible = false">关闭</el-button>
        <el-button size="small" type="primary" @click="doSubmit()">确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { deptTree } from '@/api/system/dept'
import { listUser } from '@/api/system/user'

export default {
  name: 'UserSelectDialog',
  props: {
    selectData: {
      type: Array,
      default: () => []
    },
    title: {
      type: String,
      default: '用户选择'
    },
    limit: {
      type: Number,
      default: 999999
    }
  },
  data () {
    return {
      searchForm: {
        current: 1,
        size: 10,
        userName: undefined,
        deptId: undefined,
        status: 0
      },
      filterText: '',
      // 所有选中的数据包含跨页数据
      dataListAllSelections: [],
      dataListSelections: [],
      // 标识列表数据中每一行的唯一键的名称(需要按自己的数据改一下)
      idKey: 'id',
      dataList: [],
      officeTreeData: [],
      total: 0,
      loading: false,
      visible: false
    }
  },
  watch: {
    filterText (val) {
      this.$refs.officeTree.filter(val)
    }
  },
  methods: {
    init () {
      this.visible = true
      this.$nextTick(() => {
        this.dataListAllSelections = JSON.parse(JSON.stringify(this.selectData))
        this.refreshTree()
        this.resetSearch()
      })
    },
    renderContent (h, { node, data, store }) {
      return (
        <span>
          {data.parentId == 0 ? <i class="el-icon-menu"/> : <i class="el-icon-s-custom"/>}
          <span class="text">{node.label}</span>
        </span>
      )
    },
    /** 获取选中数据 */
    getTemplateRow (index, row) {
      this.dataListSelections = [row]
      this.$nextTick(() => {
        this.changePageCoreRecordData()
      })
    },
    /** 设置选中的方法 */
    setSelectRow () {
      if (!this.dataListAllSelections || this.dataListAllSelections.length <= 0) {
        this.$refs.userTable.clearSelection()
        return
      }
      // 标识当前行的唯一键的名称
      let idKey = this.idKey
      let selectAllIds = []
      this.dataListAllSelections.forEach(row => {
        selectAllIds.push(row[idKey])
      })
      this.$refs.userTable.clearSelection()
      for (let i = 0; i < this.dataList.length; i++) {
        if (selectAllIds.indexOf(this.dataList[i][idKey]) >= 0) {
          this.$refs.userTable.toggleRowSelection(this.dataList[i], true)
        }
      }
    },
    /** 记忆选择核心方法 */
    changePageCoreRecordData () {
      // 标识当前行的唯一键的名称
      let idKey = this.idKey
      let that = this
      // 如果总记忆中还没有选择的数据，那么就直接取当前页选中的数据，不需要后面一系列计算
      if (this.dataListAllSelections.length <= 0) {
        this.dataListSelections.forEach(row => { that.dataListAllSelections.push(row) })
        return
      }
      // 总选择里面的key集合
      let selectAllIds = []
      this.dataListAllSelections.forEach(row => { selectAllIds.push(row[idKey]) })
      let selectIds = []
      // 获取当前页选中的id
      this.dataListSelections.forEach(row => {
        selectIds.push(row[idKey])
        // 如果总选择里面不包含当前页选中的数据，那么就加入到总选择集合里
        if (selectAllIds.indexOf(row[idKey]) < 0) {
          that.dataListAllSelections.push(row)
        }
      })
      let noSelectIds = []
      // 得到当前页没有选中的id
      this.dataList.forEach(row => {
        if (selectIds.indexOf(row[idKey]) < 0) {
          noSelectIds.push(row[idKey])
        }
      })
      noSelectIds.forEach(id => {
        if (selectAllIds.indexOf(id) >= 0) {
          for (let i = 0; i < that.dataListAllSelections.length; i++) {
            if (that.dataListAllSelections[i][idKey] === id) {
              // 如果总选择中有未被选中的，那么就删除这条
              that.dataListAllSelections.splice(i, 1)
              break
            }
          }
        }
      })
    },
    /** 得到选中的所有数据 */
    getAllSelectionData () {
       // 再执行一次记忆勾选数据匹配，目的是为了在当前页操作勾选后直接获取选中数据
      this.changePageCoreRecordData()
    },
    filterNode (value, data) {
      if (!value) return true
      return data.name.indexOf(value) !== -1
    },
    del (tag) {
      this.dataListAllSelections.splice(this.dataListAllSelections.indexOf(tag), 1)
      this.$nextTick(() => {
        this.setSelectRow()
      })
    },
    /** 获取数据列表 */
    refreshList () {
      this.loading = true
      listUser(this.searchForm).then(response => {
          this.dataList = response.data
          this.total = response.total
          this.loading = false
          this.$nextTick(() => {
            this.setSelectRow()
          })
      })
    },
    refreshTree () {
      deptTree().then(({data}) => {
        this.officeTreeData = data
      })
    },
    // 每页数
    sizeChangeHandle (val) {
      this.searchForm.size = val
      this.searchForm.current = 1
      this.refreshList()
      this.$nextTick(() => {
        this.changePageCoreRecordData()
      })
    },
    // 当前页
    currentChangeHandle (val) {
      this.searchForm.current = val
      this.refreshList()
      this.$nextTick(() => {
        this.changePageCoreRecordData()
      })
    },
    selectionChangeHandle (val) {
      this.dataListSelections = val
      this.$nextTick(() => {
        this.changePageCoreRecordData()
      })
    },
    handleNodeClick (node) {
      this.searchForm.deptId = node.deptId
      this.refreshList()
    },
    resetSearch () {
      this.$refs.officeTree.setCurrentKey(null)
      this.$refs.searchForm.resetFields()
      this.refreshList()
    },
    doSubmit () {
      if (this.limit < this.dataListAllSelections.length) {
        this.$message.error(`你最多只能选择${this.limit}个用户`)
        return
      }
      this.visible = false
      this.$emit('doSubmit', this.dataListAllSelections)
    }
  }
}
</script>
<style scoped lang="scss">
.org {
  height: 100%;

  ::v-deep .el-card__header {
    padding: 10px;
  }

  ::v-deep .el-card__body {
    padding: 10px;
    max-height: 520px;
    overflow: auto;
  }
}
.userDialog {
  ::v-deep .el-dialog__body {
    padding: 10px 0px 0px 10px;
    color: #606266;
    font-size: 14px;
    word-break: break-all;
  }

  ::v-deep .el-main {
    padding: 20px 20px 5px 20px;

    ::v-deep .el-pagination{
      margin-top: 5px;
    }
  }
}
</style>
