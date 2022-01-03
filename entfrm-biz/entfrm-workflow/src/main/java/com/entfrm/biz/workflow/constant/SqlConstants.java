package com.entfrm.biz.workflow.constant;

/**
 *<p>
 * sql脚本
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/3
 */
public interface SqlConstants {

    String QUERY_ACT_HI_COMMENT= "select * from ACT_HI_COMMENT where TYPE_ like ? and TASK_ID_ = ? order by TIME_ desc";

    String QUERY_USER = "select id, user_name userName, nick_name nickName, password, dept_id deptId, status from sys_user where id = ?";

}
