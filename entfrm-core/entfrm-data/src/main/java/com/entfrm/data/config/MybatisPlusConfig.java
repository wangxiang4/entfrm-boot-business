package com.entfrm.data.config;

import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 *<p>
 * mybatis-plus配置
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/30
 */
@Configuration
@MapperScan("com.entfrm.biz.*.mapper")
public class MybatisPlusConfig {


	/**
	 * 分页插件
	 *
	 * @return PaginationInterceptor
	 */
	@Bean
	@ConditionalOnMissingBean
	public MybatisPlusInterceptor paginationInterceptor() {
		MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
		interceptor.addInnerInterceptor(new PaginationInnerInterceptor());
		return interceptor;
	}

	/**
	 * 数据权限插件
	 *
	 * @param dataSource 数据源
	 * @return DataScopeInterceptor
	 */
//	@Bean
//	@ConditionalOnMissingBean
//	public DataScopeInterceptor dataScopeInterceptor(DataSource dataSource) {
//		return new DataScopeInterceptor(dataSource);
//	}

}
