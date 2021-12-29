<template>
  <div class="app-container">
    <el-form  :model="queryParams"
              :inline="true"
              v-show="showSearch"
              ref="queryForm"
              size="small"
              @keyup.enter.native="handleQuery()"
              @submit.native.prevent>
      <el-form-item prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="名称"
          clearable/>
      </el-form-item>
      <el-form-item>
        <el-button
          type="primary"
          icon="el-icon-search"
          size="mini"
          @click="handleQuery">搜索
        </el-button>
        <el-button
          icon="el-icon-refresh-right"
          size="mini"
          @click="resetQuery">重置
        </el-button>
      </el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          size="mini"
          icon="el-icon-plus"
          @click="add">新建
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          size="mini"
          icon="el-icon-edit-outline"
          @click="edit"
          :disabled="single">修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          size="mini"
          icon="el-icon-delete"
          @click="del"
          :disabled="multiple">删除
        </el-button>
      </el-col>
      <div class="top-right-btn">
        <el-tooltip class="item" effect="dark" content="刷新" placement="top">
          <el-button size="mini" circle icon="el-icon-refresh" @click="handleQuery"/>
        </el-tooltip>
        <el-tooltip class="item" effect="dark" :content="showSearch ? '隐藏搜索' : '显示搜索'" placement="top">
          <el-button size="mini" circle icon="el-icon-search" @click="showSearch=!showSearch"/>
        </el-tooltip>
      </div>
    </el-row>
    <el-table
      v-loading="loading"
      :data="dataList"
      @selection-change="handleSelectionChange">
      <el-table-column type="selection" align="center" width="50"/>
      <el-table-column prop="name" label="名称"/>
      <el-table-column prop="expression" label="表达式"/>
      <el-table-column prop="remarks" label="备注"/>
      <el-table-column align="center" width="200" label="操作">
        <template slot-scope="scope">
          <el-button
            type="text"
            icon="el-icon-view"
            size="mini"
            @click="view(scope.row.id)">查看
          </el-button>
          <el-button
            type="text"
            icon="el-icon-edit"
            size="mini"
            @click="edit(scope.row)">修改
          </el-button>
          <el-button
            type="text"
            size="mini"
            icon="el-icon-delete"
            @click="del(scope.row)">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.current"
      :limit.sync="queryParams.size"
      @pagination="getList"/>
    <!-- 弹窗, 新增 / 修改 -->
    <condition-form  ref="conditionForm" @refreshDataList="getList"/>
  </div>
</template>

<script>
  import conditionForm from './conditionForm'
  import {listCondition,delCondition} from "@/api/flowable/extension/condition";
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
        loading: false
      }
    },
    components: {
      conditionForm
    },
    created(){
      this.getList();
    },
    methods: {
      // 查询列表
      getList() {
        this.loading = true;
        listCondition(this.queryParams).then(response => {
          this.dataList = response.data;
          this.total = response.total;
          this.loading = false;
        });
      },
      // 搜索按钮操作
      handleQuery() {
        this.queryParams.current = 1;
        this.getList();
      },
      // 重置按钮操作
      resetQuery() {
        this.resetForm("queryForm");
      },
      // 多选框选中数据
      handleSelectionChange(selection) {
        this.ids = selection.map(item => item.id)
        this.single = selection.length != 1
        this.multiple = !selection.length
      },
      // 新增
      add() {
        this.$refs.conditionForm.init('add', undefined)
      },
      // 修改
      edit(row) {
        const id = row.id || this.ids
        this.$refs.conditionForm.init('edit', id)
      },
      // 查看
      view(id) {
        this.$refs.conditionForm.init('view', id)
      },
      // 删除
      del(row) {
        const ids = row.id || this.ids
        this.$confirm('是否确认删除所选项编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.loading = true
          delCondition(ids).then(response => {
            this.loading = false
            this.msgSuccess("删除成功");
            this.getList();
          })
        })
      }
    }
  }
</script>
