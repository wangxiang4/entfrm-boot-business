package com.entfrm.biz.workflow.config;

import com.entfrm.biz.workflow.parser.factory.WorkflowActivityBehaviorFactory;
import org.flowable.spring.SpringProcessEngineConfiguration;
import org.flowable.spring.boot.EngineConfigurationConfigurer;
import org.flowable.spring.boot.FlowableProperties;
import org.flowable.ui.common.properties.FlowableCommonAppProperties;
import org.flowable.ui.modeler.properties.FlowableModelerAppProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;


/**
 *<p>
 * Flowable-6.4配置
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
@Configuration
@EnableConfigurationProperties(FlowableProperties.class)
public class FlowableConfig implements EngineConfigurationConfigurer<SpringProcessEngineConfiguration> {

    @Override
    public void configure(SpringProcessEngineConfiguration engineConfiguration) {

        // 流程图字体设置
        engineConfiguration.setActivityFontName("华文细黑");
        engineConfiguration.setAnnotationFontName("华文细黑");
        engineConfiguration.setLabelFontName("华文细黑");

        // 激活定时任务Job
        engineConfiguration.setAsyncExecutorActivate(true);
        engineConfiguration.setDatabaseSchemaUpdate("true");

        // 邮箱配置
        engineConfiguration.setMailServerHost("smtp.qq.com");
        engineConfiguration.setMailServerPort(465);
        engineConfiguration.setMailServerDefaultFrom("1827945911@qq.com");
        engineConfiguration.setMailServerUsername("1827945911@qq.com");
        engineConfiguration.setMailServerPassword("skvhlkhrartadjgc");
        engineConfiguration.setMailServerUseSSL(true);

        // 配置工作流活动行为工厂
        engineConfiguration.setActivityBehaviorFactory(new WorkflowActivityBehaviorFactory());

    }

    @Bean
    public FlowableModelerAppProperties flowableModelerAppProperties() {
        return new FlowableModelerAppProperties();
    }

    @Bean
    @Primary
    public FlowableCommonAppProperties flowableCommonAppProperties() {
        FlowableCommonAppProperties flowableCommonAppProperties = new FlowableCommonAppProperties();
        // 设置ui模型用户认值地址,具体一般不用,但是必须要设置,所以可以随便设置,绕过校验机制
        flowableCommonAppProperties.setIdmUrl("http://localhost:0000");
        return flowableCommonAppProperties;
    }

}
