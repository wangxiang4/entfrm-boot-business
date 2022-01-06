<template>
  <div class="app-container">
    <el-form v-show="showSearch"
             :model="queryParams"
             :inline="true"
             ref="queryForm"
             size="small"
             @keyup.enter.native="handleQuery"
             @submit.native.prevent
    >
      <el-form-item prop="version">
        <el-input v-model="queryParams.version"
                  placeholder="版本号"
                  clearable
        />
      </el-form-item>
      <el-form-item prop="status">
        <el-input v-model="queryParams.status"
                  placeholder="状态"
                  clearable
        />
      </el-form-item>
      <el-form-item prop="isPrimary">
        <el-input v-model="queryParams.isPrimary"
                  placeholder="是否主版本"
                  clearable
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary"
                   icon="el-icon-search"
                   size="mini"
                   @click="handleQuery"
        >搜索</el-button>
        <el-button icon="el-icon-refresh-right"
                   size="mini"
                   @click="resetQuery"
        >重置</el-button>
      </el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8">
      <div class="top-right-btn">
        <el-tooltip class="item"
                    effect="dark"
                    content="刷新"
                    placement="top"
        >
          <el-button size="mini"
                     circle
                     icon="el-icon-refresh"
                     @click="handleQuery"
          />
        </el-tooltip>
        <el-tooltip class="item"
                    effect="dark"
                    :content="showSearch ? '隐藏搜索' : '显示搜索'"
                    placement="top"
        >
          <el-button size="mini"
                     circle icon="el-icon-search"
                     @click="showSearch = !showSearch"
          />
        </el-tooltip>
      </div>
    </el-row>
    <el-table v-loading="loading" border :data="dataList">
      <el-table-column type="selection" align="center" width="50"/>
      <el-table-column prop="formDefinitionId" label="流程定义ID" show-overflow-tooltip/>
      <el-table-column prop="json" label="流程表单结构体" show-overflow-tooltip/>
      <el-table-column prop="version" label="版本号"/>
      <el-table-column prop="status" label="状态" show-overflow-tooltip>
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status === '1'" size="small" type="success">已发布</el-tag>
          <el-tag v-else size="small" type="danger">未发布</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="isPrimary" label="是否主版本" show-overflow-tooltip>
        <template slot-scope="scope">
          <el-tag v-if="scope.row.isPrimary === '1'" size="small" type="success">主版本</el-tag>
          <el-tag v-else size="small" type="danger">非主版本</el-tag>
        </template>
      </el-table-column>
      <el-table-column align="center" width="240" label="操作">
        <template slot-scope="scope">
          <el-button type="text"
                     icon="el-icon-view"
                     size="mini"
                     @click="handlePreview(scope.row)"
          >预览</el-button>
          <el-button v-if="scope.row.isPrimary === '0'"
                     type="text"
                     icon="el-icon-edit"
                     size="mini"
                     @click="handleSetPrimaryVersion(scope.row)"
          >设置为主版本</el-button>
          <el-button v-if="scope.row.isPrimary === '0'"
                     type="text"
                     size="mini"
                     icon="el-icon-delete"
                     @click="handleDel(scope.row)"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <pagination v-show="total>0"
                :total="total"
                :page.sync="queryParams.current"
                :limit.sync="queryParams.size"
                @pagination="getList"
    />
    <!--预览表单-->
    <el-dialog title="流程表单预览"
               center
               fullscreen
               :visible.sync="open"
               :close-on-click-modal="false"
    >
      <loquat-form style="height:calc(100vh - 190px)" :option="options"/>
      <span slot="footer" class="dialog-footer">
        <el-button size="small"
                   @click="open = false"
        >关闭</el-button>
        <el-button size="small"
                   type="primary"
                   @click="open = false"
        >确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
/**
 * Copyright © 2020-2021 <a href="http://www.entfrm.com/">entfrm</a> All rights reserved.
 * author entfrm开发团队-王翔
 */
import { listFormDefinitionJson, delFormDefinitionJson, setPrimaryVersion } from '@/api/workflow/extension/formDefinitionJson'
export default {
  name: 'FormDefinitionJson',
  data () {
    return {
      queryParams: {
        current: 1,
        size: 10,
        formDefinitionId: this.$route.params.id,
        version: undefined,
        status: undefined,
        isPrimary: undefined
      },
      showSearch: true,
      dataList: [],
      total: 0,
      loading: false,
      open: false,
      options: {}
    }
  },
  activated () {
    this.getList()
  },
  created(){
    this.getList()
  },
  methods: {
    /** 查询列表 */
    getList() {
      this.loading = true
      listFormDefinitionJson(this.queryParams).then(response => {
        this.dataList = response.data
        this.total = response.total
        this.loading = false
      }).catch(() => this.loading = false)
    },
    /** 处理搜索按钮操作 */
    handleQuery() {
      this.queryParams.current = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery () {
      this.resetForm("queryForm")
    },
    /** 处理删除按钮操作 */
    handleDel (row) {
      this.$confirm(`确定删除该版本吗? 删除之后，已发起的流程如果使用了该版本，将无法查看表单内容!`, '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        return delFormDefinitionJson(row.id).then(response => {
          this.msgSuccess("删除成功")
          this.getList()
        })
      }).catch(() => this.loading = false)
    },
    /** 处理设置主版本 */
    handleSetPrimaryVersion (row) {
      this.$confirm(`确定设置该版本为主版本吗?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        return setPrimaryVersion(row.id).then(response => {
          this.msgSuccess("设置成功")
          this.getList()
        })
      }).catch(() => this.loading = false)
    },
    /** 处理预览 */
    handlePreview (row) {
      try {
        if (!row.json) throw new Error('当前数据没有json结构体')
        this.options = eval('(' + row.json + ')')
        this.open = true
      } catch (e) {
        this.msgError(e)
      }
    }
  }
}
</script>
