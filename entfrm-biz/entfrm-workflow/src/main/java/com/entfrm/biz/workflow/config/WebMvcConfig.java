package com.entfrm.biz.workflow.config;

import com.entfrm.biz.workflow.interceptor.ModelHandlerInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
/**
 *<p>
 * MVC配置
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/6
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new ModelHandlerInterceptor()).addPathPatterns("/app/rest/models/**");
    }

}

