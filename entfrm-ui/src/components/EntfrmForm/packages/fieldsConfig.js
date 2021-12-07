export default [
  {
    title: '基础字段',
    list: [{
      type: 'input',
      label: '单行文本',
      icon: 'icon-input',
      span: 24,
      display: true
    }, {
      type: 'textarea',
      label: '多行文本',
      icon: 'icon-textarea',
      span: 24,
      display: true
    }, {
      type: 'number',
      label: '计数器',
      icon: 'icon-number',
      controls: true,
      span: 24,
      display: true,
    }, {
      type: 'radio',
      label: '单选框组',
      icon: 'icon-radio',
      dicData: [
        {label: '选项一', value: '0'},
        {label: '选项二', value: '1'},
        {label: '选项三', value: '2'},
      ],
      span: 24,
      display: true,
      dicOption: 'static',
      props: {
        label: 'label',
        value: 'value'
      }
    }, {
      type: 'checkbox',
      label: '多选框组',
      icon: 'icon-checkbox',
      dicData: [
        {label: '选项一', value: '0'},
        {label: '选项二', value: '1'},
        {label: '选项三', value: '2'},
      ],
      span: 24,
      display: true,
      dicOption: 'static',
      props: {
        label: 'label',
        value: 'value'
      }
    }, {
      type: 'time',
      label: '时间选择器',
      icon: 'icon-time',
      span: 24,
      display: true,
      format: 'HH:mm:ss',
      valueFormat: 'HH:mm:ss'
    }, {
      type: 'date',
      label: '日期选择器',
      icon: 'icon-date',
      span: 24,
      display: true,
      format: 'yyyy-MM-dd',
      valueFormat: 'yyyy-MM-dd'
    }, {
      type: 'rate',
      label: '评分',
      icon: 'icon-star',
      span: 24,
      display: true,
      max: 5,
      value: 0,
      texts: ['极差', '失望', '一般', '满意', '惊喜'],
      colors: ['#99A9BF', '#F7BA2A', '#FF9900'],
    }, {
      type: 'color',
      label: '颜色选择器',
      icon: 'icon-color',
      span: 24,
      display: true
    }, {
      type: 'select',
      label: '下拉选择器',
      icon: 'icon-select',
      dicData: [
        {label: '选项一', value: '0'},
        {label: '选项二', value: '1'},
        {label: '选项三', value: '2'},
      ],
      // 用于做级联配置
      cascaderItem: [],
      span: 24,
      display: true,
      dicOption: 'static',
      props: {
        label: 'label',
        value: 'value'
      }
    }, {
      type: 'switch',
      label: '开关',
      icon: 'icon-switch',
      span: 24,
      display: true,
      value: '0',
      dicData: [{label: '', value: '0'}, {label: '', value: '1'}]
    }, {
      type: 'slider',
      label: '滑块',
      icon: 'icon-slider',
      span: 24,
      display: true,
      min: 0,
      max: 10
    }]

  }
]
