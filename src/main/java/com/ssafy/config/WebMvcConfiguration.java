package com.ssafy.config;

import java.util.Arrays;
import java.util.List;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.ssafy.interceptor.ConfirmInterceptor;

@Configuration
@MapperScan(basePackages = {"com.ssafy.**.mapper"})
public class WebMvcConfiguration implements WebMvcConfigurer{
	private final List<String> patterns = Arrays.asList("/hotplace/**", "/plan/**", "/board/**");
	private final List<String> excludePatterns = Arrays.asList("/hotplace/list", "/hotplace/image/**", "/plan/mvplanlist", "/board/list", "/board/view");
	private ConfirmInterceptor confirmInterceptor;
	
	public WebMvcConfiguration(ConfirmInterceptor confirmInterceptor) {
		this.confirmInterceptor = confirmInterceptor;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(confirmInterceptor).addPathPatterns(patterns);
		registry.addInterceptor(confirmInterceptor)
        .addPathPatterns(patterns)
        .excludePathPatterns(excludePatterns);
	}

	@Override
	public void addCorsMappings(CorsRegistry registry) {
		// TODO Auto-generated method stub
		WebMvcConfigurer.super.addCorsMappings(registry);
	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("index");
	}
	
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/hotplace/image/**")
                .addResourceLocations("file:///C:/trip/upload/hotplace/");
    }
	
}
