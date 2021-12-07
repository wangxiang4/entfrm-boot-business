/**
 * @program: entfrm
 *
 * @description: el-通用验证器
 *
 * @author: entfrm开发团队-王翔
 *
 * @create: 2021-06-22
 **/
import {
  isNumber
} from './validate'

const isNumberValidator = (rule, value, callback) => {
  if (value && !isNumber(value)) {
    callback(new Error('请输入数字!'))
  } else {
    callback()
  }
}

export default {isNumberValidator}
