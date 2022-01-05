package com.entfrm.biz.workflow.interceptor;

import com.entfrm.base.util.StrUtil;
import com.entfrm.security.entity.EntfrmUser;
import com.entfrm.security.util.SecurityUtil;
import org.flowable.idm.api.User;
import org.flowable.idm.engine.impl.persistence.entity.UserEntityImpl;
import org.flowable.ui.common.security.SecurityUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *<p>
 * 请求拦截器
 * 动态设置flowable-ui-model当前登录用户
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/6
 */
public class ModelHandlerInterceptor implements HandlerInterceptor {

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String servletPath = request.getServletPath();
		EntfrmUser entfrmUser = SecurityUtil.getUser();
		if (servletPath.startsWith("/app") || servletPath.startsWith("/idm")) {
			User currentUserObject = SecurityUtils.getCurrentUserObject();
			if (currentUserObject == null || StrUtil.isBlank(currentUserObject.getId())) {
				User user = new UserEntityImpl();
				user.setId(entfrmUser.getId() + "");
				user.setFirstName(entfrmUser.getUsername());
				user.setLastName("");
				SecurityUtils.assumeUser(user);
			}
		}
		return true;
	}

}
