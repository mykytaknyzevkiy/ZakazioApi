package com.zakaion.api.bean

import com.zakaion.api.convertor.DateToString
import com.zakaion.api.convertor.StringToOrderStatus
import com.zakaion.api.convertor.StringToUserStatus
import org.springframework.context.annotation.Configuration
import org.springframework.format.FormatterRegistry
import org.springframework.http.converter.HttpMessageConverter
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter
import org.springframework.http.converter.xml.MappingJackson2XmlHttpMessageConverter
import org.springframework.web.servlet.config.annotation.EnableWebMvc
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer
import java.text.SimpleDateFormat


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
        registry.addConverter(DateToString())
        super.addFormatters(registry)
    }

    override fun configureMessageConverters(converters: MutableList<HttpMessageConverter<*>>) {
        val builder = Jackson2ObjectMapperBuilder()
        builder.indentOutput(true).dateFormat(SimpleDateFormat("yyyy-MM-dd HH:mm"))
        converters.add(MappingJackson2HttpMessageConverter(builder.build()))
//        converters.add(MappingJackson2XmlHttpMessageConverter(builder.createXmlMapper(true).build()))
    }

}