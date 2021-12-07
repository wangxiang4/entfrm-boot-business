package com.entfrm.auth.config;

import com.entfrm.auth.handler.EntfrmWebResponseExceptionTranslator;
import com.entfrm.auth.service.EntfrmUserDetailService;
import com.entfrm.base.config.GlobalConfig;
import com.entfrm.security.entity.EntfrmUser;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.oauth2.common.DefaultOAuth2AccessToken;
import org.springframework.security.oauth2.config.annotation.configurers.ClientDetailsServiceConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerEndpointsConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.ClientDetailsService;
import org.springframework.security.oauth2.provider.client.JdbcClientDetailsService;
import org.springframework.security.oauth2.provider.token.TokenEnhancer;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.security.oauth2.provider.token.store.InMemoryTokenStore;
import org.springframework.security.oauth2.provider.token.store.redis.RedisTokenStore;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;

/**
 * @author yong
 * @date 2020/3/10
 * @description TokenStore
 */
@Configuration
@AllArgsConstructor
@EnableAuthorizationServer
public class AuthorizationServerConfig extends AuthorizationServerConfigurerAdapter {

    private final AuthenticationManager authenticationManager;
    private final EntfrmUserDetailService userDetailService;
    private final RedisConnectionFactory redisConnectionFactory;
    private final DataSource dataSource;

    @Override
    public void configure(AuthorizationServerEndpointsConfigurer endpoints) {

        endpoints.authenticationManager(authenticationManager)
                .tokenStore(tokenStore())
                .tokenEnhancer(tokenEnhancer())
                .userDetailsService(userDetailService)
                .allowedTokenEndpointRequestMethods(HttpMethod.GET, HttpMethod.POST)//允许 GET、POST 请求获取 token，即访问端点：oauth/token
                .reuseRefreshTokens(true)
                .exceptionTranslator(new EntfrmWebResponseExceptionTranslator());//oauth2登录异常处理
    }

    @Bean
    public TokenStore tokenStore() {
        TokenStore tokenStore = null;
        if(GlobalConfig.isRedisSwitch()){
            tokenStore = new RedisTokenStore(redisConnectionFactory);
            ((RedisTokenStore) tokenStore).setPrefix("entfrm_");
        }else {
            tokenStore = new InMemoryTokenStore();
        }

        return tokenStore;
    }

    /**
     * token增强
     *
     * @return TokenEnhancer
     */
    @Bean
    public TokenEnhancer tokenEnhancer() {
        return (accessToken, authentication) -> {
            Map<String, Object> info = new HashMap<>(1);
            EntfrmUser entfrmUser = (EntfrmUser) authentication.getUserAuthentication().getPrincipal();
            info.put("user_id", entfrmUser.getId());
            info.put("username", entfrmUser.getUsername());
            info.put("dept_id", entfrmUser.getDeptId());
            info.put("license", "entfrm");
            ((DefaultOAuth2AccessToken) accessToken).setAdditionalInformation(info);
            return accessToken;
        };
    }

    @Override
    public void configure(AuthorizationServerSecurityConfigurer oauthServer) {
        oauthServer
                .checkTokenAccess("isAuthenticated()")
                .allowFormAuthenticationForClients();//允许表单认证
    }

    @Override
    public void configure(ClientDetailsServiceConfigurer clients) throws Exception {
        clients.withClientDetails(clientDetails());
    }

    @Bean
    public ClientDetailsService clientDetails() {
        return new JdbcClientDetailsService(dataSource);//客户端配置 使用jdbc数据库存储
    }
}
