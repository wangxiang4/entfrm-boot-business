# entfrm-boot
## 开源不易，如果对您有帮助，请点右上角 “Star” 支持一下 谢谢！
### 平台简介    
entfrm开发平台，是一个以模块化为核心的无代码开发平台，是一个集PC和APP快速开发、系统管理、运维监控、开发工具、OAuth2授权、可视化数据源管理与数据构建、API动态生成与统计、工作流、智能表单设计、微服务骨架等全方位功能于一体的高效、稳定的快速开发平台。
平台采用Spring Boot 2.X 、Spring Security、Oauth2、Mybatis Plus、Activiti、uni-app等核心技术，前端基于vue-element-admin框架。
#### 官网地址：http://www.entfrm.com/
#### 文档地址：http://www.entfrm.com/doc
#### 应用市场：http://www.entfrm.com/market
###  entfrm官方交流群：871910881 345969668 (进群了解更多功能更新动态)
### 思维导图
![平台思维导图](https://images.gitee.com/uploads/images/2020/1212/202415_459da4c0_5254955.png "entfrm.png")
### APP效果

|  ![输入图片说明](https://images.gitee.com/uploads/images/2020/1212/202442_ec0111a4_5254955.jpeg "app-login.jpg") | ![输入图片说明](https://images.gitee.com/uploads/images/2020/1212/202455_d0ab78e7_5254955.jpeg "app-msg.jpg")  | ![输入图片说明](https://images.gitee.com/uploads/images/2020/1212/202511_54032a32_5254955.jpeg "app-my.jpg")  |
|---|---|---|

#### entfrm-app已可体验试用，扫描二维码注册体验

![体验二维码](https://images.gitee.com/uploads/images/2020/1212/202525_31711038_5254955.png "qrcode.png")

### 软件功能

#### 1.系统管理
 * 机构管理：配置系统组织机构，无限级树结构展现支持数据权限。

 * 角色管理：角色菜单权限分配、设置角色按机构进行数据范围权限划分。

 * 用户管理：用户是系统操作者，该功能主要完成系统用户配置。

 * 菜单管理：配置系统菜单，操作权限，按钮权限标识等。

 * 字典管理：对系统中经常使用的一些较为固定的数据进行维护。

 * 参数管理：对系统动态配置常用参数。

 * 快捷方式：添加顶部、首页快捷方式。

 * 文件管理：文件统一管理，集成阿里云、腾讯云、七牛等。

 * 终端管理：OAuth2 Password、授权码模式，灵活管理。

 * 数据维护：mysql数据库备份与还原。

#### 2.运维监控
 * 定时任务：在线（添加、修改、删除)任务调度包含执行结果日志。
 
 * 令牌管理：用户登录token管理。
 
 * 数据监控: 监视当前系统数据库连接池状态，可进行分析SQL找出系统性能瓶颈。

 * 缓存监控：redis缓存监控。

 * 服务监控: 监视当前系统CPU、内存、磁盘、堆栈等相关信息。

 * API监控：restful api 接口调用统计、可视化。

  日志监控

 * 登录日志：系统正常操作日志记录和查询；系统异常信息日志记录和查询。

 * 操作日志：系统登录日志记录查询包含登录异常。

#### 3.开发工具
 * 数据管理：Mysql、SQL Server、PostgreSQL等主流数据库在线管理、数据表管理（新建、修改、删除、查询）、数据源管理与数据转换。

 * 代码生成：支持单表、树表、左树右表代码生成。
 
 ----------------更多功能应用请移步应用市场----------------

 #### 4.消息系统
  * 消息模板：消息模板管理与审核。
  
  * 系统消息：包括系统通知、告警等。
  
  * 短信：短信平台集成。
  
  * 邮件：邮件集成。
  
#### 5.API引擎
 * 应用管理：应用新增、修改、删除、查看。
 
 * API设计：API在线设计、无代码开发，支持自定义。
 
 * API文档与测试：API文档生成与自动化测试。
 
 * API资源权限：API资源管理、权限控制。
 
 * API统计报表：API使用统计、图表展示。

#### 6.流程引擎（Activiti）
 * 模型管理：功能包括模型新增、查看、删除、模型设计、模型部署。
 
 * 流程定义：功能包括流程图查看、流程挂起与激活、流程删除。
 
 * 请假管理：功能包括请假新增、编辑、查看、删除、导出、提交。
 
 * 流程任务：功能包括流程审批、审批意见列表及流程追踪。
 
#### 7.表单引擎
 * 表单设计：表单快速设计。
 
 * 多终端支持：PC、Pad、手机多端适配。
 
 * 表单分享：表单一键分享。
 
 * 表单数据统计：手机填写的表单，支持列表和图表统计。 
 
 * uni-app示例与基础：提供uni-app实例，并集成表单功能。 
 
#### 8.数据引擎 
 * 可视化：快速配置，图表生成。
 
 * 大屏：图表编排，大屏显示。
 
 * 报表：报表设计。
 
#### 9.拓展插件
 
#### 10.分布式与微服务 
 
### 代码结构
~~~
entfrm-boot
|--entfrm-auth       Oauth2授权模块
|--entfrm-biz   业务模块
|----entfrm-monitor  运维监控模块
|----entfrm-system   系统管理模块
|----entfrm-toolkit  开发工具模块
|----entfrm-quartz   定时任务模块
|--entfrm-core  核心模块 
|----entfrm-base     核心基础模块
|----entfrm-data     核心数据模块
|----entfrm-log      核心日志模块
|----entfrm-security 核心安全模块
|----entfrm-swagger Swagger文档
|--entfrm-web       Web模块
~~~
### 在线演示

1. 地址：<http://demo.entfrm.com/> **（请不要更改用户entfrm的密码，谢谢！）**
2. 账号：entfrm
3. 密码：123456

### 使用说明

1. 配置环境（jdk1.8、maven3.x、mysql5.6及以上、redis3.2及以上）
2. 创建数据库
3. 初始化sql脚本：entfrm.sql
4. 导入项目到IntelliJ IDE中
5. 修改配置文件entfrm-boot/entfrm-web/src/main/resources/application.yml
    * redis 配置
    * datasource 数据源配置
6. 启动WebApplication
7. 启动entfrm-ui

### 演示效果
| ![输入图片说明](https://images.gitee.com/uploads/images/2020/1212/202902_59ada433_5254955.png "1.png") | ![输入图片说明](https://images.gitee.com/uploads/images/2020/1212/202914_c3bb3e4b_5254955.png "2.png") |
|---|---|
| ![输入图片说明](https://images.gitee.com/uploads/images/2020/1212/202928_947e17f6_5254955.png "3.png") | ![输入图片说明](https://images.gitee.com/uploads/images/2020/1212/202941_69d98d3e_5254955.png "4.png")  |
| ![输入图片说明](https://images.gitee.com/uploads/images/2020/1212/202954_2927fd17_5254955.png "5.png") | ![输入图片说明](https://images.gitee.com/uploads/images/2020/1212/203010_968f1f64_5254955.png "6.png") |
