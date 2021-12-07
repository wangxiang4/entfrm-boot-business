package com.entfrm.swagger.config;

import cn.hutool.core.collection.ListUtil;
import com.entfrm.base.config.GlobalConfig;
import io.swagger.annotations.ApiOperation;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.OAuthBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.*;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.contexts.SecurityContext;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2WebMvc;

import java.util.ArrayList;
import java.util.List;

/**
 * @author entfrm
 * @date 2020/4/14
 * @description swagger 配置
 */
@Configuration
@EnableSwagger2WebMvc
public class SwaggerConfig {

    @Bean
    public Docket productApi() {
        //schema
        List<GrantType> grantTypes = new ArrayList<>();
        //密码模式
        ResourceOwnerPasswordCredentialsGrant resourceOwnerPasswordCredentialsGrant = new ResourceOwnerPasswordCredentialsGrant("/dev/oauth/token?entfrm=" + GlobalConfig.getVersion());
        grantTypes.add(resourceOwnerPasswordCredentialsGrant);
        //context
        //scope方位
        List<AuthorizationScope> scopes = new ArrayList<>();
        scopes.add(new AuthorizationScope("read", "read resources"));
        scopes.add(new AuthorizationScope("write", "write resources"));
        scopes.add(new AuthorizationScope("reads", "read all resources"));
        scopes.add(new AuthorizationScope("writes", "write all resources"));

        OAuth oAuth = new OAuthBuilder().name("oauth2")
                .grantTypes(grantTypes).build();

        SecurityReference securityReference = new SecurityReference("oauth2", scopes.toArray(new AuthorizationScope[]{}));
        SecurityContext securityContext = new SecurityContext(ListUtil.toList(securityReference), PathSelectors.any());
        //schemas
        List<SecurityScheme> securitySchemes = ListUtil.toList(oAuth);
        //securyContext
        List<SecurityContext> securityContexts = ListUtil.toList(securityContext);
        return new Docket(DocumentationType.SWAGGER_2)
                .pathMapping("/dev")
                .select()
                .apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))
                .paths(PathSelectors.any())
                .build()
                .securityContexts(securityContexts)
                .securitySchemes(securitySchemes)
                .apiInfo(apiInfo());


    }

    /**
     * 添加摘要信息
     */
    private ApiInfo apiInfo() {
        // 用ApiInfoBuilder进行定制
        return new ApiInfoBuilder()
                // 设置标题
                .title(GlobalConfig.getName())
                // 描述
                .description(GlobalConfig.getName() + "接口文档")
                // 作者信息
                .contact(new Contact("entfrm", "http://www.entfrm.com/", "1029861695@qq.com"))
                // 版本
                .version("版本号:" + GlobalConfig.getVersion())
                .build();
    }
}
