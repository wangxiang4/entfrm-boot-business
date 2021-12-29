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
      <el-form-item prop="name">
        <el-input v-model="queryParams.name" placeholder="名称" clearable/>
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
      <el-col :span="1.5">
        <el-button type="primary"
                   size="mini"
                   icon="el-icon-plus"
                   @click="handleAdd"
        >新建</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning"
                   size="mini"
                   icon="el-icon-edit-outline"
                   :disabled="single"
                   @click="handleEdit"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger"
                   size="mini"
                   icon="el-icon-delete"
                   @click="handleDel"
                   :disabled="multiple"
        >删除</el-button>
      </el-col>
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
                     circle
                     icon="el-icon-search"
                     @click="showSearch=!showSearch"
          />
        </el-tooltip>
      </div>
    </el-row>
    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" align="center" width="50"/>
      <el-table-column prop="name" label="名称"/>
      <el-table-column prop="listenerType" label="监听器类型">
        <template slot-scope="scope">
          {{ scope.row.listenerType === 1 ?'执行监听器':'任务监听器'}}
        </template>
      </el-table-column>
      <el-table-column prop="event" label="事件"/>
      <el-table-column prop="valueType" label="值类型">
        <template slot-scope="scope">
          {{ {'1':'类', '2':'表达式', '3':'委托表达式'}[scope.row.valueType]}}
        </template>
      </el-table-column>
      <el-table-column prop="value" label="值"/>
      <el-table-column align="center" width="200" label="操作">
        <template slot-scope="scope">
          <el-button type="text"
                     icon="el-icon-view"
                     size="mini"
                     @click="handleView(scope.row)"
          >查看</el-button>
          <el-button type="text"
                     icon="el-icon-edit"
                     size="mini"
                     @click="handleEdit(scope.row)"
          >修改</el-button>
          <el-button type="text"
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
    <!-- 添加或修改参数配置对话框 -->
    <el-dialog :title="title"
               :visible.sync="open"
               :close-on-click-modal="false"
    >
      <el-form size="small"
               :model="form"
               ref="form"
               label-width="120px"
               :disabled="method=='view'"
               @keyup.enter.native="handleSubmitForm"
               @submit.native.prevent
      >
        <el-row :gutter="15">
          <el-col :span="24">
            <el-form-item label="名称"
                          prop="name"
                          :rules="[{required: true, message:'名称不能为空', trigger:'blur'}]"
            >
              <el-input v-model="form.name" placeholder="请填写名称"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="监听器类型"
                          prop="listenerType"
                          :rules="[{required: true, message:'监听器类型不能为空', trigger:'blur'}]"
            >
              <el-radio-group v-model="form.listenerType" @change="$set(form, 'event', undefined)">
                <el-radio :label="1">执行监听器</el-radio>
                <el-radio :label="2">任务监听器</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="事件"
                          prop="event"
                          :rules="[{required: true, message:'事件不能为空', trigger:'blur'}]"
            >
              <el-select v-model="form.event" placeholder="请选择">
                <el-option v-for="item in events"
                           :key="item.value"
                           :label="item.label"
                           :value="item.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="值类型"
                          prop="valueType"
                          :rules="[{required: true, message:'值类型不能为空', trigger:'blur'}]"
            >
              <el-radio-group v-model="form.valueType">
                <el-radio :label="1">类</el-radio>
                <el-radio :label="2">表达式</el-radio>
                <el-radio :label="3">委托表达式</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item :label="{'1':'类', '2':'表达式', '3':'委托表达式'}[form.valueType]"
                          prop="value"
                          :rules="[{required: true, message:'值不能为空', trigger:'blur'}]"
            >
              <el-input v-model="form.value" placeholder="请填写值"/>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button size="small"
                   @click="open = false"
        >关闭</el-button>
        <el-button v-if="method != 'view'"
                   size="small"
                   type="primary"
                   @click="handleSubmitForm"
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
import { listListener, delListener, editListener, addListener, getListener } from '@/api/flowable/extension/listener'
export default {
  data () {
    return {
      queryParams: {
        current: 1,
        size: 10,
        name: undefined
      },
      showSearch: true,
      ids: [],
      single: true,
      multiple: true,
      dataList: [],
      total: 0,
      loading: false,
      title: '',
      method: '',
      open: false,
      valueLabel: '类',
      events: [],
      form: {}
    }
  },
  watch: {
    'form.listenerType' (n) {
      if (n === 1) {
        this.events = [
          {label: 'start', value: 'start'},
          {label: 'take', value: 'take'},
          {label: 'end', value: 'end'}
        ]
      } else {
        this.events = [
          {label: 'start', value: 'start'},
          {label: 'assignment', value: 'assignment'},
          {label: 'complete', value: 'complete'},
          {label: 'delete', value: 'delete'}
        ]
      }
    }
  },
  created () {
    this.getList()
  },
  methods: {
    /** 查询列表 */
    getList () {
      this.loading = true
      listListener(this.queryParams).then(response => {
        this.dataList = response.data
        this.total = response.total
        this.loading = false
      })
    },
    /** 表单重置,主要清除参数配置对话框缓存 */
    reset () {
      this.form = {
        id: undefined,
        name: undefined,
        listenerType: 1,
        event: undefined,
        valueType: 1,
        value: undefined
      }
    },
    /** 处理搜索按钮操作 */
    handleQuery () {
      this.queryParams.current = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery () {
      this.resetForm("queryForm")
    },
    /** 处理多选框选中数据 */
    handleSelectionChange (selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    /** 处理新增 */
    handleAdd () {
      this.reset()
      this.title = '添加监听器'
      this.method = 'add'
      this.open = true
    },
    /** 处理修改 */
    handleEdit (row) {
      const id = row.id || this.ids
      getListener(id).then(response => {
        this.form = response.data
        this.title = '修改监听器'
        this.method = 'edit'
        this.open = true
      })
    },
    /** 处理查看 */
    handleView (row) {
      const id = row.id || this.ids
      getListener(id).then(response => {
        this.form = response.data
        this.title = '查看监听器'
        this.method = 'view'
        this.open = true
      })
    },
    /** 处理删除 */
    handleDel (row) {
      const ids = row.id || this.ids
      this.$confirm('是否确认删除所选项编号为"' + ids + '"的数据项?', "警告", {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        delListener(ids).then(response => {
          this.loading = false
          this.msgSuccess("删除成功")
          this.getList()
        })
      }).catch(() => {})
    },
    /** 表单提交 */
    handleSubmitForm () {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          if (this.method == 'edit') {
            editListener(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("修改成功")
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addListener(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("新增成功")
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          }
        }
      })
    }
  }
}
</script>
