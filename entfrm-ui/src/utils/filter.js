/**
 * @program: entfrm-ui
 *
 * @description: vue过滤器
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2022/1/15
 */

import Vue from 'vue'
import { parseTime } from './entfrm'

Vue.filter('formatDate', function (value, formatString) {
  formatString = formatString || '{y}-{m}-{d} {h}:{i}:{s}'
  if (value) {
    return parseTime(value, formatString)
  } else {
    return '--'
  }
})
