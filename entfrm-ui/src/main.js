import Vue from 'vue'

import Cookies from 'js-cookie'

import 'normalize.css/normalize.css' // a modern alternative to CSS resets

import Element from 'element-ui'
import './assets/styles/element-variables.scss'

import '@/assets/styles/index.scss' // global css
import '@/assets/styles/entfrm.scss' // entfrm css
import App from './App'
import store from './store'
import router from './router'
import permission from './directive/permission'

import './assets/icons' // icon
import './permission' // permission control
import {getDicts} from "@/api/system/dictData";
import {getByKey} from "@/api/system/config";
import validator from '@/utils/validator'
import {
  parseTime,
  resetForm,
  addDateRange,
  selectDictLabel,
  selectDictLabels,
  download,
  handleTree,
  vGet
} from "@/utils/entfrm";
import Pagination from "@/components/Pagination";
// 自定义表格工具扩展
import RightToolbar from "@/components/RightToolbar"
// 表单设计器
import Avue from '@smallwei/avue'
import '@smallwei/avue/lib/index.css'
// 引入表格功能相对比较齐全的组件vxeTable
import XEUtils from 'xe-utils'
// 按需导入 vxeTable
import {
  // 核心
  VXETable,

  // 功能模块
  Icon,
  Filter,
  Menu,
  Edit,
  Export,
  Keyboard,
  Validator,
  Header,
  Footer,

  // 可选组件
  Column,
  Colgroup,
  Grid,
  Toolbar,
  Pager,
  Checkbox,
  CheckboxGroup,
  Radio,
  RadioGroup,
  RadioButton,
  Input,
  Textarea,
  Button,
  Modal,
  Tooltip,
  Form,
  FormItem,
  FormGather,
  Select,
  Optgroup,
  Option,
  Switch,
  List,
  Pulldown,

  // 表格
  Table
} from 'vxe-table'
import zhCN from 'vxe-table/lib/locale/lang/zh-CN'
// 按需加载的方式默认是不带国际化的，自定义国际化需要自行解析占位符 '{0}'，例如：
VXETable.setup({
  size: Cookies.get('size') || 'medium', // set default size
  i18n: (key, args) => XEUtils.toFormatString(XEUtils.get(zhCN, key), args)
})

// 插件可拔插式枇杷表单设计器
import request from './utils/request'
import LoquatFormDesign from 'loquat-form-design'
import 'loquat-form-design/lib/loquat-form-design.css'
Vue.use(LoquatFormDesign, { axiosInstance: request })

// 全局方法挂载
Vue.prototype.getDicts = getDicts
Vue.prototype.getByKey = getByKey
Vue.prototype.parseTime = parseTime
Vue.prototype.resetForm = resetForm
Vue.prototype.addDateRange = addDateRange
Vue.prototype.selectDictLabel = selectDictLabel
Vue.prototype.selectDictLabels = selectDictLabels
Vue.prototype.download = download
Vue.prototype.handleTree = handleTree
Vue.prototype.validator = validator
Vue.prototype.vGet = vGet

Vue.prototype.msgSuccess = function (msg) {
  this.$message({ showClose: true, message: msg, type: "success" });
}

Vue.prototype.msgError = function (msg) {
  this.$message({ showClose: true, message: msg, type: "error" });
}

Vue.prototype.msgInfo = function (msg) {
  this.$message.info(msg);
}

// 全局组件挂载
Vue.component('Pagination', Pagination)
Vue.component('RightToolbar', RightToolbar)

Vue.use(permission)

//表单设计器
Vue.use(Avue)

// 表格功能
Vue.use(Header)
   .use(Footer)
   .use(Icon)
   .use(Filter)
   .use(Edit)
   .use(Menu)
   .use(Export)
   .use(Keyboard)
   .use(Validator)

   // 可选组件
   .use(Column)
   .use(Colgroup)
   .use(Grid)
   .use(Toolbar)
   .use(Pager)
   .use(Checkbox)
   .use(CheckboxGroup)
   .use(Radio)
   .use(RadioGroup)
   .use(RadioButton)
   .use(Input)
   .use(Textarea)
   .use(Button)
   .use(Modal)
   .use(Tooltip)
   .use(Form)
   .use(FormItem)
   .use(FormGather)
   .use(Select)
   .use(Optgroup)
   .use(Option)
   .use(Switch)
   .use(List)
   .use(Pulldown)

   // 安装表格
   .use(Table)

/**
 * If you don't want to use mock-server
 * you want to use MockJs for mock api
 * you can execute: mockXHR()
 *
 * Currently MockJs will be used in the production environment,
 * please remove it before going online! ! !
 */
Vue.use(Element, {
  size: Cookies.get('size') || 'medium' // set element-ui default size
})

Vue.config.productionTip = false

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
