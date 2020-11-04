package com.zakaion.api.bean

import com.zakaion.api.appVersion
import org.springframework.boot.info.BuildProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class DoStart(private val buildProperties: BuildProperties) {

    @Bean
    fun start() {
        appVersion = buildProperties.version
        println("Start app version $appVersion")
    }

}