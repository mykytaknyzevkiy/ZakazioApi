package com.zakaion.api.bean

import org.springframework.context.annotation.Configuration
import org.springframework.format.FormatterRegistrar
import org.springframework.format.FormatterRegistry
import org.springframework.format.datetime.DateFormatter

@Configuration
class DateFormatterRegistrar : FormatterRegistrar {
    override fun registerFormatters(registry: FormatterRegistry) {
        registry.addFormatter(DateFormatter("yyyy-MM-dd HH:mm"));
    }
}