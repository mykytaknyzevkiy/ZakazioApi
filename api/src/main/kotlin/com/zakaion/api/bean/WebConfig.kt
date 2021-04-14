package com.zakaion.api.bean

import com.zakaion.api.convertor.StringToOrderStatus
import com.zakaion.api.convertor.StringToUserStatus
import org.springframework.context.annotation.Configuration
import org.springframework.format.FormatterRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer

@Configuration
class WebConfig : WebMvcConfigurer {

    override fun addFormatters(registry: FormatterRegistry) {
        registry.addConverter(StringToUserStatus())
        registry.addConverter(StringToOrderStatus())
        super.addFormatters(registry)
    }

}