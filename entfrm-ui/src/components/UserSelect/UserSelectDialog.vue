<template>
  <div>
    <el-dialog :title="title"
               class="userSelectDialog"
               width="155vh"
               :close-on-click-modal="false"
               :append-to-body="true"
               :visible.sync="visible"
    >
      <el-container style="height:500px">
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
                      @selection-change="handleSelectionChange"
                      height="calc(100% - 60px)"
                      style="width: 100%;"
            >
              <el-table-column v-if="limit <= 1" header-align="center" align="center" width="50">
                <template slot-scope="scope">
                  <el-radio :label="scope.row[idKey]"
                            :value="dataSelectionAllList[0] && dataSelectionAllList[0][idKey]"
                            @change.native="getRadioRowData(scope.$index, scope.row)"
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
                           @size-change="handleSizeChangeHandle"
                           @current-change="handleCurrentChangeHandle"
            />
          </el-main>
        </el-container>
        <el-aside width="200px">
          <el-tag v-for="data in dataSelectionAllList"
                  :key="data[idKey]"
                  closable
                  :disable-transitions="false"
                  @close="handleDelSelectData(data)"
          >{{data.userName}}</el-tag>
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
/**
 * @program: entfrm-ui
 *
 * @description: 通用用户选择组件(弹出框)
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2021-06-22
 */
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
      // 搜索表单
      searchForm: {
        current: 1,
        size: 10,
        userName: undefined,
        deptId: undefined,
        status: 0
      },
      // 过滤名称
      filterText: '',
      // 记录所有选中的数据含跨页数据
      dataSelectionAllList: [],
      // 记录当前页数据
      dataSelectionList: [],
      // 标识列表数据中每一行的唯一键的名称(需要按自己的数据改一下)
      idKey: 'id',
      // 表格数据
      dataList: [],
      // 组织架构数据
      officeTreeData: [],
      // 分页总数量
      total: 0,
      // 遮罩层
      loading: false,
      // 显示
      visible: false
    }
  },
  watch: {
    filterText (val) {
      this.$refs.officeTree.filter(val)
    }
  },
  methods: {
    /** 初始化对话框 */
    init () {
      this.visible = true
      this.$nextTick(() => {
        this.dataSelectionAllList = JSON.parse(JSON.stringify(this.selectData))
        this.refreshTree()
        this.resetSearch()
      })
    },
    /** 设置组织架构渲染结构 */
    renderContent (h, { node, data, store }) {
      return (
        <span>
          {data.parentId == 0 ? <i class="el-icon-menu"/> : <i class="el-icon-s-custom"/>}
          <span class="text">{node.label}</span>
        </span>
      )
    },
    /** 获取单选框选中行数据 */
    getRadioRowData (index, row) {
      this.dataSelectionList = [row]
      this.$nextTick(() => { this.handleTableRecordData() })
    },
    /** 设置表格自动选中行 */
    setTableSelectRow () {
      if (!this.dataSelectionAllList || this.dataSelectionAllList.length <= 0) {
        this.$refs.userTable.clearSelection()
        return
      }
      // 标识当前行的唯一键的名称
      const idKey = this.idKey
      const selectAllIds = []
      this.dataSelectionAllList.forEach(row => { selectAllIds.push(row[idKey]) })
      this.$refs.userTable.clearSelection()
      for (let i = 0; i < this.dataList.length; ++i) {
        if (selectAllIds.indexOf(this.dataList[i][idKey]) >= 0) {
          this.$refs.userTable.toggleRowSelection(this.dataList[i], true)
        }
      }
    },
    /** 处理表格记录数据 */
    handleTableRecordData () {
      const that = this
      // 标识当前行的唯一键的名称
      const idKey = this.idKey
      // 如果总记录数据还没有选择的数据,那么就直接取当前页选中的数据,不需要后面一系列分页记录处理
      if (this.dataSelectionAllList.length <= 0) {
        this.dataSelectionList.forEach(row => { that.dataSelectionAllList.push(row) })
        return
      }
      // 总记录选择数据key集合
      const selectAllIds = []
      this.dataSelectionAllList.forEach(row => { selectAllIds.push(row[idKey]) })
      // 本页记录选择数据key集合
      const selectIds = []
      // 获取本页选中的id
      this.dataSelectionList.forEach(row => {
        selectIds.push(row[idKey])
        // 如果总记录选择数据中不包含本页记录选中的数据,那么就加入到总记录选择数据集合里
        if (selectAllIds.indexOf(row[idKey]) < 0) {
          that.dataSelectionAllList.push(row)
        }
      })
      // 本页记录未选择数据key集合
      const noSelectIds = []
      // 获取本页未选中的id
      this.dataList.forEach(row => {
        if (selectIds.indexOf(row[idKey]) < 0) {
          noSelectIds.push(row[idKey])
        }
      })
      noSelectIds.forEach(id => {
        if (selectAllIds.indexOf(id) >= 0) {
          for (let i = 0; i < that.dataSelectionAllList.length; ++i) {
            if (that.dataSelectionAllList[i][idKey] === id) {
              // 如果总记录选择数据集合中有未被选中的,则进行移除
              that.dataSelectionAllList.splice(i, 1)
              break
            }
          }
        }
      })
    },
    /** 得到选中的所有数据 */
    getAllSelectionData () {
       // 再执行一次表格记录数据处理,目的是为了在当前页操作勾选后直接获取选中数据
      this.handleTableRecordData()
    },
    /** 设置组织架构过滤逻辑 */
    filterNode (value, data) {
      if (!value) return true
      return data.name.indexOf(value) !== -1
    },
    /** 处理删除选择数据 */
    handleDelSelectData (data) {
      this.dataSelectionAllList.splice(this.dataSelectionAllList.indexOf(data), 1)
      this.$nextTick(() => { this.setTableSelectRow() })
    },
    /** 刷新表格数据列表 */
    refreshList () {
      this.loading = true
      listUser(this.searchForm).then(response => {
          this.dataList = response.data
          this.total = response.total
          this.loading = false
          this.$nextTick(() => { this.setTableSelectRow() })
      }).catch(() => { this.loading = false })
    },
    /** 刷新组织架构树 */
    refreshTree () {
      deptTree().then(({data}) => { this.officeTreeData = data })
    },
    /** 处理分页数量改动 */
    handleSizeChangeHandle (val) {
      this.searchForm.size = val
      this.searchForm.current = 1
      this.refreshList()
      this.$nextTick(() => { this.handleTableRecordData() })
    },
    /** 处理分页当前页改动 */
    handleCurrentChangeHandle (val) {
      this.searchForm.current = val
      this.refreshList()
      this.$nextTick(() => { this.handleTableRecordData() })
    },
    /** 处理表格选择改动 */
    handleSelectionChange (val) {
      this.dataSelectionList = val
      this.$nextTick(() => { this.handleTableRecordData() })
    },
    /** 处理树点击 */
    handleNodeClick (node) {
      this.searchForm.deptId = node.deptId
      this.refreshList()
    },
    /** 处理重置搜索 */
    resetSearch () {
      this.$refs.officeTree.setCurrentKey(null)
      this.$refs.searchForm.resetFields()
      this.refreshList()
    },
    /** 提交当前数据 */
    doSubmit () {
      if (this.limit < this.dataSelectionAllList.length) {
        this.$message.error(`你最多只能选择${this.limit}个用户`)
        return
      }
      this.visible = false
      this.$emit('doSubmit', this.dataSelectionAllList)
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

.userSelectDialog {
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
