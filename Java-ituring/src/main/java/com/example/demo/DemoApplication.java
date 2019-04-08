package com.example.demo;

import com.example.demo.shiro.CaptchaFormAuthenticationFilter;
import com.example.demo.shiro.MyShiroRealm;
import com.example.demo.web.AfterShiroFilter;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.filter.authc.LogoutFilter;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.filter.DelegatingFilterProxy;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import java.util.LinkedHashMap;
import java.util.Map;

@EnableTransactionManagement
@SpringBootApplication
@MapperScan({"com.example.demo.dao"})
public class DemoApplication extends SpringBootServletInitializer implements WebApplicationInitializer {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(DemoApplication.class);
	}


	@Bean
	public FilterRegistrationBean delegatingFilterProxy(){
		FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
		DelegatingFilterProxy proxy = new DelegatingFilterProxy();
		proxy.setTargetFilterLifecycle(true);
		proxy.setTargetBeanName("shiroFilter");
		filterRegistrationBean.setFilter(proxy);
		filterRegistrationBean.setOrder(Integer.MAX_VALUE-1);
		return filterRegistrationBean;
	}

	@Bean
	public MyShiroRealm myShiroRealm(){
		return new MyShiroRealm();
	}
/*
    @Bean
    public CaptchaFormAuthenticationFilter captchaFormAuthenticationFilter(){
		CaptchaFormAuthenticationFilter captchaFormAuthenticationFilter = new CaptchaFormAuthenticationFilter();
		captchaFormAuthenticationFilter.setUsernameParam("Email");
		captchaFormAuthenticationFilter.setPasswordParam("Password");
		captchaFormAuthenticationFilter.setRememberMeParam("RememberMe");
		captchaFormAuthenticationFilter.setCaptchaParam("__RequestVerificationToken");
		captchaFormAuthenticationFilter.setCaptchaSessionAttributeName("loginToken");
        return new CaptchaFormAuthenticationFilter();
        //在里面设置属性没有 哪个bean更早建立的问题？
        //要么在下面shiroFilterFactoryBean设置 要么在CaptchaFormAuthenticationFilter中硬编码
    }
    */


	@Bean(name = "shiroFilter")
	public ShiroFilterFactoryBean shiroFilterFactoryBean() {

		ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
		shiroFilterFactoryBean.setSecurityManager(securityManager());

		CaptchaFormAuthenticationFilter captchaFormAuthenticationFilter = new CaptchaFormAuthenticationFilter();
		captchaFormAuthenticationFilter.setUsernameParam("Email");
		captchaFormAuthenticationFilter.setPasswordParam("Password");
		captchaFormAuthenticationFilter.setRememberMeParam("RememberMe");
		captchaFormAuthenticationFilter.setCaptchaParam("__RequestVerificationToken");
		captchaFormAuthenticationFilter.setCaptchaSessionAttributeName("loginToken");

		LogoutFilter logoutFilter = new LogoutFilter();
		logoutFilter.setRedirectUrl("/index");

		Map<String, Filter> filterMap = shiroFilterFactoryBean.getFilters();
		filterMap.put("authc", captchaFormAuthenticationFilter);
		filterMap.put("logout",logoutFilter);
		shiroFilterFactoryBean.setFilters(filterMap);

		shiroFilterFactoryBean.setLoginUrl("/log-in");
		shiroFilterFactoryBean.setSuccessUrl("/index");

		Map<String, String> filterChainDefinitionMap = new LinkedHashMap<>();
		filterChainDefinitionMap.put("/", "anon");
		filterChainDefinitionMap.put("/index", "anon");
		filterChainDefinitionMap.put("/book/**", "user");
		filterChainDefinitionMap.put("/tag/**", "authc");
		filterChainDefinitionMap.put("/search", "anon");
		filterChainDefinitionMap.put("/menu/books", "anon");

		filterChainDefinitionMap.put("/user/**", "authc");
		filterChainDefinitionMap.put("/message", "authc");

		filterChainDefinitionMap.put("/space/**", "anon");

		filterChainDefinitionMap.put("/SmallAvatar/**", "anon");

		filterChainDefinitionMap.put("/account/**", "anon");

		filterChainDefinitionMap.put("/register/**", "anon");

		filterChainDefinitionMap.put("/captcha", "anon");

		filterChainDefinitionMap.put("/book/togglefav/**","anon");
		filterChainDefinitionMap.put("/book/togglevote/**","anon");
		filterChainDefinitionMap.put("/book/favvote/**","anon");

		filterChainDefinitionMap.put("/change-password","authc");

		filterChainDefinitionMap.put("upload","authc");

		filterChainDefinitionMap.put("space/**","anon");

		filterChainDefinitionMap.put("/user/toggleattendtion/**","anon");

		filterChainDefinitionMap.put("/user/following","authc");
		filterChainDefinitionMap.put("/user/followme","authc");
		filterChainDefinitionMap.put("/user/following/**","authc");
		//后面新加的url 这里有没有补上

		//shiro能一个名对应多个值 多个值也就是多个过滤器 好像是用逗号隔开

		filterChainDefinitionMap.put("/log-out", "logout");
		filterChainDefinitionMap.put("/log-in", "authc");
		filterChainDefinitionMap.put("/**","anon");//user authc?

		shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
		return shiroFilterFactoryBean;
	}

	@Bean
	public SecurityManager securityManager() {
		DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
		securityManager.setRealm(myShiroRealm());
		securityManager.setRememberMeManager(cookieRememberMeManager());
		return securityManager;
	}



	//cookie对象;
	@Bean
	public SimpleCookie rememberMeCookie() {//能设置rememberMe cookies到浏览器中 但是好像不起作用 rememberMe cookies似乎要结合过滤器才能起作用
		//这个参数是cookie的名称，对应前端的checkbox的name = rememberMe
		SimpleCookie simpleCookie = new SimpleCookie("RememberMe");

		//<!-- 记住我cookie生效时间30天 ,单位秒;-->
		simpleCookie.setMaxAge(2592000);
		return simpleCookie;
	}

	//cookie管理对象;
	@Bean
	public CookieRememberMeManager cookieRememberMeManager() {
		CookieRememberMeManager manager = new CookieRememberMeManager();
		manager.setCookie(rememberMeCookie());
		return manager;
	}//是有没有这个 在浏览器点击记住 都能存RememberMe的cookie
	@Bean
	public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
		return new LifecycleBeanPostProcessor();
	}

	@Bean
	public FilterRegistrationBean afterShiroFilter(){
		FilterRegistrationBean afterShiroFilter = new FilterRegistrationBean();
		afterShiroFilter.setFilter(new AfterShiroFilter());
		afterShiroFilter.addUrlPatterns("/*");
		afterShiroFilter.setOrder(Integer.MAX_VALUE);
		//afterShiroFilter.setDispatcherTypes(DispatcherType.REQUEST);//对于一个请求到视图的url会过滤两次 一次是url 第二次是视图的路径
		//设置成DispatcherType.REQUEST 第二次就不会有过滤 因为发到视图 是转发的
		return afterShiroFilter;
	}

}
