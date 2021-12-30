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
        <el-input v-model="queryParams.name"
                  placeholder="名称"
                  clearable
        />
      </el-form-item>
      <el-form-item prop="code">
        <el-input size="small"
                  v-model="queryParams.code"
                  placeholder="编码"
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
                   @click="handleResetQuery"
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
                   @click="handleEdit"
                   :disabled="single"
        >修改</el-button>
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
      <el-table-column prop="code" label="编码"/>
      <el-table-column prop="sort" label="排序"/>
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
               :rules="formValidateRule"
               ref="form"
               label-width="120px"
               :disabled="method=='view'"
               @keyup.enter.native="handleSubmitForm"
               @submit.native.prevent
      >
        <el-row :gutter="15">
          <el-col :span="24">
            <el-form-item label="名称" prop="name">
              <el-input v-model="form.name" placeholder="请填写名称"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="编码" prop="code">
              <el-input v-model="form.code"
                        :readonly="handleValidateDefaultButton(form.code)"
                        placeholder="请输入按钮编码"
              />
            </el-form-item>
            <el-form-item>
              <div class="tip">
                <p>
                  注意：按钮编码不能重复，系统按钮以_flow_开头，自定义按钮不能以_flow_开头。
                  系统按钮和自定义按钮的区别是，系统按钮是绑定具体的action进行提交，如果你定义了系统按钮，必须在代码中实现对应的action方法。
                  自定义按钮无需在代码中添加action方法，触发自定义按钮时调用的是【同意】按钮对应的action，并把该按钮对应的code设置为true、其他自定义按钮对应的code设置为false作为流程变量进行提交。
                </p>
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="排序" prop="sort">
              <el-input-number v-model="form.sort" placeholder="请填写排序"/>
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
import { listButton, delButton, getButton, editButton, addButton } from '@/api/flowable/extension/button'
export default {
  name: 'Button',
  data () {
    return {
      queryParams: {
        current: 1,
        size: 10,
        name: undefined,
        code: undefined
      },
      showSearch: true,
      ids: [],
      single: true,
      multiple: true,
      dataList: [],
      total: 0,
      loading: false,
      title: '',
      open: false,
      form: {},
      method: ''
    }
  },
  computed: {
    formValidateRule () {
      const validatePass = (rule, value, callback) => {
        if (this.method == 'add' && this.handleValidateDefaultButton(value)) {
          callback(new Error('请勿使用系统预设编码!'))
        } else {
          callback()
        }
      }
      return {
        name: [
          {required: true, message: '名称不能为空', trigger: 'blur'}
        ],
        code: [
          {required: true, message: '编码不能为空', trigger: 'blur'},
          {validator: validatePass, trigger: 'blur'}
        ],
        sort: [
          {required: true, message: '排序不能为空', trigger: 'blur'}
        ]
      }
    }
  },
  created(){
    this.getList()
  },
  methods: {
    /** 获取查询列表 */
    getList () {
      this.loading = true
      listButton(this.queryParams).then(response => {
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
        code: undefined,
        sort: 0
      }
    },
    /** 处理搜索按钮操作 */
    handleQuery () {
      this.queryParams.current = 1
      this.getList()
    },
    /** 处理重置按钮操作 */
    handleResetQuery () {
      this.resetForm("queryForm")
    },
    /** 处理多选框选中数据 */
    handleSelectionChange (selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    /** 处理新增按钮操作 */
    handleAdd () {
      this.reset()
      this.title = '添加常用按钮'
      this.method = 'add'
      this.open = true
    },
    /** 处理修改按钮操作 */
    handleEdit (row) {
      const id = row.id || this.ids
      getButton(id).then(response => {
        this.form = response.data
        this.title = '修改常用按钮'
        this.method = 'edit'
        this.open = true
      })
    },
    /** 处理查看按钮操作 */
    handleView (row) {
      const id = row.id || this.ids
      getButton(id).then(response => {
        this.form = response.data
        this.title = "查看常用按钮"
        this.method = 'view'
        this.open = true
      })
    },
    /** 处理验证内置默认按钮 */
    handleValidateDefaultButton (code) {
      let defaultButtons = [
        '_flow_save',
        '_flow_agree',
        '_flow_reject',
        '_flow_back',
        '_flow_add_multi_instance',
        '_flow_del_multi_instance',
        '_flow_transfer',
        '_flow_delegate',
        '_flow_stop',
        '_flow_print'
      ]
      return defaultButtons.filter((val) => {
        return code === val
      }).length > 0
    },
    /** 处理删除按钮操作 */
    handleDel (row) {
      if (this.handleValidateDefaultButton(row.code)) {
        this.$message.error(`不能删除预设按钮【${row.name}】`)
        return
      }
      const ids = row.id || this.ids
      this.$confirm('是否确认删除所选项编号为"' + ids + '"的数据项?', "警告", {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        delButton(ids).then(response => {
          this.loading = false
          this.msgSuccess("删除成功")
          this.getList()
        })
      }).catch(() => {})
    },
    /** 处理表单提交 */
    handleSubmitForm () {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.method == 'edit') {
            editButton(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("修改成功")
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addButton(this.form).then(response => {
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
