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

    String QUERY_USER_BY_ID = "select id, user_name userName, nick_name nickName, password, dept_id deptId, status from sys_user where id = ?";

    String QUERY_USER_BY_DEPT_ID = "select id, user_name userName, nick_name nickName, password, dept_id deptId, status from sys_user where dept_id = ?";

    String QUERY_USER_BY_ROLE_ID = "select distinct id, user_name userName, nick_name nickName, password, dept_id deptId, status from sys_user a, sys_user_role b where a.id = b.user_id and b.role_id = ?";

}
