package com.zakaion.api.bean

import com.zakaion.api.convertor.StringToOrderStatus
import com.zakaion.api.convertor.StringToUserStatus
import org.springframework.context.annotation.Configuration
import org.springframework.format.FormatterRegistry
import org.springframework.web.servlet.config.annotation.CorsRegistry
import org.springframework.web.servlet.config.annotation.EnableWebMvc
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer

@Configuration
@EnableWebMvc
class WebConfig : WebMvcConfigurer {

    /*override fun addCorsMappings(registry: CorsRegistry) {
        registry.addMapping("/api/v1/user/login")
            .allowedOrigins("https://crm.zakazy.online")
    }*/

    override fun addFormatters(registry: FormatterRegistry) {
        registry.addConverter(StringToUserStatus())
        registry.addConverter(StringToOrderStatus())
    }

}